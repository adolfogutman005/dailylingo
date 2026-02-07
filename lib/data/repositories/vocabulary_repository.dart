import '../database/app_database.dart';
import '../mappers/vocabulary_mapper.dart';
import '../../vocabulary/models/vocabulary_item.dart';
import 'package:drift/drift.dart';

class VocabularyRepository {
  final AppDatabase db;

  VocabularyRepository(this.db);

  Future<int> insertFromTranslator({
    required String text,
    required String sourceLang,
    required String targetLang,
    required String translatedText,
  }) async {
    print("Repository: insertFromTranslator starting for $text");

    return await db.transaction(() async {
      final wordId = await db.into(db.wordEntries).insert(
            WordEntriesCompanion.insert(
              wordText: text,
              language: sourceLang,
              entryType: text.contains(' ') ? 'phrase' : 'word',
              source: 'translator',
              createdAt: DateTime.now(),
            ),
          );
      print("Inserted Translation for wordId $wordId");

      await db.into(db.translations).insert(
            TranslationsCompanion.insert(
              wordId: wordId,
              language: targetLang,
              translatedText: translatedText,
            ),
          );

      // Dummy meaning
      await db.into(db.wordMeanings).insert(
            WordMeaningsCompanion.insert(
              wordId: wordId,
              definition: "Dummy explanation for '$text'",
            ),
          );
      // Dummy Note
      await db.into(db.wordNotes).insert(
            WordNotesCompanion.insert(
              wordId: wordId,
              noteText: "This is a dummy note for '$text'",
            ),
          );

      return wordId;
    });
  }

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
}
