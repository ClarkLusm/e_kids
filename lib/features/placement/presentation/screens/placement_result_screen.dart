import 'package:e_kids/core/router/app_routes.dart';
import 'package:e_kids/features/placement/domain/models/placement_result.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PlacementResultScreen extends StatelessWidget {
  const PlacementResultScreen({super.key, required this.result});

  final PlacementResult? result;

  @override
  Widget build(BuildContext context) {
    final r = result;

    if (r == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Kết quả khảo sát')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Chưa có kết quả khảo sát để hiển thị.'),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => context.go(Routes.home),
                  child: const Text('Vào trang học'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Kết quả khảo sát')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 112,
                      height: 112,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFFFE08A),
                      ),
                      alignment: Alignment.center,
                      child: const Text('⭐', style: TextStyle(fontSize: 54)),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Bé đang ở mức',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      r.levelLabel,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      r.levelDescription,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black54,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 28),
                    _ResultCard(result: r),
                  ],
                ),
              ),
              FilledButton(
                onPressed: () => context.go(Routes.home),
                child: const Text('Bắt đầu lộ trình'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.result});

  final PlacementResult result;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF7FF),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFB6E4FF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🧭', style: TextStyle(fontSize: 28)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  result.pathTitle,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            result.pathDescription,
            style: const TextStyle(color: Colors.black54, height: 1.35),
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              minHeight: 10,
              value: result.scoreRatio.clamp(0.0, 1.0).toDouble(),
              backgroundColor: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Kết quả khảo sát: ${result.score}/${result.maxScore} câu đúng',
            style: TextStyle(
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
