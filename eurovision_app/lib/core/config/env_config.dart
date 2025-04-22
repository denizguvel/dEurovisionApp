import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Provides API base URL from environment variables.
/// Reads the EUROVISION_API_BASE_URL key.
class EnvConfig {
  static String get eurovisionBaseUrl => dotenv.env['EUROVISION_API_BASE_URL'] ?? '';
}