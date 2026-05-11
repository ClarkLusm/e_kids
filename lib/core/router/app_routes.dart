abstract final class Routes {
  static const splash = '/';
  static const login = '/auth/login';
  static const register = '/auth/register';
  static const selectProfile = '/profile/select';
  static const home = '/home';
  static const achievements = '/achievements';
  static const leaderboard = '/leaderboard';
  static const parentDashboard = '/parent';
  static const settings = '/settings';

  static String lesson(String id) => '/lesson/$id';
  static String quiz(String lessonId, String qId) =>
      '/lesson/$lessonId/quiz/$qId';
}
