import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:e_kids/core/widgets/app_bottom_nav.dart';
import 'package:e_kids/features/home/presentation/screens/home_screen.dart';
import 'package:e_kids/features/lesson/presentation/screens/lesson_detail_screen.dart';
import 'package:e_kids/features/lesson/presentation/screens/quiz_runner_screen.dart';
import 'package:e_kids/core/router/app_routes.dart';
import 'package:e_kids/features/auth/presentation/screens/login_screen.dart';
import 'package:e_kids/features/auth/presentation/screens/register_screen.dart';
import 'package:e_kids/features/auth/presentation/screens/select_profile_screen.dart';
import 'package:e_kids/features/placement/presentation/providers/placement_providers.dart';
import 'package:e_kids/features/placement/domain/models/placement_result.dart';
import 'package:e_kids/features/placement/presentation/screens/placement_intro_screen.dart';
import 'package:e_kids/features/placement/presentation/screens/placement_result_screen.dart';
import 'package:e_kids/features/placement/presentation/screens/placement_test_screen.dart';
import 'package:e_kids/features/parent_dashboard/presentation/screens/parent_dashboard_screen.dart';
import 'package:e_kids/features/parent_dashboard/presentation/screens/parent_pin_screen.dart';
import 'package:e_kids/features/parent_dashboard/presentation/screens/skill_goal_settings_screen.dart';
import 'package:e_kids/features/profile/presentation/screens/profile_screen.dart';
import 'package:e_kids/features/splash/presentation/screens/splash_screen.dart';
import 'package:e_kids/features/settings/presentation/screens/settings_screen.dart';
import 'package:e_kids/features/auth/presentation/providers/auth_providers.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  final hasActiveLearningPath = ref.watch(hasActiveLearningPathProvider);

  // key để push màn full-screen ra ngoài shell
  final rootNavigatorKey = GlobalKey<NavigatorState>();
  final shellNavigatorKey = GlobalKey<NavigatorState>();

  return GoRouter(
    initialLocation: Routes.splash,
    navigatorKey: rootNavigatorKey,
    redirect: (ctx, state) {
      if (authState.isLoading) {
        return state.matchedLocation == Routes.splash ? null : Routes.splash;
      }

      final user = authState.valueOrNull;
      final hasLocalProfile = user?.hasSelectedProfile == true;
      final onSelectProfile = state.matchedLocation == Routes.selectProfile;
      final onAuth = state.matchedLocation.startsWith('/auth');
      final onSplash = state.matchedLocation == Routes.splash;
      final onPlacement = state.matchedLocation.startsWith('/placement');
      final onPlacementResult = state.matchedLocation == Routes.placementResult;

      if (!hasLocalProfile && !onSelectProfile) {
        return Routes.selectProfile;
      }

      if (hasLocalProfile && hasActiveLearningPath.isLoading) {
        return null;
      }

      final hasPath = hasActiveLearningPath.valueOrNull == true;

      if (hasLocalProfile && !hasPath && !onPlacement) {
        return Routes.placementIntro;
      }

      if (hasLocalProfile &&
          hasPath &&
          (onSplash ||
              onSelectProfile ||
              onAuth ||
              (onPlacement && !onPlacementResult))) {
        return Routes.home;
      }

      return null;
    },
    routes: [
      GoRoute(path: Routes.splash, builder: (_, __) => const SplashScreen()),
      GoRoute(path: Routes.login, builder: (_, __) => const LoginScreen()),
      GoRoute(
        path: Routes.register,
        builder: (_, __) => const RegisterScreen(),
      ),
      GoRoute(
        path: Routes.selectProfile,
        builder: (_, __) => const SelectProfileScreen(),
      ),
      GoRoute(
        path: Routes.placementIntro,
        builder: (_, __) => const PlacementIntroScreen(),
      ),
      GoRoute(
        path: Routes.placementTest,
        builder: (_, __) => const PlacementTestScreen(),
      ),
      GoRoute(
        path: Routes.placementResult,
        builder: (_, state) => PlacementResultScreen(
          result: state.extra is PlacementResult
              ? state.extra as PlacementResult
              : null,
        ),
      ),

      GoRoute(
        path: '/lesson/:lessonId',
        builder: (_, state) =>
            LessonDetailScreen(lessonId: state.pathParameters['lessonId']!),
        routes: [
          GoRoute(
            path: 'quiz/:questionId',
            builder: (_, state) =>
                QuizRunnerScreen(lessonId: state.pathParameters['lessonId']!),
          ),
        ],
      ),
      GoRoute(
        path: Routes.achievements,
        builder: (_, __) =>
            const _LocalPlaceholderScreen(title: 'Achievements'),
      ),
      GoRoute(
        path: Routes.leaderboard,
        builder: (_, __) => const _LocalPlaceholderScreen(title: 'Leaderboard'),
      ),
      GoRoute(
        path: Routes.parentPin,
        builder: (_, __) => const ParentPinScreen(),
      ),
      GoRoute(
        path: Routes.parentDashboard,
        builder: (_, __) => const ParentDashboardScreen(),
      ),
      GoRoute(
        path: Routes.parentSkillGoals,
        builder: (_, __) => const SkillGoalSettingsScreen(),
      ),
      GoRoute(
        path: Routes.settings,
        builder: (_, __) => const SettingsScreen(),
      ),

      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) {
          // xác định tab đang active
          final loc = state.matchedLocation;
          int index = 0;
          if (loc.startsWith('/learn')) {
            index = 1;
          } else if (loc.startsWith('/play')) {
            index = 2;
          } else if (loc.startsWith(Routes.achievements)) {
            index = 3;
          } else if (loc.startsWith(Routes.profile)) {
            index = 4;
          }

          return Scaffold(
            body: child,
            bottomNavigationBar: AppBottomNav(
              currentIndex: index,
              onTap: (i) {
                switch (i) {
                  case 0:
                    context.go(Routes.home);
                    break;
                  case 1:
                    context.go('/learn');
                    break;
                  case 2:
                    context.go('/play');
                    break;
                  case 3:
                    context.go(Routes.achievements);
                    break;
                  case 4:
                    context.go(Routes.profile);
                    break;
                }
              },
            ),
          );
        },
        routes: [
          GoRoute(path: Routes.home, builder: (_, __) => const HomeScreen()),
          GoRoute(
            path: '/learn',
            builder: (_, __) => const _LocalPlaceholderScreen(title: 'Learn'),
          ),
          GoRoute(
            path: '/play',
            builder: (_, __) => const _LocalPlaceholderScreen(title: 'Play'),
          ),
          GoRoute(
            path: Routes.profile,
            builder: (_, __) => const ProfileScreen(),
          ),
        ],
      ),
    ],
  );
});

class _LocalPlaceholderScreen extends StatelessWidget {
  const _LocalPlaceholderScreen({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    // TODO(ui): thay bằng screen thật ở phase hoàn thiện từng feature.
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('$title đang được chuẩn bị cho phase local.')),
    );
  }
}
