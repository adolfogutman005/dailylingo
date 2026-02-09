enum CorrectionType {
  grammar,
  suggestion,
}

class CorrectionClass {
  final int start;
  final int end;
  final String wrong;
  final String right;
  final String explanation;
  final String example;
  final CorrectionType type;

  final String concept;

  CorrectionClass({
    required this.start,
    required this.end,
    required this.wrong,
    required this.right,
    required this.explanation,
    required this.example,
    required this.type,
    required this.concept,
  });
}
