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
    _NavData(Icons.home, 'Trang chủ'),
    _NavData(Icons.menu_book, 'Học'),
    _NavData(Icons.sports_esports, 'Chơi'),
    _NavData(Icons.person, 'Tôi'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(48)),
        border: const Border(
          top: BorderSide(color: Color(0xFFDBEAFE), width: 4),
        ),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 20)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(_items.length, (i) {
          final active = i == currentIndex;
          return GestureDetector(
            onTap: () => onTap(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(
                horizontal: active ? 24 : 8,
                vertical: active ? 12 : 8,
              ),
              transform: Matrix4.translationValues(0, active ? -16 : 0, 0),
              decoration: BoxDecoration(
                color: active ? const Color(0xFFEAB308) : Colors.transparent,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: active ? const Color(0xFFFDE047) : Colors.transparent,
                  width: 2,
                ),
                boxShadow: active
                    ? const [BoxShadow(color: Colors.black26, blurRadius: 8)]
                    : [],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _items[i].icon,
                    size: 28,
                    color: active ? const Color(0xFF1E293B) : Colors.grey,
                  ),
                  Text(
                    _items[i].label,
                    style: TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 12,
                      fontWeight: active ? FontWeight.w900 : FontWeight.bold,
                      color: active ? const Color(0xFF1E293B) : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _NavData {
  final IconData icon;
  final String label;
  const _NavData(this.icon, this.label);
}
