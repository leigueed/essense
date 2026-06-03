import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:essence/data/perfume_repository.dart';

final perfumeRepositoryProvider = Provider<PerfumeRepository>((ref) {
  return PerfumeRepository();
});
