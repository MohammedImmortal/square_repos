class RepositoryModel {
  final String name;
  final String description;
  final String owner;
  final bool isFork;
  final Uri repoUrl;
  final Uri ownerUrl;

  RepositoryModel({
    required this.name,
    required this.description,
    required this.owner,
    required this.isFork,
    required this.repoUrl,
    required this.ownerUrl,
  });

  factory RepositoryModel.fromJson(Map<String, dynamic> repository) {
    return RepositoryModel(
      name: repository['name'],
      description: repository['description'] ?? '',
      owner: repository['owner']['login'],
      isFork: repository['fork'] ?? false,
      repoUrl: repository['html_url'],
      ownerUrl: repository['owner']['html_url'],
    );
  }
}
