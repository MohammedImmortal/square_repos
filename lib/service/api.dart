import 'package:dio/dio.dart';
import '../models/repository.dart';

class ApiRepository {
  final Dio dio = Dio();
  final String baseUrl = 'https://api.github.com/users/square/repos';

  Future<List<RepositoryModel>> fetchRepositories(int page) async {
    try {
      Response response = await dio.get('$baseUrl?page=$page&per_page=10');

      Map<String, dynamic> jsonData = response.data;

      List<dynamic> repositories = jsonData['repositories'];

      List<RepositoryModel> repositoriesList = [];

      for (var repository in repositories) {
        RepositoryModel repositoryModel = RepositoryModel.fromJson(repository);
        repositoriesList.add(repositoryModel);
      }

      return repositoriesList;
    } catch (error) {
      return [];
    }
  }
}
