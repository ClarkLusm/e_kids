import 'package:e_kids/core/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Colors từ tailwind
  static const primaryContainer = Color(0xFFFFD709);
  static const onPrimaryFixed = Color(0xFF453900);
  static const secondary = Color(0xFF006384);
  static const secondaryContainer = Color(0xFF97DAFF);
  static const tertiaryContainer = Color(0xFFFF928E);
  static const onTertiaryContainer = Color(0xFF69000F);
  static const surface = Color(0xFFF6F6F6);
  static const surfaceLow = Color(0xFFF0F1F1);
  static const surfaceLowest = Colors.white;
  static const surfaceHighest = Color(0xFFDBDDDD);
  static const onSurface = Color(0xFF2D2F2F);
  static const onSurfaceVariant = Color(0xFF5A5C5C);
  static const outlineVariant = Color(0xFFACADAD);

  bool gameSounds = true;
  bool music = false;
  int dailyGoal = 10;
  int selectedColor = 0;

  final avatarUrl =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuDRFg9ZTnkpbmUNDMocP8-ppeI9HXijnBgyVFSmST7NtJT3dHvL6hQZXeOiwZqmuGZ3oGHg5H-XtjJJzGh9K4Q4JLAMsJWYl9vjLrVvC7Vx0pE0vGrOykRz42Nyq97bQPxv7Vxp1-nTeeDt836YHXVMYhu21Nxw6JjuVsxF_Hgj4X3BPuUplb2fPBfXjKuLsqtuO4yTYeId_S6cxlICIMr_jEKi4h83tmtIx_piPDyqlB3Z8WcTxD59qZTTiy-Q86XKhM1eZojk3VY';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: surface,
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF006384), Color(0xFF004D68)],
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(48)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
          ),
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
          alignment: Alignment.center,
          child: SafeArea(
            bottom: false,
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: primaryContainer,
                    size: 28,
                  ),
                ),
                const Expanded(
                  child: Text(
                    'My Magic Box',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 140),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              children: [
                _avatarCard(),
                const SizedBox(height: 24),
                _soundToggles(),
                const SizedBox(height: 24),
                _dailyGoal(),
                const SizedBox(height: 24),
                _themePicker(),
                const SizedBox(height: 24),
                _parentZone(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _bottomNav(),
    );
  }

  Widget _avatarCard() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: surfaceLowest,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: 128,
                    height: 128,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: surfaceHighest, width: 8),
                      color: secondaryContainer,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(avatarUrl, fit: BoxFit.cover),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: primaryContainer,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: Colors.black26, blurRadius: 4),
                        ],
                      ),
                      child: const Icon(
                        Icons.edit,
                        size: 16,
                        color: onPrimaryFixed,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'My Magic Friend',
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: onSurface,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryContainer,
                  foregroundColor: onPrimaryFixed,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                  elevation: 4,
                ),
                child: const Text(
                  'Change Friend',
                  style: TextStyle(
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -16,
          right: -8,
          child: Icon(
            Icons.auto_awesome,
            size: 48,
            color: primaryContainer.withValues(alpha: 0.4),
          ),
        ),
      ],
    );
  }

  Widget _soundToggles() {
    return Row(
      children: [
        Expanded(
          child: _toggleCard(
            icon: Icons.volume_up,
            label: 'Game Sounds',
            color: secondary,
            bg: secondaryContainer,
            value: gameSounds,
            onChanged: (v) => setState(() => gameSounds = v),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _toggleCard(
            icon: Icons.music_note,
            label: 'Music',
            color: onTertiaryContainer,
            bg: tertiaryContainer,
            value: music,
            onChanged: (v) => setState(() => music = v),
          ),
        ),
      ],
    );
  }

  Widget _toggleCard({
    required IconData icon,
    required String label,
    required Color color,
    required Color bg,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: surfaceLowest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
            child: Icon(icon, size: 28, color: color),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => onChanged(!value),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 64,
              height: 32,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: value ? primaryContainer : surfaceHighest,
                borderRadius: BorderRadius.circular(999),
              ),
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dailyGoal() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: surfaceLowest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.schedule, color: Color(0xFF6C5A00)),
              SizedBox(width: 8),
              Text(
                'Daily Goal',
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: surfaceLow,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [5, 10, 15].map((m) {
                final selected = dailyGoal == m;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => dailyGoal = m),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: selected ? primaryContainer : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: selected
                            ? const [
                                BoxShadow(color: Colors.black12, blurRadius: 4),
                              ]
                            : [],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$m mins',
                        style: TextStyle(
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: selected ? onPrimaryFixed : onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _themePicker() {
    final colors = [
      secondaryContainer,
      tertiaryContainer,
      primaryContainer,
      const Color(0xFFA3DEFE),
    ];
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: surfaceLowest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Magic Colors',
            style: TextStyle(
              fontFamily: 'PlusJakartaSans',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(colors.length, (i) {
              final selected = selectedColor == i;
              return GestureDetector(
                onTap: () => setState(() => selectedColor = i),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: colors[i],
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 4),
                      if (selected)
                        BoxShadow(
                          color: colors[i],
                          blurRadius: 0,
                          spreadRadius: 4,
                        ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _parentZone() {
    return InkWell(
      onTap: _openParentZone,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: surfaceHighest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: outlineVariant,
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.lock, color: onSurfaceVariant),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PARENT ZONE',
                    style: TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    'Adults Only Area',
                    style: TextStyle(fontSize: 12, color: onSurfaceVariant),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: onSurfaceVariant),
          ],
        ),
      ),
    );
  }

  void _openParentZone() {
    context.push(Routes.parentPin);
  }

  Widget _bottomNav() {
    return Container(
      margin: const EdgeInsets.only(bottom: 0),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      decoration: BoxDecoration(
        color: secondaryContainer.withValues(alpha: 0.7),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20,
            offset: Offset(0, -10),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(Icons.home, 'HOME', false),
            _navItem(Icons.school, 'LEARN', false),
            _navItem(Icons.videogame_asset, 'PLAY', false),
            _navItem(Icons.face, 'ME', true),
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, bool active) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: active ? 20 : 16,
        vertical: active ? 8 : 6,
      ),
      decoration: BoxDecoration(
        color: active ? primaryContainer : Colors.transparent,
        borderRadius: BorderRadius.circular(999),
        boxShadow: active
            ? const [BoxShadow(color: Colors.black26, blurRadius: 6)]
            : [],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 24,
            color: active ? onPrimaryFixed : secondary,
            fill: active ? 1 : 0,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Lexend',
              fontSize: 10,
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
              color: active ? onPrimaryFixed : secondary,
            ),
          ),
        ],
      ),
    );
  }
}
