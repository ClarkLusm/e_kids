import 'package:e_kids/core/router/app_routes.dart';
import 'package:e_kids/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final actionState = ref.watch(authActionControllerProvider);

    ref.listen(authActionControllerProvider, (_, next) {
      next.whenOrNull(
        error: (error, _) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(_errorMessage(error))));
        },
      );
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Tạo tài khoản')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 12),
                const Text(
                  'Đăng ký để bắt đầu học',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Tạo tài khoản phụ huynh, sau đó chọn profile cho bé.',
                  style: TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    final v = value?.trim() ?? '';
                    if (v.isEmpty) return 'Vui lòng nhập email';
                    if (!v.contains('@')) return 'Email chưa hợp lệ';
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _passwordCtrl,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Mật khẩu',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () => setState(() {
                        _obscurePassword = !_obscurePassword;
                      }),
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                    ),
                  ),
                  validator: (value) {
                    final v = value ?? '';
                    if (v.length < 6) return 'Mật khẩu tối thiểu 6 ký tự';
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _confirmCtrl,
                  obscureText: _obscureConfirm,
                  decoration: InputDecoration(
                    labelText: 'Nhập lại mật khẩu',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () => setState(() {
                        _obscureConfirm = !_obscureConfirm;
                      }),
                      icon: Icon(
                        _obscureConfirm
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value != _passwordCtrl.text) {
                      return 'Mật khẩu nhập lại chưa khớp';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: actionState.isLoading ? null : _onRegister,
                  child: actionState.isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Đăng ký'),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: actionState.isLoading
                      ? null
                      : () => context.go(Routes.login),
                  child: const Text('Đã có tài khoản? Đăng nhập'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onRegister() async {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailCtrl.text.trim();
    final password = _passwordCtrl.text;

    try {
      final hasSession = await ref
          .read(authActionControllerProvider.notifier)
          .signUp(email: email, password: password);

      if (!mounted) return;

      if (hasSession) {
        context.go(Routes.selectProfile);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Đăng ký thành công. Vui lòng xác thực email rồi đăng nhập lại.',
            ),
          ),
        );
        context.go(Routes.login);
      }
    } catch (_) {
      // lỗi đã được listen và show snackbar
    }
  }

  String _errorMessage(Object error) {
    if (error is AuthException) return error.message;
    return error.toString();
  }
}
