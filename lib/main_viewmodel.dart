import 'package:flutter/material.dart';
import 'data/repositories/appconfig/app_config_repository.dart';

class MainAppViewModel extends ChangeNotifier {
  final AppConfigRepository _appConfigRepository;

  MainAppViewModel(this._appConfigRepository) {
    _isDarkMode = _appConfigRepository.isDarkMode;
  }

  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _appConfigRepository.setDarkMode(_isDarkMode);
    notifyListeners();
  }
}
