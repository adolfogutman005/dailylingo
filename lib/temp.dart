import 'package:flutter/material.dart';
import 'PrimaryActionCard.dart';

enum LearningStatus { newItem, learning, mastered }

class VocabularyItem {
  final String id;
  final String text;
  final String translation;
  final String pronunciation;
  final String source;
  final String? explanation;
  final List<String> examples;
  final List<String> synonyms;

  final LearningStatus status;
  final DateTime createdAt;
  final DateTime? lastReviewed;
  final int timesPracticed;
  final String? notes;

  VocabularyItem({
    required this.id,
    required this.text,
    required this.translation,
    required this.pronunciation,
    required this.source,
    this.explanation,
    this.examples = const [],
    this.synonyms = const [],
    this.notes,
    this.lastReviewed,
    this.timesPracticed = 0,
    this.status = LearningStatus.newItem,
    required this.createdAt,
  });
}

class VocabularyTab extends StatelessWidget {
  final List<VocabularyItem> items;

  const VocabularyTab({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        PrimaryActionCard(
          text: 'Start Daily Journaling',
          onTap: () {
            // TODO: journaling action
          },
        ),
        const SizedBox(height: 12),
        Expanded(
          child: items.isEmpty
              ? const Center(
                  child: Text(
                    'No vocabulary yet',
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return VocabularyCard(item: items[index]);
                  },
                ),
        ),
      ],
    );
  }
}

class VocabularyDetailPage extends StatelessWidget {
  final VocabularyItem item;

  const VocabularyDetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.text),
        actions: [
          IconButton(
            icon: const Icon(Icons.volume_up),
            onPressed: () {
              // TTS
            },
          ),
          IconButton(
            icon: const Icon(Icons.play_arrow),
            onPressed: () {
              // practice
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              // delete
            },
          ),
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
          InfoSection(
            title: 'Translation',
            child: Text(item.translation),
          ),
          if (item.explanation != null)
            InfoSection(
              title: 'Explanation',
              child: Text(item.explanation!),
            ),
          if (item.examples.isNotEmpty)
            InfoSection(
              title: 'Examples',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: item.examples
                    .map((e) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text('• $e'),
                        ))
                    .toList(),
              ),
            ),
          if (item.synonyms.isNotEmpty)
            InfoSection(
              title: 'Synonyms',
              child: Wrap(
                spacing: 8,
                children:
                    item.synonyms.map((s) => Chip(label: Text(s))).toList(),
              ),
            ),
          if (item.notes != null)
            InfoSection(
              title: 'Notes',
              child: Text(item.notes!),
            ),
        ],
      ),
    );
  }
}

class VocabularyCard extends StatelessWidget {
  final VocabularyItem item;

  const VocabularyCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.text,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.translation,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.volume_up),
                onPressed: () {
                  // TTS using item.pronunciation
                },
              ),
              IconButton(
                icon: const Icon(Icons.play_arrow),
                onPressed: () {
                  // start practice
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: () {
                  // confirm delete
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: selected ? Colors.blue : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: selected ? Colors.blue : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}

class ImproveTab extends StatelessWidget {
  const ImproveTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Coming Soon',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
      ),
    );
  }
}

class VocabularyPage extends StatefulWidget {
  final List<VocabularyItem> items;

  const VocabularyPage({
    super.key,
    required this.items,
  });

  @override
  State<VocabularyPage> createState() => _VocabularyPageState();
}

class _VocabularyPageState extends State<VocabularyPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vocabulary'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: open search
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Row(
            children: [
              _TabButton(
                label: 'Vocabulary',
                selected: _currentIndex == 0,
                onTap: () => setState(() => _currentIndex = 0),
              ),
              _TabButton(
                label: 'Improve',
                selected: _currentIndex == 1,
                onTap: () => setState(() => _currentIndex = 1),
              ),
            ],
          ),
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          VocabularyTab(items: widget.items),
          const ImproveTab(),
        ],
      ),
    );
  }
}

class InfoSection extends StatelessWidget {
  final String title;
  final Widget child;

  const InfoSection({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
