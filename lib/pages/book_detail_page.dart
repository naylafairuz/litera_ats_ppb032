import 'package:flutter/material.dart';
import '../models/book.dart';
import '../widgets/common.dart';

class BookDetailPage extends StatelessWidget {
  final Book book;
  const BookDetailPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Buku')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        HeaderCard(title: book.title, author: book.author),
        const SizedBox(height: 16),
        Row(children: [
          GenreTag(book.genre),
          const SizedBox(width: 12),
          RatingRow(book.rating),
        ]),
        const SizedBox(height: 16),
        const Text('Synopsis',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: kMaroon)),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(book.synopsis,
                style: const TextStyle(fontSize: 15, height: 1.5)),
          ),
        ),
      ]),
    );
  }
}