import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/quiz_category.dart';

class QuizRepository {
  const QuizRepository();

  Future<List<QuizCategory>> loadCategories() async {
    final rawData = await rootBundle.loadString('assets/data/quiz_data.json');
    final decoded = jsonDecode(rawData) as Map<String, dynamic>;
    final categories = decoded['categories'] as List<dynamic>;

    return categories
        .map((item) => QuizCategory.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
