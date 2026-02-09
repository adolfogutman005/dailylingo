import 'package:flutter/material.dart';
import '../../PrimaryActionCard.dart';
import '../models/vocabulary_item.dart';
import '../widgets/VocabularyCard.dart';
import '../../services/vocabulary_service.dart';
import 'package:provider/provider.dart';
import '../../exercises/practice_service.dart';
import '../../exercises/exercises_session_page.dart';
import '../../exercises/exercises_page.dart';

class VocabularyPage extends StatelessWidget {
  const VocabularyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vocabularyService = Provider.of<VocabularyService>(context);

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: "Vocabulary"),
              Tab(text: "Grammar"), // renamed
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _VocabularyTab(vocabularyService: vocabularyService),
                _GrammarTab(vocabularyService: vocabularyService), // new tab
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GrammarTab extends StatefulWidget {
  final VocabularyService vocabularyService;

  const _GrammarTab({required this.vocabularyService});

  @override
  State<_GrammarTab> createState() => _GrammarTabState();
}

class _GrammarTabState extends State<_GrammarTab> {
  String? _loadingConcept;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: widget.vocabularyService.getAllGrammarConcepts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final concepts = snapshot.data ?? [];

        if (concepts.isEmpty) {
          return const Center(
            child: Text("No grammar concepts learned yet"),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: concepts.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            final concept = concepts[index];
            final isLoading = _loadingConcept == concept;
            return ListTile(
              leading: Icon(
                Icons.check_circle_outline,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text(concept),
              trailing: ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () async {
                        setState(() {
                          _loadingConcept = concept;
                        });

                        try {
                          final practiceService =
                              PracticeService(widget.vocabularyService);

                          final exercises =
                              await practiceService.getGrammarExercises(concept);

                          if (!mounted || exercises.isEmpty) return;

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  PracticeItemPage(exercisesOverride: exercises),
                            ),
                          );
                        } finally {
                          if (mounted) {
                            setState(() {
                              _loadingConcept = null;
                            });
                          }
                        }
                      },
                child: isLoading
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text("Practice"),
              ),
            );
          },
        );
      },
    );
  }
}

class _VocabularyTab extends StatefulWidget {
  final VocabularyService vocabularyService;

  const _VocabularyTab({required this.vocabularyService});

  @override
  State<_VocabularyTab> createState() => _VocabularyTabState();
}

class _VocabularyTabState extends State<_VocabularyTab> {
  bool _isLoadingPractice = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        PrimaryActionCard(
          text: "Start Vocabulary Practice",
          onTap: _isLoadingPractice
              ? null
              : () async {
                  setState(() {
                    _isLoadingPractice = true;
                  });

                  try {
                    final vocab = context.read<VocabularyService>();
                    final practice = PracticeService(vocab);

                    final exercises = await practice.startRandomSession();

                    if (!mounted || exercises.isEmpty) return;

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PracticeSessionPage(exercises: exercises),
                      ),
                    );
                  } finally {
                    if (mounted) {
                      setState(() {
                        _isLoadingPractice = false;
                      });
                    }
                  }
                },
          isLoading: _isLoadingPractice,
        ),
        const SizedBox(height: 12),
        Expanded(
          child: StreamBuilder<List<VocabularyItem>>(
            stream: widget.vocabularyService.watchVocabulary(),
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
