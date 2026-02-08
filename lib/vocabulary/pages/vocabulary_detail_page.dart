import 'package:flutter/material.dart';
import '../models/vocabulary_item.dart';
import '../widgets/detail_section.dart';
import '../../services/vocabulary_service.dart';
import 'package:provider/provider.dart';

class VocabularyDetailPage extends StatelessWidget {
  final VocabularyItem item;

  const VocabularyDetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(item.text),
        actions: [
          TextButton(
            onPressed: () {
              // Save changes
            },
            child: const Text("Save"),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /// Source + actions row
          Row(
            children: [
              Chip(label: Text(item.source)),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.volume_up),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.school),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        padding: const EdgeInsets.all(16),
                        height: 160,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Delete '${item.text}'?",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                                "This will remove the word and all related information."),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  child: const Text("Cancel"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  child: const Text("Delete"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  onPressed: () async {
                                    navigator.pop(); // close modal
                                    print(
                                        "[UI] User confirmed delete for ${item.text}");
                                    final vocabularyService =
                                        Provider.of<VocabularyService>(context,
                                            listen: false);
                                    await vocabularyService.deleteWord(item.id);
                                    print(
                                        "[UI] Delete completed for ${item.text}");

                                    navigator.pop();
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),

          /// Metadata
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 20),
            child: Text(
              "Created: ${item.createdAt}\n"
              "Times practiced: ${item.timesPracticed}\n"
              "Last reviewed: ${item.lastReviewed ?? '—'}\n"
              "Status: ${item.status}",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ),

          /// Sections
          DetailSection(
            title: "Translation",
            content: item.translation,
            actionIcon: Icons.edit,
            onActionPressed: () {},
          ),

          DetailSection(
            title: "Explanation",
            content: item.explanation ?? "",
            actionIcon: Icons.edit,
            onActionPressed: () {},
          ),

          DetailSection(
            title: "Examples",
            content: item.examples.join("\n\n"),
            actionIcon: Icons.add,
            onActionPressed: () {},
          ),

          DetailSection(
            title: "Synonyms",
            content: item.synonyms.join("\n\n"),
            actionIcon: Icons.add,
            onActionPressed: () {},
          ),

          DetailSection(
            title: "Notes",
            content: item.notes.join("\n"),
            actionIcon: Icons.add,
            onActionPressed: () {},
          ),
        ],
      ),
    );
  }
}
