import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/repository.dart';
import '../provider/repository_provider.dart';
import '../widgets/repository_list_item.dart';

class RepositoryListScreen extends ConsumerStatefulWidget {
  const RepositoryListScreen({super.key});

  @override
  RepositoryListScreenState createState() => RepositoryListScreenState();
}

class RepositoryListScreenState extends ConsumerState<RepositoryListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final repositoryNotifier = ref.read(repositoryProvider.notifier);
    repositoryNotifier.fetchRepositories();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        repositoryNotifier.fetchRepositories();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final repositories = ref.watch(repositoryProvider);
    final repositoryNotifier = ref.read(repositoryProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Square Repos'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await repositoryNotifier.refreshRepositories();
        },
        child: ListView.builder(
          controller: _scrollController,
          itemCount: repositories.length + (repositoryNotifier.hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index >= repositories.length) {
              return const Center(child: CircularProgressIndicator());
            }

            RepositoryModel repo = repositories[index];
            return RepositoryListItem(repo: repo);
          },
        ),
      ),
    );
  }
}
