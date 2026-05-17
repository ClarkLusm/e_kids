import 'package:flutter/material.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const _items = [
    _NavData('🐶', 'Home'),
    _NavData('🐼', 'Learn'),
    _NavData('🧢', 'Quiz'),
    _NavData('🏆', 'Rewards'),
    _NavData('🧙', 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 104,
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 18),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF05A7F2), Color(0xFF005CA8)],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(34)),
        border: Border(top: BorderSide(color: Color(0xFFFFD22E), width: 4)),
        boxShadow: [
          BoxShadow(
            color: Color(0x55003B7A),
            blurRadius: 18,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(_items.length, (i) {
          final active = i == currentIndex;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onTap(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 3,
                    vertical: 4,
                  ),
                  transform: Matrix4.translationValues(0, active ? -10 : 0, 0),
                  decoration: BoxDecoration(
                    color: active
                        ? const Color(0xFFFFD22E)
                        : Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(22),
                    border: active
                        ? Border.all(color: Colors.white, width: 3)
                        : null,
                    boxShadow: active
                        ? const [
                            BoxShadow(
                              color: Color(0x66003477),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ]
                        : const [],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _items[i].emoji,
                        style: TextStyle(fontSize: active ? 29 : 25),
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          _items[i].label,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            color: active
                                ? const Color(0xFF073B7A)
                                : Colors.white,
                            shadows: active
                                ? const []
                                : const [
                                    Shadow(
                                      color: Color(0x66000000),
                                      blurRadius: 2,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _NavData {
  final String emoji;
  final String label;
  const _NavData(this.emoji, this.label);
}
