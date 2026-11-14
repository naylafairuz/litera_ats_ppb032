import 'package:flutter/material.dart';

const kBg = Color(0xFFFDF3E1);
const kMaroon = Color(0xFF8B0A24);
const kSand = Color(0xFFF5E6C8);
const kGold = Color(0xFFB5A642);

class GenreTag extends StatelessWidget {
  final String genre;
  const GenreTag(this.genre, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
          color: kSand, borderRadius: BorderRadius.circular(12)),
      child: Text(genre.toUpperCase(),
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }
}

class RatingRow extends StatelessWidget {
  final int rating;
  const RatingRow(this.rating, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      const Icon(Icons.star, size: 16, color: kGold),
      const SizedBox(width: 4),
      Text('$rating', style: const TextStyle(fontWeight: FontWeight.bold)),
    ]);
  }
}

class HeaderCard extends StatelessWidget {
  final String title;
  final String author;
  const HeaderCard({super.key, required this.title, required this.author});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: kSand, borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: kMaroon)),
        Text(author),
      ]),
    );
  }
}

/// Dialog konfirmasi hapus. Mengembalikan true jika user memilih "Hapus".
Future<bool> confirmDelete(BuildContext context) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Hapus Review?'),
      content: const Text('Review yang dihapus tidak dapat dikembalikan.'),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal')),
        TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Hapus', style: TextStyle(color: kMaroon))),
      ],
    ),
  );
  return result == true;
}