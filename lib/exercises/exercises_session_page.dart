import 'package:flutter/material.dart';
import 'exercise.dart';
import 'exercises_page.dart';

class PracticeSessionPage extends StatelessWidget {
  final List<Exercise> exercises;

  const PracticeSessionPage({super.key, required this.exercises});

  @override
  Widget build(BuildContext context) {
    return PracticeItemPage(
      exercisesOverride: exercises,
    );
  }
}
