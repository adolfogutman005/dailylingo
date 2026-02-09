import 'package:dailylingo/ai/gemini_ai.dart';

import '../data/database/app_database.dart';
import '../data/repositories/vocabulary_repository.dart';
import '../vocabulary/models/vocabulary_item.dart';
import '../translator_service.dart';
import '../journaling/models/journal_feedback_model.dart';
import '../journaling/models/feedback_data.dart';
import '../exercises/models/grammar_feedback.dart';
import '../exercises/models/grammar_multiple_choice.dart';

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

  Future<Map<String, dynamic>> getFillInTheBlankData(int wordId) async {
    final word = await getWordText(wordId);

    // You may later fetch language from DB if needed
    const language = 'English';

    return _repo.generateFillInTheBlank(
      word: word,
      language: language,
    );
  }

  Future<JournalFeedback> getFeedback({
    required String journalText,
  }) {
    return _repo.getFeedback(
      journalText: journalText,
    );
  }

  Future<List<String>> getAllGrammarConcepts() async {
    return await _repo.getAllGrammarConcepts();
  }

  Future<int> saveJournal(FeedbackData feedback,
      {bool saveFeedback = true}) async {
    final journalId = await _repo.saveJournal(
      title: feedback.title,
      originalContent: feedback.originalContent,
      correctedContent: feedback.correctedContent,
    );

    if (saveFeedback) {
      await _repo.saveCorrections(journalId, feedback.corrections);
      await _repo.saveConcepts(journalId, feedback.conceptsLearned);
    }

    return journalId;
  }

  Future<GrammarFeedback> checkGrammar({
    required String concept,
    required String sentence,
  }) async {
    if (sentence.trim().isEmpty) {
      return GrammarFeedback(
        isCorrect: false,
        correctedSentence: '',
        explanations: ['You did not write a sentence.'],
      );
    }

    return _repo.checkGrammar(
      concept: concept,
      sentence: sentence,
    );
  }

  Future<GrammarMultipleChoiceResult> getGrammarMultipleChoice(
    String concept,
  ) async {
    return _repo.generateGrammarMultipleChoice(concept);
  }

  Future<void> debugPrintAllWords() async {
    print("[VocabularyService] debugPrintAllWords called");
    await _repo.debugPrintAllWords();
  }
}
