import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get apiUrl => dotenv.env['SUPABASE_URL'] ?? 'URL not found';
  static String get apiKey => dotenv.env['SUPABASE_ANON_KEY'] ?? 'API Key not found';
}