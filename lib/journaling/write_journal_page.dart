import 'package:dailylingo/journaling/models/feedback_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/vocabulary_service.dart'; // modify later to journal service
import 'feedback_page.dart';

class WriteJournalPage extends StatefulWidget {
  final String? initialTitle;
  final String placeholder;

  const WriteJournalPage({
    super.key,
    this.initialTitle,
    this.placeholder = 'Start writing...',
  });

  @override
  State<WriteJournalPage> createState() => _WriteJournalPageState();
}

class _WriteJournalPageState extends State<WriteJournalPage> {
  final TextEditingController _contentController = TextEditingController();
  late TextEditingController _titleController;
  late VocabularyService vocabularyService;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(text: widget.initialTitle ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    vocabularyService = Provider.of<VocabularyService>(context, listen: true);
  }

  void _saveJournal() {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Title and content cannot be empty')),
      );
      return;
    }

    // For now: just pop back
    // Later this is where you save to DB / state
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: widget.initialTitle,
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TextButton(
              onPressed: _saveJournal,
              child: const Text('Save Now'),
            ),
            const SizedBox(width: 8),
            OutlinedButton(
              onPressed: () async {
                final feedback = await vocabularyService.getFeedback(
                    journalText: _contentController.text.trim());

                /// PRINT FOR DEBUGGING
                print("Corrected Content: ${feedback.correctedContent}");

                print("Corrections:");
                for (var c in feedback.corrections) {
                  print(
                      "- [${c.type}] '${c.wrong}' → '${c.right}' | Concept: ${c.concept}");
                }

                print("Learned Concepts:");
                for (var concept in feedback.conceptsLearned) {
                  print("- $concept");
                }

                final feedbackData = FeedbackData(
                    title: _titleController.text.trim(),
                    originalContent: _contentController.text.trim(),
                    correctedContent: feedback.correctedContent,
                    corrections: feedback.corrections,
                    conceptsLearned: feedback.conceptsLearned);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => FeedbackPage(
                              feedback: feedbackData,
                            )));
              },
              child: const Text('Feedback'),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          controller: _contentController,
          maxLines: null,
          expands: true,
          textAlignVertical: TextAlignVertical.top,
          decoration: InputDecoration(
            hintText: widget.placeholder,
            border: InputBorder.none,
          ),
          style: const TextStyle(fontSize: 16, height: 1.4),
        ),
      ),
    );
  }
}
