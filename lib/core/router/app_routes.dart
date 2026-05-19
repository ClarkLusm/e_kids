abstract final class Routes {
  static const splash = '/';
  static const login = '/auth/login';
  static const register = '/auth/register';
  static const selectProfile = '/profile/select';
  static const placementIntro = '/placement';
  static const placementTest = '/placement/test';
  static const placementResult = '/placement/result';
  static const home = '/home';
  static const missionBrief = '/mission/brief';
  static const missionWarmUp = '/mission/warm-up';
  static const missionActivity = '/mission/activity';
  static const missionResult = '/mission/result';
  static const profile = '/profile';
  static const achievements = '/achievements';
  static const leaderboard = '/leaderboard';
  static const parentPin = '/parent/pin';
  static const parentDashboard = '/parent';
  static const parentSkillGoals = '/parent/skill-goals';
  static const settings = '/settings';

  static String lesson(String id) => '/lesson/$id';
  static String quiz(String lessonId, String qId) =>
      '/lesson/$lessonId/quiz/$qId';
}
