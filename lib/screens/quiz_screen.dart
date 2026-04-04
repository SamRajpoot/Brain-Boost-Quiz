import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../viewmodels/quiz_view_model.dart';
import '../viewmodels/settings_view_model.dart';
import '../widgets/quiz_option_tile.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shakeController;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
    );
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  Future<void> _onAnswerTap(
    BuildContext context,
    int index,
    int correctIndex,
    bool soundEnabled,
  ) async {
    final quizVm = context.read<QuizViewModel>();
    if (quizVm.locked) {
      return;
    }
    quizVm.selectAnswer(index);

    if (soundEnabled) {
      await SystemSound.play(SystemSoundType.click);
    }
    await HapticFeedback.selectionClick();

    if (index != correctIndex) {
      _shakeController.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<QuizViewModel, SettingsViewModel>(
      builder: (context, quizVm, settingsVm, _) {
        final question = quizVm.currentQuestion;
        if (question == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final progress = (quizVm.currentQuestionIndex + 1) / quizVm.totalQuestions;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              '${quizVm.currentCategory?.name ?? 'Quiz'} - ${quizVm.currentQuestionIndex + 1}/${quizVm.totalQuestions}',
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0.10),
                  Theme.of(context).colorScheme.secondary.withOpacity(0.08),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: LinearProgressIndicator(
                      minHeight: 10,
                      value: progress,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Time Left: ${quizVm.secondsLeft}s',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Score: ${quizVm.score}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 350),
                      transitionBuilder: (child, animation) {
                        final offset = Tween<Offset>(
                          begin: const Offset(0.25, 0),
                          end: Offset.zero,
                        ).animate(animation);
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(position: offset, child: child),
                        );
                      },
                      child: Container(
                        key: ValueKey(quizVm.currentQuestionIndex),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Theme.of(context)
                              .cardColor
                              .withOpacity(0.86),
                          border: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.2),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              question.text,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 20),
                            for (int i = 0; i < question.options.length; i++)
                              AnimatedBuilder(
                                animation: _shakeController,
                                builder: (_, child) {
                                  final shouldShake = quizVm.locked &&
                                      quizVm.selectedAnswerIndex == i &&
                                      i != question.answerIndex;
                                  final dx = shouldShake
                                      ? sin(_shakeController.value * pi * 6) * 8
                                      : 0.0;
                                  return Transform.translate(
                                    offset: Offset(dx, 0),
                                    child: child,
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: QuizOptionTile(
                                    index: i,
                                    text: question.options[i],
                                    selectedIndex: quizVm.selectedAnswerIndex,
                                    correctIndex: question.answerIndex,
                                    locked: quizVm.locked,
                                    onTap: () => _onAnswerTap(
                                      context,
                                      i,
                                      question.answerIndex,
                                      settingsVm.soundEnabled,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: quizVm.locked
                          ? () async {
                              final hasMore = await quizVm.goToNextQuestion();
                              if (!hasMore && context.mounted) {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (_) => const ResultScreen(),
                                  ),
                                );
                              }
                            }
                          : null,
                      child: Text(
                        quizVm.hasNextQuestion ? 'Next Question' : 'Finish Quiz',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
