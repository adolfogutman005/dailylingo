import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/base_exercise.dart';
import 'models/grammar_feedback.dart';
import 'models/exercise.dart';
import 'models/grammar_evaluator_exercise.dart';
import '../services/vocabulary_service.dart';
import 'practice_service.dart';

class PracticeItemPage extends StatefulWidget {
  final int? wordId;
  final List<BaseExercise>? exercisesOverride;

  const PracticeItemPage({super.key, this.wordId, this.exercisesOverride});

  @override
  State<PracticeItemPage> createState() => _PracticeItemPageState();
}

class _PracticeItemPageState extends State<PracticeItemPage> {
  int currentExerciseIndex = 0;
  bool? lastAnswerCorrect;
  String? lastCorrectAnswer;
  GrammarFeedback? lastGrammarFeedback;

  int correctCount = 0;

  List<BaseExercise> exercises = [];

  final GlobalKey<WriteAnswerWidgetState> _writeKey =
      GlobalKey<WriteAnswerWidgetState>();

  @override
  void initState() {
    super.initState();

    if (widget.exercisesOverride != null) {
      exercises = widget.exercisesOverride!;
    } else {
      _loadExercises(widget.wordId!);
    }
  }

  Future<void> _loadExercises(int wordId) async {
    final vocab = Provider.of<VocabularyService>(context, listen: false);
    final practice = PracticeService(vocab);

    final list = await practice.getItemExercises(wordId);

    setState(() {
      exercises = list;
    });
  }

  Future<void> handleAnswer(String userAnswer) async {
    final exercise = exercises[currentExerciseIndex];

    if (exercise is Exercise) {
      final isCorrect = exercise.possibleAnswers.any(
        (ans) => ans.toLowerCase().trim() == userAnswer.toLowerCase().trim(),
      );

      if (isCorrect) correctCount++;

      setState(() {
        lastAnswerCorrect = isCorrect;
        lastCorrectAnswer = exercise.answer;
      });
      return;
    }

    if (exercise is GrammarEvaluatorExercise) {
      final feedback = await exercise.evaluator(userAnswer);

      if (feedback.isCorrect) correctCount++;

      setState(() {
        lastAnswerCorrect = feedback.isCorrect;
        lastCorrectAnswer = feedback.correctedSentence;
        lastGrammarFeedback = feedback;
      });
      return;
    }

    throw UnsupportedError('Unknown exercise type');
  }

  void nextExercise() {
    _writeKey.currentState?.clear();

    if (currentExerciseIndex < exercises.length - 1) {
      setState(() {
        currentExerciseIndex++;
        lastAnswerCorrect = null;
        lastCorrectAnswer = null;
        lastGrammarFeedback = null;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => SessionSummaryPage(
            total: exercises.length,
            correct: correctCount,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (exercises.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final exercise = exercises[currentExerciseIndex];
    final progress = (currentExerciseIndex + 1) / exercises.length;

    return Scaffold(
      appBar: AppBar(
        title:
            Text('Practice (${currentExerciseIndex + 1}/${exercises.length})'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: ExerciseCard(
              exercise: exercise,
              onAnswer: handleAnswer,
              writeKey: _writeKey,
            ),
          ),
          if (lastAnswerCorrect != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: FeedbackPanel(
                isCorrect: lastAnswerCorrect!,
                correctAnswer: lastCorrectAnswer,
                grammarFeedback: lastGrammarFeedback,
                onNext: nextExercise,
              ),
            ),
        ],
      ),
    );
  }
}

/* ================== EXERCISE CARD ================== */

class ExerciseCard extends StatelessWidget {
  final BaseExercise exercise;
  final Function(String) onAnswer;
  final GlobalKey<WriteAnswerWidgetState> writeKey;

  const ExerciseCard({
    super.key,
    required this.exercise,
    required this.onAnswer,
    required this.writeKey,
  });

  @override
  Widget build(BuildContext context) {
    if (exercise is Exercise) {
      final ex = exercise as Exercise;

      switch (ex.type) {
        case ExerciseType.fourOptions:
          return FourOptionsWidget(
            exercise: ex,
            onAnswer: onAnswer,
          );
        case ExerciseType.writeAnswer:
          return WriteAnswerWidget(
            key: writeKey,
            exercise: ex,
            onAnswer: onAnswer,
          );
      }
    }

    if (exercise is GrammarEvaluatorExercise) {
      return WriteGrammarAnswerWidget(
        exercise: exercise as GrammarEvaluatorExercise,
        onAnswer: onAnswer,
      );
    }

    throw UnsupportedError('Unknown exercise widget');
  }
}

/* ================== EXERCISE WIDGETS ================== */

class FourOptionsWidget extends StatelessWidget {
  final Exercise exercise;
  final Function(String) onAnswer;

  const FourOptionsWidget({
    super.key,
    required this.exercise,
    required this.onAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(exercise.question, style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 24),
        ...exercise.options!.map(
          (opt) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: ElevatedButton(
              onPressed: () => onAnswer(opt),
              child: Text(opt),
            ),
          ),
        ),
      ],
    );
  }
}

class WriteAnswerWidget extends StatefulWidget {
  final Exercise exercise;
  final Function(String) onAnswer;

  const WriteAnswerWidget({
    super.key,
    required this.exercise,
    required this.onAnswer,
  });

  @override
  WriteAnswerWidgetState createState() => WriteAnswerWidgetState();
}

class WriteAnswerWidgetState extends State<WriteAnswerWidget> {
  final TextEditingController _controller = TextEditingController();

  void clear() => _controller.clear();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(widget.exercise.question, style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 24),
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Type your answer',
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => widget.onAnswer(_controller.text),
          child: const Text('Check Answer'),
        ),
      ],
    );
  }
}

