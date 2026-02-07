import 'package:flutter/material.dart';
import '../../PrimaryActionCard.dart';
import '../models/VocabularyItem.dart';
import '../widgets/VocabularyCard.dart';

class VocabularyPage extends StatelessWidget {
  const VocabularyPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                _VocabularyTab(),
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
  final List<VocabularyItem> dummyItems = [
    VocabularyItem(
      id: "1",
      text: "Break down",
      translation: "Descomponer / Analizar",
      source: "Reading",
      explanation: "To analyze something in detail.",
      examples: [
        "Let's break down this sentence.",
        "Let's break down this concept.",
      ],
      synonyms: [
        "analyze",
        "decompose",
      ],
      notes: [
        "Often used in explanations or teaching contexts.",
        "Common in academic and technical English.",
      ],
      createdAt: DateTime.now(),
      timesPracticed: 3,
    ),
    VocabularyItem(
      id: "2",
      text: "Outcome",
      translation: "Resultado",
      source: "General",
      examples: [
        "The outcome was unexpected.",
      ],
      notes: [
        "More formal than 'result'.",
      ],
      createdAt: DateTime.now(),
      timesPracticed: 1,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        PrimaryActionCard(
          text: "Start Daily Journaling",
          onTap: () {},
        ),
        const SizedBox(height: 12),
        Expanded(
          child: ListView.builder(
            itemCount: dummyItems.length,
            itemBuilder: (context, index) {
              return VocabularyCard(item: dummyItems[index]);
            },
          ),
        ),
      ],
    );
  }
}
