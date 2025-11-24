import 'package:flutter/material.dart';
import '../../../data/repositories/person_profile_repository.dart';
import '../../../domain/models/person_profile.dart';

class HomeViewModel extends ChangeNotifier {
  final PersonProfileRepository _profileRepository;

  List<PersonProfile> _profiles = [];
  List<PersonProfile> get profiles => _profiles;

  HomeViewModel({required PersonProfileRepository profileRepository})
      : _profileRepository = profileRepository {
    loadProfiles();
  }

  void loadProfiles() {
    _profiles = List.from(_profileRepository.getProfiles());
    notifyListeners();
  }
}