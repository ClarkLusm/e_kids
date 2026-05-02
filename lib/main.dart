import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Load .env trước tiên
  await dotenv.load(fileName: '.env');

  // 2. Khởi tạo Hive (local cache)
  await Hive.initFlutter();
  Hive.registerAdapter(QuestionHiveAdapter());
  Hive.registerAdapter(LessonProgressHiveAdapter());

  // 3. Khởi tạo Supabase
  await Supabase.initialize(
    url: Env.supabaseUrl,
    anonKey: Env.supabaseAnonKey,
  );

  // 4. Khoá portrait mode
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const ProviderScope(child: App()));
}