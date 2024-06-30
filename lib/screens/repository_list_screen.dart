import 'package:flutter/material.dart';
import 'package:square_repos/widgets/repository_list.dart';

class RepositoryListScreen extends StatelessWidget {
  const RepositoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Square Repos'),
        centerTitle: true,
      ),
      body: const RepositoryList(),
    );
  }
}
