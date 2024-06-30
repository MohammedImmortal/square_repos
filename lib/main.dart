import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:square_repos/screens/repository_list_screen.dart';
import 'package:workmanager/workmanager.dart';
import 'provider/api_repository_provider.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final container = ProviderContainer();
    final repositoryNotifier = container.read(repositoryProvider.notifier);
    await repositoryNotifier.refreshRepositories();
    container.dispose();
    return Future.value(true);
  });
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  Workmanager().registerPeriodicTask(
    "1",
    "fetchFreshData",
    frequency: const Duration(hours: 1),
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Square Repos',
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        useMaterial3: true,
      ),
      home: const RepositoryListScreen(),
    );
  }
}
