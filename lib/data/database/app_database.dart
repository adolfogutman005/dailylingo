import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'tables.dart'; // your table classes

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    WordEntries,
    Translations,
    WordMeanings,
    WordExamples,
    WordSynonyms,
    WordNotes,
    WordLearningData,
    Journals,
    Corrections,
    GrammarConcepts,
    JournalConcepts,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2; // increment when adding new tables

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          // Create all tables if DB is brand new
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          // For existing databases, create the new tables only
          if (from < 2) {
            await m.createAll();
          }
          // Future upgrades can be added here
          // e.g., if (from < 3) { await m.createTable(AnotherTable); }
        },
      );
}

// Open the SQLite database file
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'dailylingo.db'));
    return NativeDatabase(file);
  });
}
