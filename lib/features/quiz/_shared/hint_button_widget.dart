import 'package:flutter/material.dart';

/// Nút gợi ý có giới hạn số lần dùng.
/// Hiện badge đếm ngược, vô hiệu hoá khi hết lượt.
class HintButtonWidget extends StatefulWidget {
  final int maxHints;
  final VoidCallback onHint;
  final String? label;

  const HintButtonWidget({
    required this.onHint,
    this.maxHints = 1,
    this.label,
    super.key,
  });

  @override
  State<HintButtonWidget> createState() => _HintButtonWidgetState();
}

class _HintButtonWidgetState extends State<HintButtonWidget> {
  int _used = 0;

  bool get _canHint => _used < widget.maxHints;

  void _onTap() {
    if (!_canHint) return;
    setState(() => _used++);
    widget.onHint();
  }

  @override
  Widget build(BuildContext context) {
    final remaining = widget.maxHints - _used;

    return Tooltip(
      message: _canHint ? 'Gợi ý (còn $remaining lượt)' : 'Hết lượt gợi ý',
      child: InkWell(
        onTap: _canHint ? _onTap : null,
        borderRadius: BorderRadius.circular(20),
        child: AnimatedOpacity(
          opacity: _canHint ? 1.0 : 0.4,
          duration: const Duration(milliseconds: 200),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: _canHint ? const Color(0xFFFAEEDA) : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _canHint
                    ? const Color(0xFFEF9F27)
                    : Colors.grey.shade300,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.lightbulb_outline_rounded,
                  size: 16,
                  color: _canHint ? const Color(0xFFEF9F27) : Colors.grey,
                ),
                const SizedBox(width: 5),
                Text(
                  widget.label ?? 'Gợi ý',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: _canHint ? const Color(0xFF633806) : Colors.grey,
                  ),
                ),
                if (widget.maxHints > 1) ...[
                  const SizedBox(width: 5),
                  Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: _canHint
                          ? const Color(0xFFEF9F27)
                          : Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$remaining',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
