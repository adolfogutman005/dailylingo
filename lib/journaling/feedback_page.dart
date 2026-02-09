import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'models/corrections.dart';
import 'models/feedback_data.dart';
import 'journaling_page.dart';
import 'package:provider/provider.dart';
import '../services/vocabulary_service.dart';

/// ----------------------
/// PAGE
/// ----------------------

class FeedbackPage extends StatefulWidget {
  final FeedbackData feedback;

  const FeedbackPage({super.key, required this.feedback});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _titleController;

  late List<CorrectionClass> editableCorrections;
  late List<String> learnedConcepts;

  late List<TextEditingController> conceptControllers;
  late List<FocusNode> conceptFocusNodes;

  late VocabularyService vocabularyService;

  /// Active filters
  Set<CorrectionType> activeFilters = {
    CorrectionType.grammar,
    CorrectionType.suggestion,
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _titleController = TextEditingController(text: widget.feedback.title);

    editableCorrections = List.from(widget.feedback.corrections);
    learnedConcepts = List.from(widget.feedback.conceptsLearned);

    conceptFocusNodes = learnedConcepts.map((_) => FocusNode()).toList();

    conceptControllers =
        learnedConcepts.map((c) => TextEditingController(text: c)).toList();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _titleController.dispose();
    for (var c in conceptControllers) {
      c.dispose();
    }
    for (var n in conceptFocusNodes) {
      n.dispose();
    }
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    vocabularyService = Provider.of<VocabularyService>(context, listen: true);
  }

