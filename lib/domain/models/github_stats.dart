class GithubStats {
  final int publicRepos;
  final int followers;
  final int following;

  GithubStats({
    required this.publicRepos,
    required this.followers,
    required this.following,
  });

  factory GithubStats.fromJson(Map<String, dynamic> json) {
    return GithubStats(
      publicRepos: json['public_repos'] ?? 0,
      followers: json['followers'] ?? 0,
      following: json['following'] ?? 0,
    );
  }
}