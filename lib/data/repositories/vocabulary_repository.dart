import '../database/app_database.dart';
import '../mappers/vocabulary_mapper.dart';
import '../../vocabulary/models/vocabulary_item.dart';
import 'package:drift/drift.dart';
import '../../ai/gemini_ai.dart'; // <-- import your GeminiAI class

class VocabularyRepository {
  final AppDatabase db;
  final GeminiAI ai; // <-- inject GeminiAI

  VocabularyRepository(this.db, {required this.ai});

  /// Insert a word/phrase, fetch explanation from Gemini
  Future<int> insertVocabulary({
    required String text,
    required String source,
    required String sourceLang,
    required String targetLang,
  }) async {
    print("Repository: insertVocabulary starting for $text");

    return await db.transaction(() async {
      // Insert word entry first
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

      // Insert dummy translation for now (replace with real translator later)
      await db.into(db.translations).insert(
            TranslationsCompanion.insert(
              wordId: wordId,
              language: targetLang,
              translatedText: "Translated text dummy data",
            ),
          );

      // ✅ Fetch AI explanation
      String explanation;
      try {
        explanation = await ai.fetchPhraseExplanation(
          phrase: text,
          language: sourceLang,
        );
        print("Fetched AI explanation: $explanation");
      } catch (e) {
        explanation = "Definition unavailable";
        print("Failed to fetch AI explanation: $e");
      }

      // Insert explanation
      await db.into(db.wordMeanings).insert(
            WordMeaningsCompanion.insert(
              wordId: wordId,
              definition: explanation,
            ),
          );

      // Insert dummy note
      await db.into(db.wordNotes).insert(
            WordNotesCompanion.insert(
              wordId: wordId,
              noteText: "This is a dummy note for '$text'",
            ),
          );

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
