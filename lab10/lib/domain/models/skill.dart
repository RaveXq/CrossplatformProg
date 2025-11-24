class Skill {
  final String name;
  final String description;

  Skill({
    required this.name,
    required this.description,
  });

  Skill copyWith({
    String? name,
    String? description,
  }) {
    return Skill(
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
    };
  }

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      name: json['name'] as String,
      description: json['description'] as String,
    );
  }
}