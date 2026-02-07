import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  final FlutterTts _flutterTts = FlutterTts();

  // Language map
  static const Map<String, String> langCodes = {
    "english": "en-US",
    "spanish": "es-ES",
    "french": "fr-FR",
    "german": "de-DE",
    "portuguese": "pt-PT",
    "italian": "it-IT",
    "chinese": "zh-CN",
    "japanese": "ja-JP",
    "korean": "ko-KR",
    "arabic": "ar-SA",
  };

  // Speak text
  Future<void> speak(String text, String language) async {
    if (text.trim().isEmpty) return;

    final langCode = langCodes[language.toLowerCase()] ?? "en-US";

    await _flutterTts.setLanguage(langCode);
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.speak(text);
  }

  // Stop speaking
  Future<void> stop() async {
    await _flutterTts.stop();
  }
}
