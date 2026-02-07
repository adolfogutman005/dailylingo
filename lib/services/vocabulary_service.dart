import '../data/database/app_database.dart';
import '../data/repositories/vocabulary_repository.dart';

class VocabularyService {
  late final VocabularyRepository _repo;

  VocabularyService(AppDatabase db) {
    _repo = VocabularyRepository(db);
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
  }
}