class WriteGrammarAnswerWidget extends StatefulWidget {
  final GrammarEvaluatorExercise exercise;
  final Function(String) onAnswer;

  const WriteGrammarAnswerWidget({
    super.key,
    required this.exercise,
    required this.onAnswer,
  });

  @override
  State<WriteGrammarAnswerWidget> createState() =>
      _WriteGrammarAnswerWidgetState();
}

class _WriteGrammarAnswerWidgetState extends State<WriteGrammarAnswerWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(widget.exercise.question, style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 24),
        TextField(
          controller: _controller,
          maxLines: 3,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Write your sentence',
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => widget.onAnswer(_controller.text),
          child: const Text('Check'),
        ),
      ],
    );
  }
}

/* ================== FEEDBACK ================== */

class FeedbackPanel extends StatelessWidget {
  final bool isCorrect;
  final String? correctAnswer;
  final GrammarFeedback? grammarFeedback;
  final VoidCallback onNext;

  const FeedbackPanel({
    super.key,
    required this.isCorrect,
    required this.correctAnswer,
    this.grammarFeedback,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
        decoration: BoxDecoration(
          color: isCorrect
              ? Colors.green.withOpacity(0.1)
              : Colors.red.withOpacity(0.1),
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------- HEADER ----------
            Row(
              children: [
                Icon(
                  isCorrect ? Icons.check_circle : Icons.cancel,
                  color: isCorrect ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    isCorrect ? 'Correct!' : 'Needs improvement',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),

            // ---------- CORRECTED SENTENCE ----------
            if (correctAnswer != null) ...[
              const SizedBox(height: 12),
              const Text(
                'Suggested correction:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(correctAnswer!),
            ],

            // ---------- GRAMMAR EXPLANATIONS ----------
            if (grammarFeedback != null &&
                grammarFeedback!.explanations.isNotEmpty) ...[
              const SizedBox(height: 12),
              const Text(
                'Why:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ...grammarFeedback!.explanations.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text('• $e'),
                ),
              ),
            ],

            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: onNext,
                child: const Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ================== SESSION SUMMARY ================== */

class SessionSummaryPage extends StatelessWidget {
  final int total;
  final int correct;

  const SessionSummaryPage({
    super.key,
    required this.total,
    required this.correct,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Session Summary')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You answered $correct out of $total correctly!',
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              child: const Text('Back to Home'),
              onPressed: () =>
                  Navigator.popUntil(context, (route) => route.isFirst),
            ),
          ],
        ),
      ),
    );
  }
}
