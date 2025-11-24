import 'package:flutter_test/flutter_test.dart';
import 'package:lab10/data/repositories/github_stats_repository.dart';
import '../../fakes/fake_github_api_service.dart';

void main() {
  group('GithubStatsRepository tests', () {
    late GithubStatsRepository repository;
    late FakeGithubApiService fakeApiService;

    setUp(() {
      fakeApiService = FakeGithubApiService();
      repository = GithubStatsRepository(apiService: fakeApiService);
    });

    test('повинен отримувати статистику github для дійсного користувача', () async {
      final stats = await repository.getStats('testuser');

      expect(stats.publicRepos, 25);
      expect(stats.followers, 150);
      expect(stats.following, 75);
    });

    test('повинен отримувати статистику github для користувача з нульовою статистикою', () async {
      final stats = await repository.getStats('emptyuser');

      expect(stats.publicRepos, 0);
      expect(stats.followers, 0);
      expect(stats.following, 0);
    });

    test('повинен викликати виняток для порожнього імені користувача', () async {
      expect(
        () => repository.getStats(''),
        throwsException,
      );
    });

    test('повинен викликати виняток для неіснуючого користувача', () async {
      expect(
        () => repository.getStats('nonexistentuser123'),
        throwsException,
      );
    });

    test('повинен обробляти власні mock-data', () async {
      fakeApiService.addMockUser('customuser', {
        'public_repos': 100,
        'followers': 500,
        'following': 200,
      });

      final stats = await repository.getStats('customuser');

      expect(stats.publicRepos, 100);
      expect(stats.followers, 500);
      expect(stats.following, 200);
    });

    test('повинен обробляти помилки служби api', () async {
      fakeApiService.shouldThrowError = true;
      fakeApiService.errorMessage = 'Network error';

      expect(
        () => repository.getStats('testuser'),
        throwsException,
      );
    });
  });
}
