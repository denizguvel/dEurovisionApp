import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static String get eurovisionBaseUrl => dotenv.env['EUROVISION_API_BASE_URL'] ?? '';
}