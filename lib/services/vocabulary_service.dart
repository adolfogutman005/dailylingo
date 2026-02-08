import 'package:dailylingo/ai/gemini_ai.dart';

import '../data/database/app_database.dart';
import '../data/repositories/vocabulary_repository.dart';
import '../vocabulary/models/vocabulary_item.dart';

class VocabularyService {
  late final VocabularyRepository _repo;

  VocabularyService(AppDatabase db) {
    _repo = VocabularyRepository(db,
        ai: GeminiAI(apiKey: "AIzaSyAnmU3TTabtOMlnEc4MmRR7GYFmkP5jREo"));
  }

  Future<void> saveVocabulary({
    required String text,
    required String source,
    required String sourceLang,
    required String targetLang,
  }) async {
    if (text.trim().isEmpty) return;

    await _repo.insertVocabulary(
      text: text,
      source: source,
      sourceLang: sourceLang,
      targetLang: targetLang,
    );

    print("VocabularyService.saveFromTranslator finished saving: $text");
  }

  Future<void> deleteWord(int wordId) async {
    print("[VocabularyService] deleteWord called for wordId: $wordId");
    await _repo.deleteWord(wordId);
  }

  Stream<List<VocabularyItem>> watchVocabulary() {
    print("VocabularyService.watchVocabulary called");

    return _repo.watchAllVocabulary();
  }

  Future<void> debugPrintAllWords() async {
    print("[VocabularyService] debugPrintAllWords called");
    await _repo.debugPrintAllWords();
  }
}
