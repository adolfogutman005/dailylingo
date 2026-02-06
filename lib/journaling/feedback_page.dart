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
  final String content;
  final List<Correction> corrections;

  const FeedbackPage({
    super.key,
    required this.title,
    required this.content,
    required this.corrections,
  });

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  /// Active filters
  Set<CorrectionType> activeFilters = {
    CorrectionType.grammar,
    CorrectionType.suggestion,
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget buildHighlightedText() {
    final spans = <TextSpan>[];
    int current = 0;

    /// Filter corrections
    final visibleCorrections =
        // Filters the corrections selected on Active Filters
        widget.corrections.where((c) => activeFilters.contains(c.type)).toList()

          /// MOST SPECIFIC FIRST
          ..sort((a, b) {
            final lenA = a.end - a.start;
            final lenB = b.end - b.start;
            return lenA.compareTo(lenB);
          });

    /// Prevent overlap chaos
    final occupied = <int>{};

    final usable = <Correction>[];

    for (final c in visibleCorrections) {
      bool overlaps = false;

      for (int i = c.start; i < c.end; i++) {
        if (occupied.contains(i)) {
          overlaps = true;
          break;
        }
      }

      if (!overlaps) {
        usable.add(c);
        for (int i = c.start; i < c.end; i++) {
          occupied.add(i);
        }
      }
    }

    /// Now sort by position
    usable.sort((a, b) => a.start.compareTo(b.start));

    // Frame full text as TextSpan List
    for (final c in usable) {
      // Uncorrected text is framed as TextSpan without Style
      if (current < c.start) {
        spans.add(
          TextSpan(
            text: widget.content.substring(current, c.start),
          ),
        );
      }

      // Create a Text Span with Style for All Corrections
      spans.add(
        TextSpan(
          text: widget.content.substring(c.start, c.end),
          style: TextStyle(
            backgroundColor:
                c.type == CorrectionType.grammar ? Colors.red : Colors.yellow,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () => showCorrectionSheet(c),
        ),
      );

      current = c.end;
    }

    // add remaining space
    if (current < widget.content.length) {
      spans.add(
        TextSpan(text: widget.content.substring(current)),
      );
    }

    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 16,
          height: 1.5,
          color: Colors.black,
        ),
        children: spans,
      ),
    );
  }

  // Bottom Modal Sheet
  void showCorrectionSheet(Correction c) {
    const labelStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Wrap(
            children: [
              const SizedBox(height: 10),
              const Text("Wrong:", style: labelStyle),
              Text(c.wrong),
              const SizedBox(height: 14),
              const Text("Right:", style: labelStyle),
              Text(c.right),
              const SizedBox(height: 14),
              const Text("Explanation:", style: labelStyle),
              Text(c.explanation),
              const SizedBox(height: 14),
              const Text("Example:", style: labelStyle),
              Text(c.example),
              const SizedBox(height: 30),
            ],
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
        title: Text(widget.title),
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
                widget.content, // Later replace with corrected version
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
