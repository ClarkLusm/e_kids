import 'package:e_kids/core/router/app_routes.dart';
import 'package:e_kids/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  static const background = Color(0xFFF6F6F6);
  static const onSurface = Color(0xFF2D2F2F);
  static const onSurfaceVariant = Color(0xFF5A5C5C);
  static const surfaceLowest = Colors.white;
  static const surfaceContainerLow = Color(0xFFF0F1F1);
  static const secondaryContainer = Color(0xFF97DAFF);
  static const primaryContainer = Color(0xFFFFD709);
  static const onPrimaryFixed = Color(0xFF453900);

  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
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
      backgroundColor: background,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 256,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    secondaryContainer.withValues(alpha: 0.45),
                    surfaceContainerLow,
                    background,
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 24),
                    const Text(
                      'Đăng nhập',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: onSurface,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Phụ huynh đăng nhập để tiếp tục hành trình học của bé.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Lexend',
                        fontSize: 16,
                        color: onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 28),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: surfaceLowest,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: onSurface.withValues(alpha: 0.08),
                            blurRadius: 24,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
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
                          const SizedBox(height: 14),
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
                              if (v.length < 6) {
                                return 'Mật khẩu tối thiểu 6 ký tự';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: actionState.isLoading ? null : _onLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryContainer,
                          foregroundColor: onPrimaryFixed,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                        child: actionState.isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Đăng nhập',
                                style: TextStyle(
                                  fontFamily: 'PlusJakartaSans',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: actionState.isLoading
                          ? null
                          : () => context.go(Routes.register),
                      child: const Text('Chưa có tài khoản? Tạo tài khoản mới'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onLogin() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      await ref
          .read(authActionControllerProvider.notifier)
          .signIn(email: _emailCtrl.text.trim(), password: _passwordCtrl.text);

      if (!mounted) return;

      final user = ref.read(authRepositoryProvider).currentUser;
      final hasProfileName = user?.hasSelectedProfile == true;

      if (hasProfileName) {
        context.go(Routes.home);
      } else {
        context.go(Routes.selectProfile);
      }
    } catch (_) {
      // error đã show bằng ref.listen
    }
  }

  String _errorMessage(Object error) {
    if (error is AuthException) return error.message;
    return error.toString();
  }
}
