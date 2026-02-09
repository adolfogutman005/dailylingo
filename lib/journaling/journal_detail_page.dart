import 'package:flutter/material.dart';
import 'feedback_page.dart';
import 'models/corrections.dart';
import 'models/feedback_data.dart';
import 'models/journal.dart';

class JournalDetailPage extends StatefulWidget {
  final JournalEntry entry;

  const JournalDetailPage({super.key, required this.entry});

  @override
  State<JournalDetailPage> createState() => _JournalDetailPageState();
}

class _JournalDetailPageState extends State<JournalDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);

    _titleController = TextEditingController(text: widget.entry.title);
    _contentController = TextEditingController(text: widget.entry.content);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    // For now just pop — later this updates state / DB
    Navigator.pop(context);
  }

  void _feedback() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FeedbackPage(
            feedback: FeedbackData(
                title: "My Journal",
                originalContent: "I go to the park yesterday.",

                /// Fully corrected version (after applying accepted corrections)
                correctedContent: "Yesterday, I went to the nearby park.",
                corrections: [
                  /// 1️⃣ GRAMMAR — verb tense (word-level, most specific)
                  CorrectionClass(
                      start: 2,
                      end: 4,
                      wrong: "go",
                      right: "went",
                      explanation:
                          "The past simple tense is required because the action was completed in the past.",
                      example: "I went to the store.",
                      type: CorrectionType.grammar,
                      concept: "Past tense of go"),

                  /// 2️⃣ GRAMMAR — time reference forces past tense (sentence-level)
                  CorrectionClass(
                      start: 0,
                      end: 27,
                      wrong: "I go to the park yesterday.",
                      right: "I went to the park yesterday.",
                      explanation:
                          "A finished time expression like 'yesterday' requires the verb to be in the past tense.",
                      example: "She studied late yesterday.",
                      type: CorrectionType.grammar,
                      concept: "Time expressions require past tense"),

                  /// 3️⃣ SUGGESTION — stylistic reordering
                  CorrectionClass(
                      start: 1,
                      end: 27,
                      wrong: "I went to the park yesterday.",
                      right: "Yesterday, I went to the park.",
                      explanation:
                          "Starting with the time expression makes the sentence sound more natural.",
                      example: "Last night, I read a book.",
                      type: CorrectionType.suggestion,
                      concept: "Starting sentences with time expressions"),

                  /// 4️⃣ SUGGESTION — add descriptive detail
                  CorrectionClass(
                      start: 8,
                      end: 16,
                      wrong: "the park",
                      right: "the nearby park",
                      explanation:
                          "Adding a descriptive adjective makes the sentence more vivid.",
                      example: "She walked to the nearby café.",
                      type: CorrectionType.suggestion,
                      concept: "Using adjectives to add detail"),
                ],
                conceptsLearned: List.empty())),
      ),
    );
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
                decoration: const InputDecoration(
                  hintText: 'Title',
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TextButton(
              onPressed: _saveChanges,
              child: const Text('Save Now'),
            ),
            const SizedBox(width: 8),
            OutlinedButton(
              onPressed: _feedback,
              child: const Text('Feedback'),
            ),
            const SizedBox(width: 8),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Original'),
            Tab(text: 'Corrected'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _originalTab(),
          _correctedTab(),
        ],
      ),
    );
  }

  // ---------- Tabs ----------

  Widget _originalTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _contentController,
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        decoration: const InputDecoration(
          hintText: 'Start writing...',
          border: InputBorder.none,
        ),
        style: const TextStyle(fontSize: 16, height: 1.4),
      ),
    );
  }

  Widget _correctedTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Text(
          widget.entry.content,
          style: const TextStyle(
            fontSize: 16,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}
