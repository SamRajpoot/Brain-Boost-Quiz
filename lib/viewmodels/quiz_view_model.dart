import 'dart:async';

import 'package:flutter/foundation.dart';

import '../models/question.dart';
import '../models/quiz_category.dart';
import '../services/local_storage_service.dart';
import '../services/quiz_repository.dart';

class QuizViewModel extends ChangeNotifier {
  QuizViewModel(this._repository, this._storageService);

  final QuizRepository _repository;
  final LocalStorageService _storageService;

  List<QuizCategory> categories = [];
  Map<String, int> highScores = {};

  QuizCategory? currentCategory;
  int currentQuestionIndex = 0;
  int selectedAnswerIndex = -1;
  int score = 0;
  int correctAnswers = 0;
  int wrongAnswers = 0;
  int secondsLeft = 12;
  bool locked = false;
  bool isLoading = true;

  Timer? _timer;

  int get totalQuestions => currentCategory?.questions.length ?? 0;

  Question? get currentQuestion {
    if (currentCategory == null || currentQuestionIndex >= totalQuestions) {
      return null;
    }
    return currentCategory!.questions[currentQuestionIndex];
  }

  Future<void> initialize() async {
    isLoading = true;
    notifyListeners();

    categories = await _repository.loadCategories();
    highScores = await _storageService.getHighScores();

    isLoading = false;
    notifyListeners();
  }

  void startQuiz(QuizCategory category) {
    currentCategory = category;
    currentQuestionIndex = 0;
    selectedAnswerIndex = -1;
    score = 0;
    correctAnswers = 0;
    wrongAnswers = 0;
    locked = false;
    _startQuestionTimer();
    notifyListeners();
  }

  void _startQuestionTimer() {
    _timer?.cancel();
    secondsLeft = 12;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsLeft <= 0) {
        timer.cancel();
        _lockAndAdvanceTimeout();
      } else {
        secondsLeft--;
        notifyListeners();
      }
    });
  }

  void selectAnswer(int index) {
    if (locked || currentQuestion == null) {
      return;
    }
    locked = true;
    selectedAnswerIndex = index;
    _timer?.cancel();

    final isCorrect = index == currentQuestion!.answerIndex;
    if (isCorrect) {
      score++;
      correctAnswers++;
    } else {
      wrongAnswers++;
    }

    notifyListeners();
  }

  void _lockAndAdvanceTimeout() {
    if (locked) {
      return;
    }
    locked = true;
    selectedAnswerIndex = -1;
    wrongAnswers++;
    notifyListeners();
  }

  bool get hasNextQuestion => currentQuestionIndex < totalQuestions - 1;

  Future<bool> goToNextQuestion() async {
    if (!locked) {
      return false;
    }

    if (hasNextQuestion) {
      currentQuestionIndex++;
      selectedAnswerIndex = -1;
      locked = false;
      _startQuestionTimer();
      notifyListeners();
      return true;
    }

    _timer?.cancel();
    if (currentCategory != null) {
      await _storageService.saveHighScore(currentCategory!.name, score);
      highScores = await _storageService.getHighScores();
      notifyListeners();
    }
    return false;
  }

  int highScoreFor(String categoryName) => highScores[categoryName] ?? 0;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
