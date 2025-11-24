import 'package:lab10/data/repositories/person_profile_repository.dart';
import 'package:lab10/domain/models/person_profile.dart';
import 'package:lab10/domain/models/skill.dart';

class FakePersonProfileRepository implements PersonProfileRepository {
  final List<PersonProfile> _profiles = [];
  bool _isInitialized = false;

  FakePersonProfileRepository() {
    _profiles.addAll(_getDefaultTestProfiles());
  }

  List<PersonProfile> _getDefaultTestProfiles() {
    return [
      PersonProfile(
        id: 1,
        name: 'Тестовий',
        surname: 'Користувач',
        bio: 'Test Bio',
        githubUsername: 'testuser',
        skills: [
          Skill(name: 'Навичка1', description: 'Опис Навички1'),
          Skill(name: 'Навичка2', description: 'Опис Навички2'),
        ],
      ),
      PersonProfile(
        id: 2,
        name: 'Тестовий2',
        surname: 'Користувач2',
        bio: 'Test Bio 2',
        githubUsername: 'testuser2',
        skills: [
          Skill(name: 'Навичка3', description: 'Опис Навички3'),
          Skill(name: 'Навичка4', description: 'Опис Навички4'),
        ],
      ),
    ];
  }

  @override
  Future<void> initialize() async {
    _isInitialized = true;
  }

  @override
  List<PersonProfile> getProfiles() {
    return List.from(_profiles);
  }

  @override
  PersonProfile getProfileById(int id) {
    return _profiles.firstWhere((profile) => profile.id == id);
  }

  @override
  Future<void> saveProfile(PersonProfile profile) async {
    final index = _profiles.indexWhere((p) => p.id == profile.id);

    if (index != -1) {
      _profiles[index] = profile;
    } else {
      final maxId = _profiles.isEmpty
          ? 0
          : _profiles.map((p) => p.id).reduce((a, b) => a > b ? a : b);
      final newProfile = profile.copyWith(id: maxId + 1);
      _profiles.add(newProfile);
    }
  }

  @override
  Future<void> deleteProfile(int id) async {
    _profiles.removeWhere((profile) => profile.id == id);
  }

  void addProfile(PersonProfile profile) {
    _profiles.add(profile);
  }

  void clear() {
    _profiles.clear();
  }

  void reset() {
    _profiles.clear();
    _profiles.addAll(_getDefaultTestProfiles());
    _isInitialized = false;
  }

  bool get isInitialized => _isInitialized;
}
