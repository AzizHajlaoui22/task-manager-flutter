import 'package:flutter/material.dart';
import '../../services/quote_service.dart';

class QuotesScreen extends StatelessWidget {
  const QuotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Citations')),
      body: FutureBuilder<List<String>>(
        future: QuoteService().fetchQuotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Erreur lors du chargement des données'),
            );
          }

          final quotes = snapshot.data!;

          return ListView.builder(
            itemCount: quotes.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.format_quote),
                title: Text(quotes[index]),
              );
            },
          );
        },
      ),
    );
  }
}
