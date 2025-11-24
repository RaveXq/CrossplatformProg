import 'package:flutter_test/flutter_test.dart';
import 'package:resume_builder/ui/home/view_models/home_viewmodel.dart';
import 'package:resume_builder/domain/models/person_profile.dart';
import 'package:resume_builder/domain/models/skill.dart';
import '../../../fakes/fake_person_profile_repository.dart';

void main() {
  group('HomeViewModel tests', () {
    late HomeViewModel viewModel;
    late FakePersonProfileRepository fakeRepository;

    setUp(() {
      fakeRepository = FakePersonProfileRepository();
    });

    test('повинен завантажувати профілі при ініціалізації', () {
      viewModel = HomeViewModel(profileRepository: fakeRepository);

      expect(viewModel.profiles, isNotEmpty);
      expect(viewModel.profiles.length, 2);
    });

    test('повинен містити правильні дані профілю', () {
      viewModel = HomeViewModel(profileRepository: fakeRepository);

      final firstProfile = viewModel.profiles[0];
      expect(firstProfile.id, 1);
      expect(firstProfile.name, 'Тестовий');
      expect(firstProfile.surname, 'Користувач');
      expect(firstProfile.githubUsername, 'testuser');
    });

    test('loadProfiles повинен оновлювати список профілів', () {
      viewModel = HomeViewModel(profileRepository: fakeRepository);

      final initialCount = viewModel.profiles.length;

      fakeRepository.addProfile(
        PersonProfile(
          id: 3,
          name: 'Тестовий3',
          surname: 'Користувач3',
          bio: 'Test Bio 3',
          githubUsername: 'testuser3',
          skills: [
            Skill(name: 'Навичка5', description: 'Опис Навички5'),
          ],
        ),
      );

      viewModel.loadProfiles();

      expect(viewModel.profiles.length, initialCount + 1);
      expect(viewModel.profiles.last.name, 'Тестовий3');
    });

    test('повинен обробляти порожній список профілів', () {
      fakeRepository.clear();
      viewModel = HomeViewModel(profileRepository: fakeRepository);

      expect(viewModel.profiles, isEmpty);
    });

    test('повинен оновлювати профілі при зміні репозиторію', () {
      viewModel = HomeViewModel(profileRepository: fakeRepository);

      expect(viewModel.profiles.length, 2);

      fakeRepository.clear();
      viewModel.loadProfiles();

      expect(viewModel.profiles, isEmpty);
    });

    test('список профілів повинен бути незалежним від внутрішнього списку репозиторію', () {
      viewModel = HomeViewModel(profileRepository: fakeRepository);

      final profilesCopy = viewModel.profiles;
      fakeRepository.clear();

      expect(profilesCopy.length, 2);
      expect(viewModel.profiles.length, 2);

      viewModel.loadProfiles();
      expect(viewModel.profiles, isEmpty);
    });

    test('повинен підтримувати цілісність даних профілю', () {
      viewModel = HomeViewModel(profileRepository: fakeRepository);

      final profile = viewModel.profiles[0];
      expect(profile.skills, isNotEmpty);
      expect(profile.skills.length, 2);
      expect(profile.skills[0].name, 'Навичка1');
    });
  });
}
