class Question {
  const Question({
    required this.text,
    required this.options,
    required this.answerIndex,
  });

  final String text;
  final List<String> options;
  final int answerIndex;

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      text: json['question'] as String,
      options: List<String>.from(json['options'] as List<dynamic>),
      answerIndex: json['answer'] as int,
    );
  }
}
