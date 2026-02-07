import 'package:flutter/material.dart';
import '../models/vocabulary_item.dart';
import '../widgets/detail_section.dart';

class VocabularyDetailPage extends StatelessWidget {
  final VocabularyItem item;

  const VocabularyDetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
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
                onPressed: () {},
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
