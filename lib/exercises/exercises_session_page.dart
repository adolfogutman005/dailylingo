import 'package:flutter/material.dart';
import 'models/base_exercise.dart';
import 'exercises_page.dart';

class PracticeSessionPage extends StatelessWidget {
  final List<BaseExercise> exercises;

  const PracticeSessionPage({super.key, required this.exercises});

  @override
  Widget build(BuildContext context) {
    return PracticeItemPage(
      exercisesOverride: exercises,
    );
  }
}
