import 'skill.dart';

class PersonProfile {
  final int id;
  final String name;
  final String surname;
  final String bio;
  final List<Skill> skills;
  final String githubUsername;

  PersonProfile({
    required this.id,
    required this.name,
    required this.surname,
    required this.bio,
    required this.skills,
    required this.githubUsername,
  });

  PersonProfile copyWith({
    int? id,
    String? name,
    String? surname,
    String? bio,
    List<Skill>? skills,
    String? githubUsername,
  }) {
    return PersonProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      bio: bio ?? this.bio,
      skills: skills ?? this.skills,
      githubUsername: githubUsername ?? this.githubUsername,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'bio': bio,
      'skills': skills.map((skill) => skill.toJson()).toList(),
      'githubUsername': githubUsername,
    };
  }

  factory PersonProfile.fromJson(Map<String, dynamic> json) {
    return PersonProfile(
      id: json['id'] as int,
      name: json['name'] as String,
      surname: json['surname'] as String,
      bio: json['bio'] as String,
      skills: (json['skills'] as List<dynamic>)
          .map((skillJson) => Skill.fromJson(skillJson as Map<String, dynamic>))
          .toList(),
      githubUsername: json['githubUsername'] as String,
    );
  }
}