import '../../domain/models/person_profile.dart';
import '../../domain/models/skill.dart';
import 'dart:math';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PersonProfileRepository {
  static const String _storageKey = 'person_profiles';
  final List<PersonProfile> _profiles = [];
  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    final String? profilesJson = prefs.getString(_storageKey);

    if (profilesJson != null && profilesJson.isNotEmpty) {
      try {
        final List<dynamic> decodedList = jsonDecode(profilesJson);
        _profiles.clear();
        _profiles.addAll(
          decodedList.map((json) => PersonProfile.fromJson(json)).toList(),
        );
      } catch (e) {
        _profiles.addAll(_getDefaultProfiles());
        await _saveToStorage();
      }
    } else {
      _profiles.addAll(_getDefaultProfiles());
      await _saveToStorage();
    }

    _isInitialized = true;
  }

  List<PersonProfile> _getDefaultProfiles() {
    return [
      PersonProfile(
        id: 1,
        name: "Дмитро",
        surname: "Сиклицький",
        bio: "Flutter Developer",
        githubUsername: "RaveXq",
        skills: [
          Skill(name: "Flutter & Dart", description: "Маю досвід розробки проектів на Flutter і Dart."),
          Skill(name: "Git", description: "Вмію працювати з Git."),
          Skill(name: "Soft Skills", description: "Стресостійкий, працьовитий, легко знаходжу спільну мову з людьми."),
        ],
      ),
      PersonProfile(
        id: 2,
        name: "Тарас",
        surname: "Шевченко",
        bio: "Full Stack Developer",
        githubUsername: "torvalds",
        skills: [
          Skill(name: "HTML, CSS, JavaScript", description: "Володію основами створення адаптивних та інтерактивних інтерфейсів."),
          Skill(name: "Docker", description: "Використовую Docker для контейнеризації додатків і спрощення розгортання."),
          Skill(name: "Soft Skills", description: "Відповідальний, націлений на результат, легко працюю в команді."),
          Skill(name: "Python & Django", description: "Маю досвід бекенд-розробки та створення API на Django."),
        ],
      ),
    ];
  }

  Future<void> _saveToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> jsonList =
        _profiles.map((profile) => profile.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    await prefs.setString(_storageKey, jsonString);
    await prefs.reload();
  }

  List<PersonProfile> getProfiles() {
    return _profiles;
  }

  PersonProfile getProfileById(int id) {
    return _profiles.firstWhere((profile) => profile.id == id);
  }

  Future<void> saveProfile(PersonProfile profile) async {
    final index = _profiles.indexWhere((p) => p.id == profile.id);

    if (index != -1) {
      _profiles[index] = profile;
    } else {
      final newProfile = profile.copyWith(
        id: _profiles.isEmpty ? 1 : _profiles.map((p) => p.id).reduce(max) + 1,
      );
      _profiles.add(newProfile);
    }

    await _saveToStorage();
  }

  Future<void> deleteProfile(int id) async {
    _profiles.removeWhere((profile) => profile.id == id);
    await _saveToStorage();
  }
}