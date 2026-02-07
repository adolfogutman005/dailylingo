import '../data/database/app_database.dart';
import '../data/repositories/vocabulary_repository.dart';
import '../vocabulary/models/vocabulary_item.dart';

class VocabularyService {
  late final VocabularyRepository _repo;

  VocabularyService(AppDatabase db) {
    _repo = VocabularyRepository(db);
  }

  Future<void> debugPrintAllWords() async {
    print("[VocabularyService] debugPrintAllWords called");
    await _repo.debugPrintAllWords();
  }

  Future<void> saveFromTranslator({
    required String text,
    required String sourceLang,
    required String targetLang,
    required String translatedText,
  }) async {
    if (text.trim().isEmpty || translatedText.trim().isEmpty) return;

    await _repo.insertFromTranslator(
      text: text,
      sourceLang: sourceLang,
      targetLang: targetLang,
      translatedText: translatedText,
    );

    print("VocabularyService.saveFromTranslator finished saving: $text");
  }

  Stream<List<VocabularyItem>> watchVocabulary() {
    print("VocabularyService.watchVocabulary called");

    return _repo.watchAllVocabulary();
  }
}
