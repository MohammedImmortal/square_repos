class RepositoryModel {
  final String repoName;
  final String description;
  final String ownerName;
  final bool isFork;
  final String repoUrl;
  final String ownerUrl;

  RepositoryModel({
    required this.repoName,
    required this.description,
    required this.ownerName,
    required this.isFork,
    required this.repoUrl,
    required this.ownerUrl,
  });

  factory RepositoryModel.fromJson(Map<String, dynamic> json) {
    return RepositoryModel(
      repoName: json['name'],
      description: json['description'] ?? '',
      ownerName: json['owner']['login'],
      isFork: json['fork'] ?? false,
      repoUrl: json['html_url'],
      ownerUrl: json['owner']['html_url'],
    );
  }
}
