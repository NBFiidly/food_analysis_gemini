import 'package:flutter_dotenv/flutter_dotenv.dart';

String get apiKey {
  final key = dotenv.env['GEMINI_API_KEY'];
  if (key == null || key.isEmpty) {
    throw Exception('GEMINI_API_KEY tidak ditemukan di .env file');
  }
  return key;
}
