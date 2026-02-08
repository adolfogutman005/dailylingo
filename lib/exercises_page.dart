import 'package:flutter/material.dart';

class PracticeItemPage extends StatefulWidget {
  const PracticeItemPage({super.key});

  @override
  State<PracticeItemPage> createState() => _PracticeItemPageState();
}

class _PracticeItemPageState extends State<PracticeItemPage> {
  int currentExerciseIndex = 0;
  bool? lastAnswerCorrect; // null = unanswered, true/false = result
  String? lastCorrectAnswer;

  late List<Exercise> exercises;

  @override
  void initState() {
    super.initState();

    // Dummy data
    exercises = [
      Exercise.fourOptions(
        question: 'Translate: Break down',
        options: ['analizar', 'romper', 'descomponer', 'terminar'],
        answer: 'descomponer',
      ),
      Exercise.writeAnswer(
        question: 'Write the meaning of "Analyze"',
        answer: 'analizar',
      ),
      Exercise.fourOptions(
        question: 'Translate: Understand',
        options: ['comprender', 'olvidar', 'romper', 'correr'],
        answer: 'comprender',
      ),
    ];
  }

  void handleAnswer(String userAnswer) {
    bool isCorrect = userAnswer.toLowerCase() ==
        exercises[currentExerciseIndex].answer.toLowerCase();

    setState(() {
      lastAnswerCorrect = isCorrect;
      lastCorrectAnswer = exercises[currentExerciseIndex].answer;
    });
  }

  void nextExercise() {
    if (currentExerciseIndex < exercises.length - 1) {
      setState(() {
        currentExerciseIndex++;
        lastAnswerCorrect = null;
        lastCorrectAnswer = null;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => SessionSummaryPage(
            total: exercises.length,
            correct: exercises
                .where((ex) => ex.answer == lastCorrectAnswer)
                .length, // For dummy purposes
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final exercise = exercises[currentExerciseIndex];

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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ExerciseCard(exercise: exercise, onAnswer: handleAnswer),
      ),
      bottomNavigationBar: lastAnswerCorrect == null
          ? null
          : BottomAppBar(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    lastAnswerCorrect!
                        ? Row(
                            children: const [
                              Icon(Icons.check, color: Colors.green),
                              SizedBox(width: 8),
                              Text('Correct!', style: TextStyle(fontSize: 16)),
                            ],
                          )
                        : Row(
                            children: [
                              const Icon(Icons.close, color: Colors.red),
                              const SizedBox(width: 8),
                              Text(
                                'Incorrect! (${lastCorrectAnswer})',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                    ElevatedButton(
                      onPressed: nextExercise,
                      child: const Text('Next'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

// ================== EXERCISE CARD (WRAPPER) ==================
class ExerciseCard extends StatelessWidget {
  final Exercise exercise;
  final Function(String) onAnswer;

  const ExerciseCard(
      {super.key, required this.exercise, required this.onAnswer});

  @override
  Widget build(BuildContext context) {
    switch (exercise.type) {
      case ExerciseType.fourOptions:
        return FourOptionsWidget(exercise: exercise, onAnswer: onAnswer);
      case ExerciseType.writeAnswer:
        return WriteAnswerWidget(exercise: exercise, onAnswer: onAnswer);
      default:
        return const Center(child: Text('Unknown exercise type'));
    }
  }
}

// ================== EXERCISE WIDGETS ==================
class FourOptionsWidget extends StatelessWidget {
  final Exercise exercise;
  final Function(String) onAnswer;

  const FourOptionsWidget(
      {super.key, required this.exercise, required this.onAnswer});

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

  const WriteAnswerWidget(
      {super.key, required this.exercise, required this.onAnswer});

  @override
  State<WriteAnswerWidget> createState() => _WriteAnswerWidgetState();
}

class _WriteAnswerWidgetState extends State<WriteAnswerWidget> {
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
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Type your answer here',
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

// ================== SESSION SUMMARY ==================
class SessionSummaryPage extends StatelessWidget {
  final int total;
  final int correct;

  const SessionSummaryPage(
      {super.key, required this.total, required this.correct});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Session Summary')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You answered $correct out of $total correctly!',
                style: const TextStyle(fontSize: 22)),
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

// ================== EXERCISE MODELS ==================
enum ExerciseType { fourOptions, writeAnswer }

class Exercise {
  final ExerciseType type;
  final String question;
  final List<String>? options;
  final String answer;

  Exercise({
    required this.type,
    required this.question,
    required this.answer,
    this.options,
  });

  factory Exercise.fourOptions({
    required String question,
    required List<String> options,
    required String answer,
  }) =>
      Exercise(
          type: ExerciseType.fourOptions,
          question: question,
          options: options,
          answer: answer);

  factory Exercise.writeAnswer({
    required String question,
    required String answer,
  }) =>
      Exercise(
          type: ExerciseType.writeAnswer, question: question, answer: answer);
}
