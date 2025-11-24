import 'package:flutter/material.dart';
import '../../../data/repositories/github_stats_repository.dart';
import '../../../data/repositories/person_profile_repository.dart';
import '../../../domain/models/github_stats.dart';
import '../../../domain/models/person_profile.dart';

class DetailsViewModel extends ChangeNotifier {
  final PersonProfileRepository _profileRepository;
  final GithubStatsRepository _statsRepository;

  late PersonProfile _profile;
  PersonProfile get profile => _profile;

  GithubStats? _stats;
  GithubStats? get stats => _stats;

  bool _isLoadingStats = false;
  bool get isLoadingStats => _isLoadingStats;

  String? _statsError;
  String? get statsError => _statsError;

  DetailsViewModel({
    required PersonProfileRepository profileRepository,
    required GithubStatsRepository statsRepository,
  })  : _profileRepository = profileRepository,
        _statsRepository = statsRepository;

  void loadProfile(int id) {
    _profile = _profileRepository.getProfileById(id);
    _loadGithubStats(_profile.githubUsername);
    notifyListeners(); 
  }

  Future<void> _loadGithubStats(String username) async {
    try {
      _isLoadingStats = true;
      _statsError = null;
      notifyListeners();

      _stats = await _statsRepository.getStats(username);
      
    } catch (e) {
      _statsError = e.toString().replaceAll("Exception: ", "");

    } finally {
      _isLoadingStats = false;
      notifyListeners();
    }
  }
}