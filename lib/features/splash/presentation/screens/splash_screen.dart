import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  // Màu lấy từ tailwind.config của HTML
  static const _secondaryFixed = Color(0xFF97DAFF);
  static const _tertiaryFixed = Color(0xFFFF928E);
  static const _primaryFixed = Color(0xFFFFD709);
  static const _tertiary = Color(0xFFAA2C32);
  static const _surfaceLowest = Colors.white;
  static const _surfaceVariant = Color(0xFFDBDDDD);

  static const _mascotUrl =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuCOM6Y4crsAZGW6V5JP-PGELuxi6KHuosKPg4FzMqByeXO17TlAFzOwomF_D2sz5jh3r6x1oXuf8G5pTua192xyfk9SlUKqRi2Uwr-MO5UfMRujcX7cbI217bGKTlTyHyo3vFwu98mIT-rPYgJmUuTqZJ0WWKJQ1nJv2KnypuFp7vlY68JXnxzvXoC3Ttvpi1DZDyI8m7tYJ3sO9WGudA4v3dEm-REfJLtOta_Ilf8oK8BhaT3FCEG7fYzvSL8QFfp3Y08WTzCoiDg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_secondaryFixed, _tertiaryFixed],
          ),
        ),
        child: Stack(
          children: [
            // Decorative floating blobs
            Positioned(top: 40, left: 40, child: _blurBlob(64, _surfaceLowest)),
            Positioned(
              top: 160,
              right: 80,
              child: _blurBlob(96, _primaryFixed.withOpacity(0.6)),
            ),
            Positioned(
              bottom: 160,
              left: 80,
              child: _blurBlob(128, _secondaryFixed.withOpacity(0.7)),
            ),

            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const Spacer(flex: 2),
                    // Mascot
                    Container(
                      width: 256,
                      height: 256,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _surfaceLowest.withOpacity(0.2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 32,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Container(
                          width: 224,
                          height: 224,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Image.network(_mascotUrl, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Logo
                    Text(
                      'Wordy',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans', // thêm font vào pubspec
                        fontSize: 48,
                        fontWeight: FontWeight.w800,
                        color: _surfaceLowest,
                        letterSpacing: -0.5,
                        shadows: [
                          Shadow(
                            color: const Color(0xFF006384).withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'The Living Storybook',
                      style: TextStyle(
                        fontFamily: 'Lexend',
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: _surfaceLowest.withOpacity(0.9),
                      ),
                    ),
                    const Spacer(flex: 3),
                    // Loading texts
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Packing your bags...',
                            style: TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: _surfaceLowest,
                              letterSpacing: 0.3,
                            ),
                          ),
                          const Text(
                            '45%',
                            style: TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: _surfaceLowest,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Caterpillar loading bar
                    Container(
                      height: 32,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: _surfaceVariant.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(999),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final progressWidth = constraints.maxWidth * 0.45;
                          return Stack(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 1000),
                                curve: Curves.easeOut,
                                width: progressWidth,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [_primaryFixed, _tertiary],
                                  ),
                                  borderRadius: BorderRadius.circular(999),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(
                                        0xFF6C5A00,
                                      ).withOpacity(0.4),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                left: progressWidth - 22,
                                top: 0,
                                bottom: 0,
                                child: Center(
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: const BoxDecoration(
                                      color: _surfaceLowest,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons
                                          .cruelty_free, // giống material-symbols "cruelty_free"
                                      size: 12,
                                      color: Color(0xFF6C5A00),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 64),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _blurBlob(double size, Color color) {
    return Opacity(
      opacity: 0.4,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}
