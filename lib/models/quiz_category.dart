import 'question.dart';

class QuizCategory {
  const QuizCategory({
    required this.name,
    required this.iconName,
    required this.questions,
  });

  final String name;
  final String iconName;
  final List<Question> questions;

  factory QuizCategory.fromJson(Map<String, dynamic> json) {
    return QuizCategory(
      name: json['name'] as String,
      iconName: (json['icon'] as String?) ?? 'quiz',
      questions: (json['questions'] as List<dynamic>)
          .map((item) => Question.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
