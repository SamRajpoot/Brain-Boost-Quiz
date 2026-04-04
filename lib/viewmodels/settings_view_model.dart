import 'package:flutter/foundation.dart';

import '../services/local_storage_service.dart';

class SettingsViewModel extends ChangeNotifier {
  SettingsViewModel(this._storageService);

  final LocalStorageService _storageService;
  bool darkMode = false;
  bool soundEnabled = true;
  bool initialized = false;

  Future<void> initialize() async {
    darkMode = await _storageService.getDarkMode();
    soundEnabled = await _storageService.getSoundEnabled();
    initialized = true;
    notifyListeners();
  }

  Future<void> toggleDarkMode(bool value) async {
    darkMode = value;
    notifyListeners();
    await _storageService.setDarkMode(value);
  }

  Future<void> toggleSound(bool value) async {
    soundEnabled = value;
    notifyListeners();
    await _storageService.setSoundEnabled(value);
  }
}
