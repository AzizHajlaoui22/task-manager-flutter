import 'dart:convert';
import 'package:http/http.dart' as http;

class QuoteService {
  Future<List<String>> fetchQuotes() async {
    final response = await http.get(
      Uri.parse('https://type.fit/api/quotes'),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data
          .take(15)
          .map((e) => e['text'].toString())
          .toList();
    } else {
      throw Exception('Erreur lors du chargement des citations');
    }
  }
}
