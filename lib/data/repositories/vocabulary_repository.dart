import '../database/app_database.dart';
import '../mappers/vocabulary_mapper.dart';
import '../../vocabulary/models/vocabulary_item.dart';
import 'package:drift/drift.dart';
import '../../ai/gemini_ai.dart'; // <-- import your GeminiAI class
import '../../translator_service.dart';
import '../../language_codes.dart';

class VocabularyRepository {
  final AppDatabase db;
  final GeminiAI ai;
  final TranslationService translator;

  VocabularyRepository({
    required this.db,
    required this.ai,
    required this.translator,
  });

  Future<int> insertVocabulary({
    required String text,
    required String source,
    required String sourceLang,
    required String targetLang,
  }) async {
    print("Repository: insertVocabulary starting for $text");

    final translatedText = await translator.translateText(
            text: text, targetLang: deeplLangCode(targetLang)) ??
        '';
    print('Fetched translation: $translatedText');

    // Fetch AI data in a single call
    final aiData = await ai.fetchPhraseFullData(
      phrase: text,
      language: sourceLang,
    );
    print('Fetched AI data: $aiData');

    return await db.transaction(() async {
      final wordId = await db.into(db.wordEntries).insert(
            WordEntriesCompanion.insert(
              wordText: text,
              language: sourceLang,
              entryType: text.contains(' ') ? 'phrase' : 'word',
              source: source,
              createdAt: DateTime.now(),
            ),
          );
      print("Inserted word entry with wordId $wordId");

      // Dummy translation
      await db.into(db.translations).insert(
            TranslationsCompanion.insert(
              wordId: wordId,
              language: targetLang,
              translatedText: translatedText,
            ),
          );
      ;

      // Insert AI explanation
      await db.into(db.wordMeanings).insert(
            WordMeaningsCompanion.insert(
              wordId: wordId,
              definition: aiData['definition'] ?? '',
            ),
          );

      // Insert AI examples
      for (final ex in aiData['examples'] ?? []) {
        if (ex.isNotEmpty) {
          await db.into(db.wordExamples).insert(
                WordExamplesCompanion.insert(
                  wordId: wordId,
                  exampleText: ex,
                ),
              );
        }
      }

      // Insert AI synonyms
      for (final syn in aiData['synonyms'] ?? []) {
        if (syn.isNotEmpty) {
          await db.into(db.wordSynonyms).insert(
                WordSynonymsCompanion.insert(
                  wordId: wordId,
                  synonymText: syn,
                ),
              );
        }
      }

      return wordId;
    });
  }

  // --- The rest of your repository remains unchanged ---
  Stream<List<VocabularyItem>> watchAllVocabulary() {
    final query = db.select(db.wordEntries)
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);

    return query.watch().asyncMap((words) async {
      final items = <VocabularyItem>[];

      for (final word in words) {
        final translation = await (db.select(db.translations)
              ..where((t) => t.wordId.equals(word.id)))
            .getSingle();

        final meaning = await (db.select(db.wordMeanings)
              ..where((m) => m.wordId.equals(word.id)))
            .getSingleOrNull();

        final examples = await (db.select(db.wordExamples)
              ..where((e) => e.wordId.equals(word.id)))
            .get();

        final synonyms = await (db.select(db.wordSynonyms)
              ..where((s) => s.wordId.equals(word.id)))
            .get();

        final notes = await (db.select(db.wordNotes)
              ..where((n) => n.wordId.equals(word.id)))
            .get();

        final learning = await (db.select(db.wordLearningData)
              ..where((l) => l.wordId.equals(word.id)))
            .getSingleOrNull();

        items.add(
          mapToVocabularyItem(
            word: word,
            translation: translation,
            meaning: meaning,
            examples: examples,
            synonyms: synonyms,
            notes: notes,
            learning: learning,
          ),
        );
      }
      print("[Repository] watchAllVocabulary returning ${items.length} items");
      return items;
    });
  }

  Future<void> deleteWord(int wordId) async {
    print("[Repository] deleteWord called for wordId: $wordId");
    await db.transaction(() async {
      final rowsDeleted = await (db.delete(db.wordEntries)
            ..where((tbl) => tbl.id.equals(wordId)))
          .go();
      print("[Repository] deleteWord finished, rows deleted: $rowsDeleted");
    });
  }

  Future<List<int>> getAllWordIds() async {
    final rows = await db.select(db.wordEntries).get();
    return rows.map((e) => e.id).toList();
  }

  Future<String> getWordText(int wordId) async {
    final word = await (db.select(db.wordEntries)
          ..where((w) => w.id.equals(wordId)))
        .getSingle();
    return word.wordText;
  }

  Future<String> getPrimaryTranslation(int wordId) async {
    final translation = await (db.select(db.translations)
          ..where((t) => t.wordId.equals(wordId)))
        .getSingle();
    return translation.translatedText;
  }

  Future<List<String>> getExamples(int wordId) async {
    final rows = await (db.select(db.wordExamples)
          ..where((e) => e.wordId.equals(wordId)))
        .get();
    return rows.map((e) => e.exampleText).toList();
  }

  Future<String?> getDefinition(int wordId) async {
    final row = await (db.select(db.wordMeanings)
          ..where((m) => m.wordId.equals(wordId)))
        .getSingleOrNull();
    return row?.definition;
  }

  Future<WordLearningDataData?> getLearningData(int wordId) async {
    return await (db.select(db.wordLearningData)
          ..where((l) => l.wordId.equals(wordId)))
        .getSingleOrNull();
  }

  Future<List<String>> generateDefinitionDistractors({
    required String word,
    required String correctDefinition,
  }) async {
    final result = await ai.generateDefinitionDistractors(
      word: word,
      correctDefinition: correctDefinition,
    );

    return result;
  }

  Future<void> debugPrintAllWords() async {
    print("===== DEBUG: All Word Entries =====");
    final words = await db.select(db.wordEntries).get();
    for (final w in words) {
      print(
          "WordEntry: id=${w.id}, text='${w.wordText}', lang=${w.language}, source=${w.source}");
    }

    final translations = await db.select(db.translations).get();
    print("===== DEBUG: All Translations =====");
    for (final t in translations) {
      print(
          "Translation: wordId=${t.wordId}, lang=${t.language}, text='${t.translatedText}'");
    }

    final meanings = await db.select(db.wordMeanings).get();
    print("===== DEBUG: All Meanings =====");
    for (final m in meanings) {
      print("Meaning: wordId=${m.wordId}, definition='${m.definition}'");
    }

    final notes = await db.select(db.wordNotes).get();
    print("===== DEBUG: All Notes =====");
    for (final n in notes) {
      print("Note: wordId=${n.wordId}, note='${n.noteText}'");
    }

    print("===== DEBUG END =====");
  }
}
