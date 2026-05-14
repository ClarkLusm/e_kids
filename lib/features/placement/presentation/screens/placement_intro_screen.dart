import 'package:e_kids/core/router/app_routes.dart';
import 'package:e_kids/features/placement/presentation/providers/placement_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PlacementIntroScreen extends ConsumerWidget {
  const PlacementIntroScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actionState = ref.watch(placementActionControllerProvider);

    ref.listen(placementActionControllerProvider, (_, next) {
      next.whenOrNull(
        error: (error, _) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error.toString())));
        },
      );
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Chọn lộ trình')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3D6),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('🚀', style: TextStyle(fontSize: 42)),
                    SizedBox(height: 12),
                    Text(
                      'Khảo sát nhanh để chọn lộ trình phù hợp',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Bé trả lời 5 câu đơn giản. App sẽ chọn lộ trình dễ học nhất theo kết quả.',
                      style: TextStyle(color: Colors.black54, height: 1.4),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: actionState.isLoading
                    ? null
                    : () => context.go(Routes.placementTest),
                child: const Text('Làm khảo sát nhanh'),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: actionState.isLoading
                    ? null
                    : () => _skipPlacement(context, ref),
                child: actionState.isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Bỏ qua, dùng lộ trình mặc định'),
              ),
              const Spacer(),
              const Text(
                'Có thể đổi lộ trình sau ở màn phụ huynh khi tính năng này hoàn thiện.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black45, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _skipPlacement(BuildContext context, WidgetRef ref) async {
    try {
      await ref
          .read(placementActionControllerProvider.notifier)
          .skipPlacement();
      if (context.mounted) context.go(Routes.home);
    } catch (_) {
      // Error is shown by ref.listen above.
    }
  }
}
