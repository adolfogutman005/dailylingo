class GrammarFeedback {
  final bool isCorrect;

  final String correctedSentence;

  final List<String> explanations;

  GrammarFeedback({
    required this.isCorrect,
    required this.correctedSentence,
    required this.explanations,
  });
}
