import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

/// ----------------------
/// MODEL
/// ----------------------

enum CorrectionType {
  grammar,
  suggestion,
}

class Correction {
  final int start;
  final int end;
  final String wrong;
  final String right;
  final String explanation;
  final String example;
  final CorrectionType type;

  Correction({
    required this.start,
    required this.end,
    required this.wrong,
    required this.right,
    required this.explanation,
    required this.example,
    required this.type,
  });
}

/// ----------------------
/// PAGE
/// ----------------------

class FeedbackPage extends StatefulWidget {
  final String title;
  final String originalContent;
  final String correctedContent;
  final List<Correction> corrections;

  const FeedbackPage({
    super.key,
    required this.title,
    required this.originalContent,
    required this.correctedContent,
    required this.corrections,
  });

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _titleController;

  /// Active filters
  Set<CorrectionType> activeFilters = {
    CorrectionType.grammar,
    CorrectionType.suggestion,
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _titleController = TextEditingController(text: widget.title);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  Color _highlightColor({
    required Correction correction,
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

  Widget buildHighlightedText() {
    final text = widget.originalContent;
    final spans = <TextSpan>[];

    final active = widget.corrections
        .where((c) => activeFilters.contains(c.type))
        .toList();

    if (active.isEmpty) {
      return Text(text);
    }

    int len(Correction c) => c.end - c.start;

    // Separate by type
    final grammar =
        active.where((c) => c.type == CorrectionType.grammar).toList();
    final suggestions =
        active.where((c) => c.type == CorrectionType.suggestion).toList();

    int minLen(List<Correction> list) =>
        list.isEmpty ? 0 : list.map(len).reduce((a, b) => a < b ? a : b);

    int maxLen(List<Correction> list) =>
        list.isEmpty ? 1 : list.map(len).reduce((a, b) => a > b ? a : b);

    final gMin = minLen(grammar);
    final gMax = maxLen(grammar);

    final sMin = minLen(suggestions);
    final sMax = maxLen(suggestions);

    // Build segmentation points
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

      // MOST SPECIFIC WINS
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

    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 16,
            height: 1.5,
            color: Colors.black,
          ),
          children: spans,
        ),
      ),
    );
  }

  // Bottom Modal Sheet
  void showCorrectionSheet(Correction c) {
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
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
          const SizedBox(width: 6),
          OutlinedButton(
            onPressed: () {
              // Add Database Saving Logic
              Navigator.pop(context);
            },
            child: const Text("Save without Feedback"),
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
                    child: buildHighlightedText(),
                  ),
                ),
              ],
            ),
          ),

          /// CORRECTED TAB
          Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Text(
                widget.correctedContent, // Later replace with corrected version
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
