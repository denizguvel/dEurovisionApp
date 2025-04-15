import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final class AppFunctions {
  AppFunctions._();
  static final AppFunctions instance = AppFunctions._();
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
    try {
      await dotenv.load(fileName: ".env");
    } catch (e) {
      throw Exception('Error loading .env file: $e');
    }
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }
}