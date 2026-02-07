import 'dart:convert';
import 'package:http/http.dart' as http;

class TranslationService {
  final String apiKey;
  TranslationService({required this.apiKey});

  Future<String?> translateText({
    required String text,
    required String targetLang,
    String? sourceLang,
  }) async {
    final url = Uri.parse('https://api-free.deepl.com/v2/translate');

    final body = {
      'text': text,
      'target_lang': targetLang,
    };
    if (sourceLang != null) body['source_lang'] = sourceLang;

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'DeepL-Auth-Key $apiKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['translations'][0]['text'];
      } else {
        print('DeepL error: ${response.statusCode} ${response.body}');
        return null;
      }
    } catch (e) {
      print('Translation request failed: $e');
      return null;
    }
  }
}
