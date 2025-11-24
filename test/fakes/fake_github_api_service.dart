import 'package:resume_builder/data/services/github_api_service.dart';

class FakeGithubApiService implements GithubApiService {
  final Map<String, Map<String, dynamic>> _mockData = {
    'testuser': {
      'public_repos': 25,
      'followers': 150,
      'following': 75,
    },
    'emptyuser': {
      'public_repos': 0,
      'followers': 0,
      'following': 0,
    },
  };

  bool shouldThrowError = false;
  String? errorMessage;

  @override
  String get _baseUrl => 'https://api.github.com/users/';

  @override
  Future<Map<String, dynamic>> getGithubStats(String username) async {
    if (shouldThrowError) {
      throw Exception(errorMessage ?? 'Test error');
    }

    if (username.isEmpty) {
      throw Exception('Ім`я користувача GitHub не вказано');
    }

    if (_mockData.containsKey(username)) {
      return _mockData[username]!;
    }

    throw Exception(
        'Не вдалося завантажити статистику. Користувач "$username" не знайдений (код: 404)');
  }

  void addMockUser(String username, Map<String, dynamic> data) {
    _mockData[username] = data;
  }

  void reset() {
    shouldThrowError = false;
    errorMessage = null;
  }
}
