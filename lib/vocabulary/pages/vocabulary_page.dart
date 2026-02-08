import 'package:flutter/material.dart';
import '../../PrimaryActionCard.dart';
import '../models/vocabulary_item.dart';
import '../widgets/VocabularyCard.dart';
import '../../services/vocabulary_service.dart';
import 'package:provider/provider.dart';

class VocabularyPage extends StatelessWidget {
  const VocabularyPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final vocabularyService =
        Provider.of<VocabularyService>(context); // listen:true

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: "Vocabulary"),
              Tab(text: "Improve"),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _VocabularyTab(vocabularyService: vocabularyService),
                const Center(child: Text("Coming Soon")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _VocabularyTab extends StatelessWidget {
  final VocabularyService vocabularyService;

  const _VocabularyTab({required this.vocabularyService});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        PrimaryActionCard(
          text: "Start Vocabulary Practice",
          onTap: () {},
        ),
        const SizedBox(height: 12),
        Expanded(
          child: StreamBuilder<List<VocabularyItem>>(
            stream: vocabularyService.watchVocabulary(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final items = snapshot.data ?? [];
              print(
                  "[StreamBuilder] received ${items.length} items from stream");

              if (items.isEmpty) {
                return const Center(
                  child: Text("No vocabulary saved yet"),
                );
              }

              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return VocabularyCard(item: items[index]);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
