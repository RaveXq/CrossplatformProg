import 'package:flutter/material.dart';
import '../../../data/repositories/person_profile_repository.dart';
import '../../../domain/models/person_profile.dart';
import '../../../domain/models/skill.dart';

class EditProfileViewModel extends ChangeNotifier {
  final PersonProfileRepository _profileRepository;

  PersonProfile? _originalProfile;
  bool _isDuplicating = false;

  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final bioController = TextEditingController();
  final githubController = TextEditingController();
  
  final skillNameController = TextEditingController();
  final skillDescController = TextEditingController();

  List<Skill> _skills = [];
  List<Skill> get skills => _skills;

  String get pageTitle => _originalProfile == null || _isDuplicating 
      ? "Створення профілю" 
      : "Редагування профілю";
      
  bool get isEditing => _originalProfile != null && !_isDuplicating;

  EditProfileViewModel({required PersonProfileRepository profileRepository})
      : _profileRepository = profileRepository;

  void loadProfile(PersonProfile? profile, {bool isDuplicating = false}) {
    _originalProfile = profile;
    _isDuplicating = isDuplicating;
    
    if (profile != null) {
      nameController.text = profile.name;
      surnameController.text = profile.surname;
      bioController.text = profile.bio;
      githubController.text = profile.githubUsername;
      _skills = List<Skill>.from(profile.skills.map((s) => s.copyWith()));
    } else {
      nameController.clear();
      surnameController.clear();
      bioController.clear();
      githubController.clear();
      _skills = [];
    }
    notifyListeners();
  }

  void addSkill() {
    if (skillNameController.text.isNotEmpty && skillDescController.text.isNotEmpty) {
      _skills.add(Skill(
        name: skillNameController.text,
        description: skillDescController.text,
      ));
      skillNameController.clear();
      skillDescController.clear();
      notifyListeners();
    }
  }

  void removeSkill(int index) {
    _skills.removeAt(index);
    notifyListeners();
  }

  Future<void> saveProfile() async {
    final profileToSave = PersonProfile(
      id: isEditing ? _originalProfile!.id : 0,
      name: nameController.text,
      surname: surnameController.text,
      bio: bioController.text,
      githubUsername: githubController.text,
      skills: _skills,
    );

    await _profileRepository.saveProfile(profileToSave);
  }

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    bioController.dispose();
    githubController.dispose();
    skillNameController.dispose();
    skillDescController.dispose();
    super.dispose();
  }
}