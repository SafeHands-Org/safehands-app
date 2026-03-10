import 'dart:convert';
import 'package:http/http.dart' as http;

class RxSuggestion {
  final String rxcui;
  final String name;
  RxSuggestion(this.rxcui, this.name);
}

Future<List<RxSuggestion>> rxNormSearch(String query) async {
  if (query.trim().length < 2) return [];

  try {
    final uri = Uri.parse(
      'https://rxnav.nlm.nih.gov/REST/approximateTerm.json?term=${Uri.encodeComponent(query)}&maxEntries=8',
    );

    final res = await http.get(uri);
    if (res.statusCode != 200) return [];

    final body = jsonDecode(res.body) as Map<String, dynamic>;
    final candidates =
        (body['approximateGroup']?['candidate'] as List?) ?? [];

    final seen = <String>{};

    return candidates
        .whereType<Map<String, dynamic>>()
        .where((c) => seen.add(c['rxcui'] as String? ?? ''))
        .map((c) => RxSuggestion(
              c['rxcui'] ?? '',
              c['name'] ?? '',
            ))
        .where((s) => s.rxcui.isNotEmpty && s.name.isNotEmpty)
        .take(8)
        .toList();
  } catch (_) {
    return [];
  }
}