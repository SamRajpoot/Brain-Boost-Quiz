import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const _highScoresKey = 'high_scores';

  Future<Map<String, int>> getHighScores() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_highScoresKey);
    if (raw == null || raw.isEmpty) {
      return {};
    }

    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    return decoded.map((key, value) => MapEntry(key, value as int));
  }

  Future<void> saveHighScore(String category, int score) async {
    final prefs = await SharedPreferences.getInstance();
    final scores = await getHighScores();
    final current = scores[category] ?? 0;

    if (score > current) {
      scores[category] = score;
      await prefs.setString(_highScoresKey, jsonEncode(scores));
    }
  }

  Future<bool> getDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('dark_mode') ?? false;
  }

  Future<void> setDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dark_mode', value);
  }

  Future<bool> getSoundEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('sound_enabled') ?? true;
  }

  Future<void> setSoundEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('sound_enabled', value);
  }
}
