import 'dart:convert';
import 'package:http/http.dart' as http;
import 'prompts.dart';

/// Gemini AI helper for fetching text responses
class GeminiAI {
  final String apiKey;

  static const String endpoint =
      'https://generativelanguage.googleapis.com/v1beta/models/'
      'gemma-3-27b-it:generateContent';

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
          'maxOutputTokens': 5000,
        }
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Gemini API error: ${response.body}');
    }

    final data = jsonDecode(response.body);
    return data['candidates']?[0]?['content']?['parts']?[0]?['text'] ?? '';
  }

  /// Fetch full AI data (definition, examples, synonyms) in one request
  Future<Map<String, dynamic>> fetchPhraseFullData({
    required String phrase,
    required String language,
  }) async {
    final prompt = phraseFullDataPrompt(phrase, language);
    final raw = await _callGemini(prompt);

    try {
      final jsonString = extractFirstJsonObject(raw);
      final parsed = jsonDecode(jsonString);

      // Ensure proper types
      final definition = parsed['definition']?.toString() ?? '';
      final examples = (parsed['examples'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList();
      final synonyms = (parsed['synonyms'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList();

      return {
        'definition': definition,
        'examples': examples,
        'synonyms': synonyms,
      };
    } catch (e) {
      print('Error parsing AI JSON: $e\nRaw response:\n$raw');
      return {
        'definition': '',
        'examples': [],
        'synonyms': [],
      };
    }
  }
}

/// Extracts the first JSON object from a string
String extractFirstJsonObject(String input) {
  int braceCount = 0;
  int startIndex = -1;
  int endIndex = -1;

  for (int i = 0; i < input.length; i++) {
    if (input[i] == '{') {
      if (braceCount == 0) startIndex = i;
      braceCount++;
    } else if (input[i] == '}') {
      braceCount--;
      if (braceCount == 0) {
        endIndex = i;
        break;
      }
    }
  }

  if (startIndex != -1 && endIndex != -1) {
    return input.substring(startIndex, endIndex + 1);
  }

  throw FormatException('No JSON object found in input');
}
