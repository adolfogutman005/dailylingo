import '../database/app_database.dart';

class VocabularyRepository {
  final AppDatabase db;

  VocabularyRepository(this.db);

  Future<int> insertFromTranslator({
    required String text,
    required String sourceLang,
    required String targetLang,
    required String translatedText,
  }) async {
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
}
