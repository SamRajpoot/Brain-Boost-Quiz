import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../viewmodels/quiz_view_model.dart';
import '../viewmodels/settings_view_model.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static final Uri _privacyUrl =
      Uri.parse('https://www.brainboostquiz.com/privacy-policy');

  @override
  Widget build(BuildContext context) {
    return Consumer2<SettingsViewModel, QuizViewModel>(
      builder: (_, settingsVm, quizVm, __) {
        return Scaffold(
          appBar: AppBar(title: const Text('Settings')),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Column(
                  children: [
                    SwitchListTile(
                      title: const Text('Dark Mode'),
                      subtitle: const Text('Switch between light and dark theme'),
                      value: settingsVm.darkMode,
                      onChanged: settingsVm.toggleDarkMode,
                    ),
                    SwitchListTile(
                      title: const Text('Sound Effects'),
                      subtitle: const Text('Play tap sounds during quiz'),
                      value: settingsVm.soundEnabled,
                      onChanged: settingsVm.toggleSound,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Local Leaderboard',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (quizVm.highScores.isEmpty)
                        const Text('No scores yet. Complete a quiz to rank!'),
                      for (final entry in quizVm.highScores.entries)
                        ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          title: Text(entry.key),
                          trailing: Text('Best: ${entry.value}/10'),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.privacy_tip_outlined),
                  title: const Text('Privacy Policy'),
                  subtitle: const Text('Required for Play Store listing'),
                  trailing: const Icon(Icons.open_in_new),
                  onTap: () => launchUrl(_privacyUrl,
                      mode: LaunchMode.externalApplication),
                ),
              ),
              const SizedBox(height: 12),
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Play Store Compliance',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text('- No login/signup required'),
                      Text('- Works fully offline using local JSON'),
                      Text('- No unnecessary permissions requested'),
                      Text('- No personal data collected by app logic'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
