import 'package:flutter_test/flutter_test.dart';
import 'package:lab10/domain/models/github_stats.dart';

void main() {
  group('GithubStats tests', () {
    test('має створити екземпляр GithubStats з обов`язковими полями', () {
      final stats = GithubStats(
        publicRepos: 25,
        followers: 150,
        following: 75,
      );

      expect(stats.publicRepos, 25);
      expect(stats.followers, 150);
      expect(stats.following, 75);
    });

    test('fromJson має створити GithubStats з Map', () {
      final json = {
        'public_repos': 30,
        'followers': 200,
        'following': 100,
      };

      final stats = GithubStats.fromJson(json);

      expect(stats.publicRepos, 30);
      expect(stats.followers, 200);
      expect(stats.following, 100);
    });

    test('fromJson має використовувати дефолтні значення коли поля null', () {
      final json = {
        'public_repos': null,
        'followers': null,
        'following': null,
      };

      final stats = GithubStats.fromJson(json);

      expect(stats.publicRepos, 0);
      expect(stats.followers, 0);
      expect(stats.following, 0);
    });

    test('fromJson має обробляти відсутні поля з дефолтними значеннями', () {
      final json = <String, dynamic>{};

      final stats = GithubStats.fromJson(json);

      expect(stats.publicRepos, 0);
      expect(stats.followers, 0);
      expect(stats.following, 0);
    });

    test('fromJson має обробляти часткові дані', () {
      final json = {
        'public_repos': 10,
        'followers': null,
      };

      final stats = GithubStats.fromJson(json);

      expect(stats.publicRepos, 10);
      expect(stats.followers, 0);
      expect(stats.following, 0);
    });

    test('має працювати з нульовими значеннями', () {
      final stats = GithubStats(
        publicRepos: 0,
        followers: 0,
        following: 0,
      );

      expect(stats.publicRepos, 0);
      expect(stats.followers, 0);
      expect(stats.following, 0);
    });

    test('має працювати з великими числами', () {
      final stats = GithubStats(
        publicRepos: 1000,
        followers: 50000,
        following: 2000,
      );

      expect(stats.publicRepos, 1000);
      expect(stats.followers, 50000);
      expect(stats.following, 2000);
    });
  });
}
