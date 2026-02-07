import 'package:flutter/material.dart';
import '../models/VocabularyItem.dart';
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
          IconButton(icon: const Icon(Icons.volume_up), onPressed: () {}),
          IconButton(icon: const Icon(Icons.school), onPressed: () {}),
          IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Chip(label: Text(item.source)),
          ),
          const SizedBox(height: 16),
          DetailSection(title: "Translation", content: item.translation),
          if (item.explanation != null)
            DetailSection(title: "Explanation", content: item.explanation!),
          if (item.examples.isNotEmpty)
            DetailSection(
              title: "Examples",
              content: item.examples.join("\n\n"),
            ),
          if (item.synonyms.isNotEmpty)
            DetailSection(
              title: "Synonyms",
              content: item.synonyms.join(", "),
            ),
          if (item.notes != null)
            DetailSection(title: "Notes", content: item.notes!),
        ],
      ),
    );
  }
}
