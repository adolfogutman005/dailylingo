import 'dart:convert';
import 'package:http/http.dart' as http;
import 'prompts.dart';

/// Gemini AI helper for fetching text responses
class GeminiAI {
  final String apiKey;

  static const String endpoint =
      'https://generativelanguage.googleapis.com/v1beta/models/'
      'gemini-3-flash-preview:generateContent';

  GeminiAI({required this.apiKey});

  /// Low-level call to Gemini API
  Future<String> _callGemini(String prompt) async {
    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json',
        'x-goog-api-key': apiKey,
      },
      body: jsonEncode({
        'contents': [
          {
            'parts': [
              {'text': prompt}
            ]
          }
        ],
        'generationConfig': {
          'temperature': 0.3,
          'maxOutputTokens': 400,
        }
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Gemini API error: ${response.body}');
    }

    final data = jsonDecode(response.body);

    // Extract plain text safely
    return data['candidates']?[0]?['content']?['parts']?[0]?['text'] ?? '';
  }

  /// Fetch a short explanation for a phrase
  Future<String> fetchPhraseExplanation({
    required String phrase,
    required String language,
  }) async {
    final prompt = phraseDefinitionPrompt(phrase, language);
    final explanation = await _callGemini(prompt);

    // Trim whitespace and return
    return explanation.trim();
  }
}
