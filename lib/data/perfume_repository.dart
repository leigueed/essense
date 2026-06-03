import 'package:essence/data/models/perfume.dart';
import 'package:essence/data/perfumes_data.dart';

class PerfumeRepository {
  final List<Perfume> _perfumes = perfumesData;

  List<Perfume> recommend(List<String> selectedTags) {
    final scored = _perfumes.map((perfume) {
      double score = 0;
      for (final tag in selectedTags) {
        score += perfume.tags[tag] ?? 0;
      }
      return MapEntry(perfume, score);
    }).toList();

    scored.sort((a, b) => b.value.compareTo(a.value));

    scored.removeWhere((entry) => entry.value == 0);

    List<Perfume> resultado;
    if (scored.length < 3) {
      resultado = List<Perfume>.from(_perfumes);
      resultado.shuffle();
      return resultado.take(6).toList();
    }
    resultado = scored.map((e) => e.key).toList();
    return resultado.length > 6 ? resultado.sublist(0, 6) : resultado;
  }

  Perfume? getById(String id) {
    try {
      return _perfumes.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }
}
