import 'package:flutter/material.dart';
import '../data/data_service.dart';
import '../models/review.dart';
import '../widgets/common.dart';
import 'review_form_page.dart';

class ReviewDetailPage extends StatefulWidget {
  final String id;
  const ReviewDetailPage({super.key, required this.id});

  @override
  State<ReviewDetailPage> createState() => _ReviewDetailPageState();
}

class _ReviewDetailPageState extends State<ReviewDetailPage> {
  late Review _review;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    _review =
        DataService.instance.reviews.firstWhere((r) => r.id == widget.id);
  }

  Future<void> _edit() async {
    final result = await Navigator.push(context,
        MaterialPageRoute(builder: (_) => ReviewFormPage(review: _review)));
    if (!mounted) return;
    if (result == 'deleted') {
      Navigator.pop(context);
    } else {
      setState(_load);
    }
  }

  Future<void> _delete() async {
    if (!await confirmDelete(context)) return;
    DataService.instance.deleteReview(_review.id);
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Review Buku')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        HeaderCard(title: _review.title, author: _review.author),
        const SizedBox(height: 16),
        Row(children: [
          GenreTag(_review.genre),
          const SizedBox(width: 12),
          RatingRow(_review.rating),
        ]),
        const SizedBox(height: 16),
        const Text('Ulasan Anda',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: kMaroon)),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              Text(_review.text,
                  style: const TextStyle(fontSize: 15, height: 1.5)),
              const SizedBox(height: 16),
              Row(children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kMaroon,
                        foregroundColor: Colors.white),
                    onPressed: _edit,
                    child: const Text('Edit Ulasan'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    style:
                        OutlinedButton.styleFrom(foregroundColor: kMaroon),
                    onPressed: _delete,
                    child: const Text('Hapus'),
                  ),
                ),
              ]),
            ]),
          ),
        ),
      ]),
    );
  }
}