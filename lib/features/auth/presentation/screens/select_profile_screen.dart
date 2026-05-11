import 'package:e_kids/core/router/app_routes.dart';
import 'package:e_kids/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SelectProfileScreen extends ConsumerStatefulWidget {
  const SelectProfileScreen({super.key});

  @override
  ConsumerState<SelectProfileScreen> createState() =>
      _SelectProfileScreenState();
}

class _SelectProfileScreenState extends ConsumerState<SelectProfileScreen> {
  final _nameCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _selectedAvatarId = _avatars.first.id;
  bool _hydrated = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final actionState = ref.watch(authActionControllerProvider);
    final user = ref.watch(authStateProvider).valueOrNull;

    if (!_hydrated && user != null) {
      _hydrated = true;
      _nameCtrl.text = user.displayName ?? '';
      _selectedAvatarId = user.avatarId ?? _avatars.first.id;
    }

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
      appBar: AppBar(title: const Text('Chọn nhân vật')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Chọn bạn đồng hành và nhập tên của bé để bắt đầu.',
                  style: TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Nhân vật',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: _avatars.map((avatar) {
                    final selected = avatar.id == _selectedAvatarId;
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedAvatarId = avatar.id;
                        });
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        width: 88,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: selected
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey.shade300,
                            width: selected ? 2 : 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              avatar.emoji,
                              style: const TextStyle(fontSize: 30),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              avatar.label,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Tên của bé',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    final v = value?.trim() ?? '';
                    if (v.length < 2) return 'Tên tối thiểu 2 ký tự';
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: actionState.isLoading ? null : _onSave,
                  child: actionState.isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Bắt đầu học'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onSave() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      await ref
          .read(authActionControllerProvider.notifier)
          .saveProfile(
            displayName: _nameCtrl.text.trim(),
            avatarId: _selectedAvatarId,
          );
      if (!mounted) return;
      context.go(Routes.home);
    } catch (_) {
      // lỗi đã được listen và show snackbar
    }
  }

  String _errorMessage(Object error) {
    return error.toString();
  }
}

class _AvatarOption {
  final String id;
  final String label;
  final String emoji;

  const _AvatarOption({
    required this.id,
    required this.label,
    required this.emoji,
  });
}

const List<_AvatarOption> _avatars = [
  _AvatarOption(id: 'lion', label: 'Lion', emoji: '🦁'),
  _AvatarOption(id: 'rabbit', label: 'Rabbit', emoji: '🐰'),
  _AvatarOption(id: 'cat', label: 'Cat', emoji: '🐱'),
  _AvatarOption(id: 'panda', label: 'Panda', emoji: '🐼'),
  _AvatarOption(id: 'fox', label: 'Fox', emoji: '🦊'),
  _AvatarOption(id: 'bear', label: 'Bear', emoji: '🐻'),
];
