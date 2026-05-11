import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:e_kids/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Phase local: chưa cần khởi tạo Supabase/Hive adapters để app chạy offline.
  // TODO(api): load .env và Supabase.initialize khi chuyển auth/backend sang API.
  // TODO(local-cache): đăng ký Hive adapters sau khi có generated adapters.

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const ProviderScope(child: App()));
}
