import 'package:flutter/material.dart';
import '../data/data_service.dart';
import '../widgets/common.dart';
import 'review_detail_page.dart';
import 'review_form_page.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  Widget build(BuildContext context) {
    final reviews = DataService.instance.reviews;

    return Scaffold(
      appBar: AppBar(title: const Text('Review')),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: kMaroon,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.edit_note),
        label: const Text('Tambah Review'),
        onPressed: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (_) => const ReviewFormPage()));
          setState(() {});
        },
      ),
      body: reviews.isEmpty
          ? const Center(child: Text('Belum ada review'))
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
              itemCount: reviews.length,
              itemBuilder: (_, i) {
                final r = reviews[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GenreTag(r.genre),
                          const SizedBox(height: 4),
                          Text(r.title,
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: kMaroon)),
                          Text(r.author, style: const TextStyle(fontSize: 12)),
                          const SizedBox(height: 4),
                          Text(r.text,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 12)),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RatingRow(r.rating),
                                TextButton(
                                  onPressed: () async {
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                ReviewDetailPage(id: r.id)));
                                    setState(() {});
                                  },
                                  child: const Text('Detail >'),
                                ),
                              ]),
                        ]),
                  ),
                );
              },
            ),
    );
  }
}