import 'package:e_kids/core/router/app_routes.dart';
import 'package:e_kids/features/parent_dashboard/data/local/parent_pin_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const parentPinLength = 6;

enum _PinMode { loading, create, confirm, unlock }

class ParentPinScreen extends StatefulWidget {
  const ParentPinScreen({super.key});

  @override
  State<ParentPinScreen> createState() => _ParentPinScreenState();
}

class _ParentPinScreenState extends State<ParentPinScreen> {
  static const _accent = Color(0xFF006B8A);
  static const _text = Color(0xFF202426);
  static const _keyBg = Color(0xFFEFF0F0);

  final _pinStorage = ParentPinStorage();
  final _digits = <String>[];
  _PinMode _mode = _PinMode.loading;
  String? _savedPin;
  String? _pendingPin;
  String? _message;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadPin();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = _mode == _PinMode.loading;
    final instruction = _message ?? _instructionText;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 18, 24, 28),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 52,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        _RoundIconButton(
                          icon: Icons.arrow_back,
                          onTap: () => context.go(Routes.profile),
                        ),
                        const SizedBox(width: 16),
                        const Text(
                          'Parental Access',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _text,
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.7,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    _PinDots(length: _digits.length, hasError: _hasError),
                    const SizedBox(height: 32),
                    if (instruction != null)
                      Text(
                        instruction,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _hasError
                              ? Colors.red.shade700
                              : Colors.black54,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          height: 1.38,
                        ),
                      ),
                    const SizedBox(height: 32),
                    if (isLoading)
                      const Padding(
                        padding: EdgeInsets.only(top: 80),
                        child: CircularProgressIndicator(color: _accent),
                      )
                    else
                      _Keypad(onDigit: _onDigit, onDelete: _onDelete),
                    const SizedBox(height: 28),
                    if (_mode == _PinMode.unlock)
                      TextButton(
                        onPressed: _showForgotPin,
                        child: const Text(
                          'Forgot PIN?',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String? get _instructionText {
    return switch (_mode) {
      _PinMode.loading => 'Đang kiểm tra mã PIN...',
      _PinMode.create => 'Tạo mã PIN 6 số cho tài khoản ba mẹ.',
      _PinMode.confirm => 'Nhập lại mã PIN để xác nhận.',
      _PinMode.unlock =>
        _hasError ? 'Sai mã PIN. Vui lòng nhập lại.' : null,
    };
  }

  Future<void> _loadPin() async {
    final pin = await _pinStorage.readPin();
    if (!mounted) return;

    setState(() {
      _savedPin = pin?.length == parentPinLength ? pin : null;
      _mode = _savedPin == null ? _PinMode.create : _PinMode.unlock;
    });
  }

  void _onDigit(String digit) {
    if (_mode == _PinMode.loading || _digits.length >= parentPinLength) return;
    setState(() {
      _hasError = false;
      _message = null;
      _digits.add(digit);
    });

    if (_digits.length == parentPinLength) {
      Future<void>.delayed(const Duration(milliseconds: 120), _handleFullPin);
    }
  }

  void _onDelete() {
    if (_digits.isEmpty) return;
    setState(() {
      _hasError = false;
      _message = null;
      _digits.removeLast();
    });
  }

  Future<void> _handleFullPin() async {
    final pin = _digits.join();
    if (!mounted) return;

    switch (_mode) {
      case _PinMode.loading:
        return;
      case _PinMode.create:
        setState(() {
          _pendingPin = pin;
          _digits.clear();
          _hasError = false;
          _mode = _PinMode.confirm;
        });
        return;
      case _PinMode.confirm:
        await _confirmNewPin(pin);
        return;
      case _PinMode.unlock:
        _verifySavedPin(pin);
        return;
    }
  }

  Future<void> _confirmNewPin(String pin) async {
    if (pin != _pendingPin) {
      if (!mounted) return;
      setState(() {
        _digits.clear();
        _pendingPin = null;
        _hasError = true;
        _message = 'PIN xác nhận không khớp. Vui lòng tạo lại mã PIN.';
        _mode = _PinMode.create;
      });
      return;
    }

    await _pinStorage.savePin(pin);
    if (!mounted) return;
    context.go(Routes.parentDashboard);
  }

  void _verifySavedPin(String pin) {
    if (pin == _savedPin) {
      context.go(Routes.parentDashboard);
      return;
    }

    setState(() {
      _digits.clear();
      _hasError = true;
    });
  }

  void _showForgotPin() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Chưa có flow khôi phục PIN. Phase này cần xoá dữ liệu app để tạo lại.',
        ),
      ),
    );
  }
}

class _PinDots extends StatelessWidget {
  const _PinDots({required this.length, required this.hasError});

  final int length;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(parentPinLength, (index) {
        final filled = index < length;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          width: 32,
          height: 32,
          margin: const EdgeInsets.symmetric(horizontal: 7),
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: filled
                  ? (hasError
                        ? Colors.red.shade600
                        : _ParentPinScreenState._accent)
                  : const Color(0xFFDCDDDE),
            ),
            shape: BoxShape.circle,
            boxShadow: filled
                ? const [BoxShadow(color: Color(0x22006B8A), blurRadius: 8)]
                : const [],
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: filled
                  ? (hasError
                        ? Colors.red.shade600
                        : _ParentPinScreenState._accent)
                  : const Color(0xFFDCDDDE),
              boxShadow: filled
                  ? const [BoxShadow(color: Color(0x22006B8A), blurRadius: 8)]
                  : const [],
            ),
          ),
        );
      }),
    );
  }
}

class _Keypad extends StatelessWidget {
  const _Keypad({required this.onDigit, required this.onDelete});

  final ValueChanged<String> onDigit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    const rows = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final keySize = ((constraints.maxWidth - 48) / 3).clamp(60.0, 80.0);
        final gap = ((constraints.maxWidth - keySize * 3) / 2).clamp(
          12.0,
          28.0,
        );

        Row buildRow(List<String> digits) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _NumberKey(digit: digits[0], size: keySize, onTap: onDigit),
              SizedBox(width: gap),
              _NumberKey(digit: digits[1], size: keySize, onTap: onDigit),
              SizedBox(width: gap),
              _NumberKey(digit: digits[2], size: keySize, onTap: onDigit),
            ],
          );
        }

        return Column(
          children: [
            for (final row in rows) ...[
              buildRow(row),
              const SizedBox(height: 20),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: keySize, height: keySize),
                SizedBox(width: gap),
                _NumberKey(digit: '0', size: keySize, onTap: onDigit),
                SizedBox(width: gap),
                SizedBox(
                  width: keySize,
                  height: keySize,
                  child: Center(
                    child: IconButton(
                      onPressed: onDelete,
                      icon: const Icon(Icons.backspace, size: 26),
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _NumberKey extends StatelessWidget {
  const _NumberKey({
    required this.digit,
    required this.size,
    required this.onTap,
  });

  final String digit;
  final double size;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(digit),
      customBorder: const CircleBorder(),
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: _ParentPinScreenState._keyBg,
          shape: BoxShape.circle,
        ),
        child: Text(
          digit,
          style: const TextStyle(
            color: _ParentPinScreenState._text,
            fontSize: 32,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 58,
        height: 58,
        decoration: const BoxDecoration(
          color: _ParentPinScreenState._keyBg,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 28, color: _ParentPinScreenState._text),
      ),
    );
  }
}
