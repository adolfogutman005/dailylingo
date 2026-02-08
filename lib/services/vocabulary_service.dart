import 'package:dailylingo/ai/gemini_ai.dart';

import '../data/database/app_database.dart';
import '../data/repositories/vocabulary_repository.dart';
import '../vocabulary/models/vocabulary_item.dart';
import '../translator_service.dart';

class VocabularyService {
  late final VocabularyRepository _repo;
  final TranslationService translator =
      TranslationService(apiKey: "253c4f2b-4394-4dcc-b808-82572df88046:fx");
  VocabularyService(AppDatabase db) {
    _repo = VocabularyRepository(
        db: db,
        ai: GeminiAI(apiKey: "AIzaSyAnmU3TTabtOMlnEc4MmRR7GYFmkP5jREo"),
        translator: translator);
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

  Future<List<int>> getAllWordIds() {
    return _repo.getAllWordIds();
  }

  Future<String> getWordText(int wordId) {
    return _repo.getWordText(wordId);
  }

  Future<String> getPrimaryTranslation(int wordId) {
    return _repo.getPrimaryTranslation(wordId);
  }

  Future<List<String>> getExamples(int wordId) {
    return _repo.getExamples(wordId);
  }

  Future<String?> getDefinition(int wordId) {
    return _repo.getDefinition(wordId);
  }

  Future<WordLearningDataData?> getLearningData(int wordId) {
    return _repo.getLearningData(wordId);
  }

  Future<List<String>> getDefinitionDistractors(int wordId) async {
    final word = await getWordText(wordId);
    final correct = await getDefinition(wordId);

    if (correct == null || correct.isEmpty) {
      return [];
    }

    return _repo.generateDefinitionDistractors(
      word: word,
      correctDefinition: correct,
    );
  }

  Future<void> debugPrintAllWords() async {
    print("[VocabularyService] debugPrintAllWords called");
    await _repo.debugPrintAllWords();
  }
}
