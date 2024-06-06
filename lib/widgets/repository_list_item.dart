import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/repository.dart';

class RepositoryListItem extends StatelessWidget {
  final RepositoryModel repo;

  const RepositoryListItem({super.key, required this.repo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => _showRepoDialog(context),
      child: Container(
        color: repo.isFork ? Colors.white : Colors.lightGreen[100],
        child: ListTile(
          title: Text(repo.name),
          subtitle: Text(repo.description),
          trailing: Text(repo.owner),
        ),
      ),
    );
  }

  void _showRepoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Open URL'),
        content: const Text(
            'Do you want to open the repository or the owner profile?'),
        actions: [
          TextButton(
            onPressed: () => _launchURL(repo.repoUrl),
            child: const Text('Repository'),
          ),
          TextButton(
            onPressed: () => _launchURL(repo.ownerUrl),
            child: const Text('Owner'),
          ),
        ],
      ),
    );
  }

  void _launchURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
