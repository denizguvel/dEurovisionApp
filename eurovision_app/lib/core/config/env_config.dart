import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static String get apiKey => dotenv.env['CAT_API_KEY'] ?? '';
  static String get apiBaseUrl => dotenv.env['CAT_API_BASE_URL'] ?? '';
  static String get eurovisionBaseUrl => dotenv.env['EUROVISION_API_BASE_URL'] ?? '';
}