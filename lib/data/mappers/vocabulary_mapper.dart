import '../../vocabulary/models/vocabulary_item.dart';
import '../database/app_database.dart';

VocabularyItem mapToVocabularyItem({
  required WordEntry word,
  required Translation translation,
  WordMeaning? meaning,
  List<WordExample> examples = const [],
  List<WordSynonym> synonyms = const [],
  List<WordNote> notes = const [],
  WordLearningDataData? learning,
}) {
  return VocabularyItem(
    id: word.id,
    text: word.wordText,
    language: word.language,
    source: word.source,
    translation: translation.translatedText,
    explanation: meaning?.definition,
    examples: examples.map((e) => e.exampleText).toList(),
    synonyms: synonyms.map((s) => s.synonymText).toList(),
    notes: notes.map((n) => n.noteText).toList(),
    status: learning?.status ?? "new",
    lastReviewed: learning?.lastReviewed,
    timesPracticed: learning?.timesPracticed ?? 0,
    createdAt: word.createdAt,
  );
}
