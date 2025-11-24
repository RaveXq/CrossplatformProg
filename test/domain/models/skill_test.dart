import 'package:flutter_test/flutter_test.dart';
import 'package:lab10/domain/models/skill.dart';

void main() {
  group('Skill tests', () {
    test('має створити екземпляр Skill з обов`язковими полями', () {
      final skill = Skill(
        name: 'Навичка1',
        description: 'Опис Навички1',
      );

      expect(skill.name, 'Навичка1');
      expect(skill.description, 'Опис Навички1');
    });

    test('copyWith має створити новий екземпляр зі зміненими полями', () {
      final skill = Skill(
        name: 'Навичка1',
        description: 'Опис Навички1',
      );

      final updatedSkill = skill.copyWith(
        name: 'Навичка2',
      );

      expect(updatedSkill.name, 'Навичка2');
      expect(updatedSkill.description, 'Опис Навички1');
      expect(skill.name, 'Навичка1');
    });

    test('copyWith має зберігати оригінальні значення коли параметри не передані', () {
      final skill = Skill(
        name: 'Навичка1',
        description: 'Опис Навички1',
      );

      final copiedSkill = skill.copyWith();

      expect(copiedSkill.name, skill.name);
      expect(copiedSkill.description, skill.description);
    });

    test('toJson має повертати правильний Map', () {
      final skill = Skill(
        name: 'Навичка1',
        description: 'Опис Навички1',
      );

      final json = skill.toJson();

      expect(json, {
        'name': 'Навичка1',
        'description': 'Опис Навички1',
      });
    });

    test('fromJson має створити Skill з Map', () {
      final json = {
        'name': 'Навичка2',
        'description': 'Опис Навички2',
      };

      final skill = Skill.fromJson(json);

      expect(skill.name, 'Навичка2');
      expect(skill.description, 'Опис Навички2');
    });

    test('toJson та fromJson мають бути оборотними', () {
      final originalSkill = Skill(
        name: 'Навичка3',
        description: 'Опис Навички3',
      );

      final json = originalSkill.toJson();
      final recreatedSkill = Skill.fromJson(json);

      expect(recreatedSkill.name, originalSkill.name);
      expect(recreatedSkill.description, originalSkill.description);
    });
  });
}
