import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../service/local.dart';

final localRepositoryProvider = Provider<LocalRepository>((ref) {
  return LocalRepository();
});
