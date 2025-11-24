import '../../domain/models/github_stats.dart';
import '../services/github_api_service.dart';

class GithubStatsRepository {
  final GithubApiService _apiService;

  GithubStatsRepository({required GithubApiService apiService})
      : _apiService = apiService;

  Future<GithubStats> getStats(String username) async {
    final json = await _apiService.getGithubStats(username);

    return GithubStats.fromJson(json);
  }
}