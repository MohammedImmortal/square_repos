import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/repository.dart';
import '../service/api.dart';
import '../service/local.dart';

class RepositoryNotifier extends StateNotifier<List<RepositoryModel>> {
  final ApiRepository apiRepository;
  final LocalRepository localRepository;
  int _page = 1;
  bool _hasMore = true;
  bool _isLoading = false;

  RepositoryNotifier(
    this.apiRepository,
    this.localRepository,
  ) : super([]);

  bool get hasMore => _hasMore;
  bool get isLoading => _isLoading;

  Future<void> fetchRepositories() async {
    if (_isLoading) return;

    _isLoading = true;
    state = state;

    try {
      List<RepositoryModel> newRepos =
          await apiRepository.fetchRepositories(_page);
      if (newRepos.length < 10) {
        _hasMore = false;
      }
      state = [...state, ...newRepos];
      await localRepository.insertRepos(newRepos);
      _page++;
    } catch (e) {
      state = await localRepository.fetchRepos();
    }

    _isLoading = false;
    state = state;
  }

  Future<void> refreshRepositories() async {
    _page = 1;
    _hasMore = true;
    state = [];
    await localRepository.clearRepos();
    await fetchRepositories();
  }
}

final repositoryProvider =
    StateNotifierProvider<RepositoryNotifier, List<RepositoryModel>>((ref) {
  final apiRepository = ApiRepository();
  final localRepository = LocalRepository();
  return RepositoryNotifier(apiRepository, localRepository);
});
