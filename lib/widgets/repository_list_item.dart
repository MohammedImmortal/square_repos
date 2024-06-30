import 'package:flutter/material.dart';
import 'package:square_repos/models/repository.dart';
import 'package:url_launcher/url_launcher.dart';

class RepositoryListItem extends StatelessWidget {
  final RepositoryModel repo;

  const RepositoryListItem({super.key, required this.repo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => _showRepoDialog(context, repo),
      child: Container(
        color: repo.isFork ? Colors.white : Colors.lightGreen[100],
        child: ListTile(
          title: Text(repo.repoName),
          subtitle: Text(repo.description),
          trailing: Text(repo.ownerName),
        ),
      ),
    );
  }

  void _showRepoDialog(BuildContext context, RepositoryModel repo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Open URL'),
        content: const Text(
            'Do you want to open the repository or the owner profile?'),
        actions: [
          TextButton(
            onPressed: () => _launchURL(Uri.parse(repo.repoUrl)),
            child: const Text('Repository'),
          ),
          TextButton(
            onPressed: () => _launchURL(Uri.parse(repo.ownerUrl)),
            child: const Text('Owner'),
          ),
        ],
      ),
    );
  }

  void _launchURL(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
}