  Future<void> _save({required bool withFeedback}) async {
    // Build updated FeedbackData
    final updatedFeedback = FeedbackData(
      title: _titleController.text,
      originalContent: widget.feedback.originalContent,
      correctedContent: widget.feedback.correctedContent,
      corrections: withFeedback ? editableCorrections : [],
      conceptsLearned: withFeedback ? learnedConcepts : [],
    );

    try {
      final journalId = await vocabularyService.saveJournal(
        updatedFeedback,
        saveFeedback: withFeedback,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Saved successfully! (ID: $journalId)')),
      );

      Navigator.popUntil(context, (route) => route.isFirst);
      ;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving: $e')),
      );
    }
  }

  Color _highlightColor({
    required CorrectionClass correction,
    required int minLen,
    required int maxLen,
  }) {
    final length = correction.end - correction.start;

    // Normalize: shorter = stronger
    double t;
    if (maxLen == minLen) {
      t = 1; // avoid division by zero
    } else {
      t = 1 - ((length - minLen) / (maxLen - minLen));
    }

    // Strong but readable range
    final channel = (160 + (60 * t)).round();

    switch (correction.type) {
      case CorrectionType.grammar:
        return Color.fromARGB(255, channel, 70, 70);

      case CorrectionType.suggestion:
        return Color.fromARGB(255, channel, channel, 80);
    }
  }

  Widget buildFeedbackTile() {
    if (editableCorrections.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        leading: const Icon(Icons.feedback, color: Colors.blue),
        title: const Text(
          "Feedback",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          "${editableCorrections.length} correction${editableCorrections.length == 1 ? '' : 's'}",
          style: const TextStyle(fontSize: 13),
        ),
        children: editableCorrections.map((c) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  c.type == CorrectionType.grammar
                      ? Icons.rule_rounded
                      : Icons.lightbulb_outline,
                  size: 18,
                  color: c.type == CorrectionType.grammar
                      ? Colors.redAccent
                      : Colors.orange,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    c.wrong,
                    style: const TextStyle(fontSize: 15, height: 1.4),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.grey),
                  onPressed: () {
                    setState(() {
                      editableCorrections.remove(c);
                    });
                  },
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget buildLearnedConcepts() {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        leading: const Icon(Icons.check_circle_outline, color: Colors.green),
        title: const Text(
          "What You Learned",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          "${conceptControllers.length} concept${conceptControllers.length == 1 ? '' : 's'}",
          style: const TextStyle(fontSize: 13),
        ),
        children: [
          ...conceptControllers.asMap().entries.map((entry) {
            final index = entry.key;
            final controller = entry.value;
            final focusNode =
                conceptFocusNodes[index]; // Create a focus node for each field

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller,
                      focusNode: focusNode,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      onChanged: (v) => learnedConcepts[index] = v,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        learnedConcepts.removeAt(index);
                        conceptControllers[index].dispose();
                        conceptControllers.removeAt(index);
                        conceptFocusNodes[index].dispose();
                        conceptFocusNodes.removeAt(index);
                      });
                    },
                  ),
                ],
              ),
            );
          }),
          TextButton.icon(
            onPressed: () {
              setState(() {
                learnedConcepts.add("");
                final controller = TextEditingController();
                final focusNode = FocusNode();
                conceptControllers.add(controller);
                conceptFocusNodes.add(focusNode);
                // Delay so the widget exists, then focus
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  FocusScope.of(context).requestFocus(focusNode);
                });
              });
            },
            icon: const Icon(Icons.add),
            label: const Text("Add Concept"),
          ),
        ],
      ),
    );
  }

  Widget buildHighlightedText() {
    final text = widget.feedback.originalContent;

    const baseStyle = TextStyle(
      fontSize: 16,
      height: 1.6, // slightly better reading comfort
      color: Colors.black87,
    );

    final active = editableCorrections
        .where((c) => activeFilters.contains(c.type))
        .toList();

    Widget child;

    /// -----------------------------
    /// NO ACTIVE FILTERS
    /// -----------------------------
    if (active.isEmpty) {
      child = Text(
        text,
        textAlign: TextAlign.left,
        style: baseStyle,
      );
    } else {
      final spans = <TextSpan>[];

      int len(CorrectionClass c) => c.end - c.start;

      // Separate by type
      final grammar =
          active.where((c) => c.type == CorrectionType.grammar).toList();
      final suggestions =
          active.where((c) => c.type == CorrectionType.suggestion).toList();

      int minLen(List<CorrectionClass> list) =>
          list.isEmpty ? 0 : list.map(len).reduce((a, b) => a < b ? a : b);

      int maxLen(List<CorrectionClass> list) =>
          list.isEmpty ? 1 : list.map(len).reduce((a, b) => a > b ? a : b);

      final gMin = minLen(grammar);
      final gMax = maxLen(grammar);

      final sMin = minLen(suggestions);
      final sMax = maxLen(suggestions);

      /// Build segmentation points
      final points = <int>{0, text.length};

      for (final c in active) {
        points.add(c.start);
        points.add(c.end);
      }

      final sortedPoints = points.toList()..sort();

      for (int i = 0; i < sortedPoints.length - 1; i++) {
        final start = sortedPoints[i];
        final end = sortedPoints[i + 1];

        if (start == end) continue;

        final segment = text.substring(start, end);

        final covering =
            active.where((c) => c.start <= start && c.end >= end).toList();

        if (covering.isEmpty) {
          spans.add(TextSpan(text: segment));
          continue;
        }

        /// MOST SPECIFIC WINS
        covering.sort(
          (a, b) => (a.end - a.start).compareTo(b.end - b.start),
        );

        final chosen = covering.first;

        final min = chosen.type == CorrectionType.grammar ? gMin : sMin;
        final max = chosen.type == CorrectionType.grammar ? gMax : sMax;

        spans.add(
          TextSpan(
            text: segment,
            style: TextStyle(
              backgroundColor: _highlightColor(
                correction: chosen,
                minLen: min,
                maxLen: max,
              ),
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => showCorrectionSheet(chosen),
          ),
        );
      }

      child = RichText(
        text: TextSpan(
          style: baseStyle,
          children: spans,
        ),
      );
    }

    /// ALWAYS full width → never centers
    return SizedBox(
      width: double.infinity,
      child: child,
    );
  }

  // Bottom Modal Sheet
  void showCorrectionSheet(CorrectionClass c) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            16,
            20,
            MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                _section(
                  icon: Icons.close_rounded,
                  iconColor: Colors.redAccent,
                  title: "Incorrect",
                  content: c.wrong,
                ),

                const SizedBox(height: 14),

                _section(
                  icon: Icons.check_circle_rounded,
                  iconColor: Colors.green,
                  title: "Correct",
                  content: c.right,
                ),

                const SizedBox(height: 20),

                _infoCard(
                  icon: Icons.lightbulb_outline,
                  title: "Explanation",
                  content: c.explanation,
                ),

                const SizedBox(height: 14),

                _infoCard(
                  icon: Icons.menu_book_outlined,
                  title: "Example",
                  content: c.example,
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }

  /// ------------------------------------------------
  /// UI
  /// ------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              hintText: "Title",
              border: InputBorder.none,
            ),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _save(withFeedback: false);
            },
            child: const Text("Save without Feedback"),
          ),
          const SizedBox(width: 6),
          OutlinedButton(
            onPressed: () {
              // Add Database Saving Logic
              _save(withFeedback: true);
            },
            child: const Text("Save"),
          ),
          const SizedBox(width: 12),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Original"),
            Tab(text: "Corrected"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          /// ORIGINAL TAB
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                /// FILTER CHIPS
                Wrap(
                  spacing: 8,
                  children: [
                    FilterChip(
                      label: const Text("Grammar"),
                      selected: activeFilters.contains(CorrectionType.grammar),
                      onSelected: (v) {
                        setState(() {
                          v
                              ? activeFilters.add(CorrectionType.grammar)
                              : activeFilters.remove(CorrectionType.grammar);
                        });
                      },
                    ),
                    FilterChip(
                      label: const Text("Suggestion"),
                      selected:
                          activeFilters.contains(CorrectionType.suggestion),
                      onSelected: (v) {
                        setState(() {
                          v
                              ? activeFilters.add(CorrectionType.suggestion)
                              : activeFilters.remove(CorrectionType.suggestion);
                        });
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildHighlightedText(),
                      buildFeedbackTile(),
                      buildLearnedConcepts()
                    ],
                  )),
                ),
              ],
            ),
          ),

          /// CORRECTED TAB
          Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Text(
                widget.feedback
                    .correctedContent, // Later replace with corrected version
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _section({
  required IconData icon,
  required Color iconColor,
  required String title,
  required String content,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(fontSize: 15, height: 1.4),
        ),
      ],
    ),
  );
}

Widget _infoCard({
  required IconData icon,
  required String title,
  required String content,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.blueGrey),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          content,
          style: const TextStyle(fontSize: 15, height: 1.5),
        ),
      ],
    ),
  );
}
