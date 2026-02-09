import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/vocabulary_item.dart';
import '../pages/vocabulary_detail_page.dart';
import '../../exercises/exercises_page.dart';
import '../../services/vocabulary_service.dart';
import '../../speaking_service.dart';

class VocabularyCard extends StatelessWidget {
  final VocabularyItem item;

  const VocabularyCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final ttsService = TtsService();

    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => VocabularyDetailPage(item: item),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  item.text,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.volume_up_outlined, color: theme.colorScheme.primary),
                onPressed: () {
                  ttsService.speak(item.text, item.language);
                },
              ),
              IconButton(
                icon: Icon(Icons.school_outlined, color: theme.colorScheme.primary),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => PracticeItemPage(wordId: item.id)));
                },
              ),
              IconButton(
                icon: Icon(Icons.delete_outline, color: theme.colorScheme.error),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (sheetContext) {
                      final vocabularyService =
                          Provider.of<VocabularyService>(context, listen: false);
                      final navigator = Navigator.of(context);
                      return Container(
                        padding: const EdgeInsets.all(20),
                        height: 160,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Delete '${item.text}'?",
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                                "This will remove the word and all related information."),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () => navigator.pop(),
                                  child: const Text("Cancel"),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: theme.colorScheme.error,
                                  ),
                                  onPressed: () async {
                                    navigator.pop();
                                    await vocabularyService.deleteWord(item.id);
                                  },
                                  child: const Text("Delete"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
