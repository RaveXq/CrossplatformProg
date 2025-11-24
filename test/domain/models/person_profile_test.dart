import 'package:flutter_test/flutter_test.dart';
import 'package:lab10/domain/models/person_profile.dart';
import 'package:lab10/domain/models/skill.dart';

void main() {
  group('PersonProfile tests', () {
    final testSkills = [
      Skill(name: 'Навичка1', description: 'Опис Навички1'),
      Skill(name: 'Навичка2', description: 'Опис Навички2'),
    ];

    test('має створити екземпляр PersonProfile з обов`язковими полями', () {
      final profile = PersonProfile(
        id: 1,
        name: 'Тестовий',
        surname: 'Користувач',
        bio: 'Test Bio',
        skills: testSkills,
        githubUsername: 'testuser',
      );

      expect(profile.id, 1);
      expect(profile.name, 'Тестовий');
      expect(profile.surname, 'Користувач');
      expect(profile.bio, 'Test Bio');
      expect(profile.skills, testSkills);
      expect(profile.githubUsername, 'testuser');
    });

    test('copyWith має створити новий екземпляр зі зміненими полями', () {
      final profile = PersonProfile(
        id: 1,
        name: 'Тестовий',
        surname: 'Користувач',
        bio: 'Test Bio',
        skills: testSkills,
        githubUsername: 'testuser',
      );

      final updatedProfile = profile.copyWith(
        name: 'Тестовий2',
        bio: 'Updated Test Bio',
      );

      expect(updatedProfile.name, 'Тестовий2');
      expect(updatedProfile.bio, 'Updated Test Bio');
      expect(updatedProfile.surname, 'Користувач');
      expect(updatedProfile.id, 1);
    });

    test('copyWith має зберігати оригінальні значення коли параметри не передані', () {
      final profile = PersonProfile(
        id: 1,
        name: 'Тестовий',
        surname: 'Користувач',
        bio: 'Test Bio',
        skills: testSkills,
        githubUsername: 'testuser',
      );

      final copiedProfile = profile.copyWith();

      expect(copiedProfile.id, profile.id);
      expect(copiedProfile.name, profile.name);
      expect(copiedProfile.surname, profile.surname);
      expect(copiedProfile.bio, profile.bio);
      expect(copiedProfile.skills, profile.skills);
      expect(copiedProfile.githubUsername, profile.githubUsername);
    });

    test('toJson має повертати правильний Map з навичками', () {
      final profile = PersonProfile(
        id: 1,
        name: 'Тестовий',
        surname: 'Користувач',
        bio: 'Test Bio',
        skills: testSkills,
        githubUsername: 'testuser',
      );

      final json = profile.toJson();

      expect(json['id'], 1);
      expect(json['name'], 'Тестовий');
      expect(json['surname'], 'Користувач');
      expect(json['bio'], 'Test Bio');
      expect(json['githubUsername'], 'testuser');
      expect(json['skills'], isA<List>());
      expect((json['skills'] as List).length, 2);
    });

    test('fromJson має створити PersonProfile з Map', () {
      final json = {
        'id': 2,
        'name': 'Тестовий2',
        'surname': 'Користувач2',
        'bio': 'Test Bio 2',
        'githubUsername': 'testuser2',
        'skills': [
          {'name': 'Навичка3', 'description': 'Опис Навички3'},
          {'name': 'Навичка4', 'description': 'Опис Навички4'},
        ],
      };

      final profile = PersonProfile.fromJson(json);

      expect(profile.id, 2);
      expect(profile.name, 'Тестовий2');
      expect(profile.surname, 'Користувач2');
      expect(profile.bio, 'Test Bio 2');
      expect(profile.githubUsername, 'testuser2');
      expect(profile.skills.length, 2);
      expect(profile.skills[0].name, 'Навичка3');
      expect(profile.skills[1].name, 'Навичка4');
    });

    test('toJson та fromJson мають бути оборотними', () {
      final originalProfile = PersonProfile(
        id: 3,
        name: 'Тестовий3',
        surname: 'Користувач3',
        bio: 'Test Bio 3',
        skills: testSkills,
        githubUsername: 'testuser3',
      );

      final json = originalProfile.toJson();
      final recreatedProfile = PersonProfile.fromJson(json);

      expect(recreatedProfile.id, originalProfile.id);
      expect(recreatedProfile.name, originalProfile.name);
      expect(recreatedProfile.surname, originalProfile.surname);
      expect(recreatedProfile.bio, originalProfile.bio);
      expect(recreatedProfile.githubUsername, originalProfile.githubUsername);
      expect(recreatedProfile.skills.length, originalProfile.skills.length);
    });

    test('має обробляти порожній список навичок', () {
      final profile = PersonProfile(
        id: 4,
        name: 'Тестовий4',
        surname: 'Користувач4',
        bio: 'Test Bio 4',
        skills: [],
        githubUsername: 'testuser4',
      );

      expect(profile.skills, isEmpty);

      final json = profile.toJson();
      final recreatedProfile = PersonProfile.fromJson(json);

      expect(recreatedProfile.skills, isEmpty);
    });
  });
}
