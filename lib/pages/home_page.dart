import 'package:flutter/material.dart';
import '../data/data_service.dart';
import '../models/book.dart';
import '../widgets/common.dart';
import 'book_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const _genres = ['Semua', 'Fiksi', 'Non-Fiksi', 'Pelajaran'];

  List<Book> _books = [];
  bool _loading = true;
  String? _error;
  String _query = '';
  String _genre = 'Semua';
  int _minRating = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final data = await DataService.instance.loadBooks();
      if (!mounted) return;
      setState(() {
        _books = data;
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _error = 'Data gagal dimuat.';
        _loading = false;
      });
    }
  }

  List<Book> get _filtered => _books.where((b) {
        final matchTitle = b.title.toLowerCase().contains(_query.toLowerCase());
        final matchGenre = _genre == 'Semua' || b.genre == _genre;
        final matchRating = b.rating >= _minRating;
        return matchTitle && matchGenre && matchRating;
      }).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Beranda')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Cari judul buku',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
            ),
            onChanged: (v) => setState(() => _query = v),
          ),
          const SizedBox(height: 8),
          Row(children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _genres
                      .map((g) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ChoiceChip(
                              label: Text(g),
                              selected: _genre == g,
                              selectedColor: kMaroon,
                              labelStyle: TextStyle(
                                  color: _genre == g ? Colors.white : null),
                              showCheckmark: false,
                              onSelected: (_) => setState(() => _genre = g),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
            DropdownButton<int>(
              value: _minRating,
              underline: const SizedBox(),
              items: const [
                DropdownMenuItem(value: 0, child: Text('Semua rating')),
                DropdownMenuItem(value: 4, child: Text('★ 4+')),
                DropdownMenuItem(value: 5, child: Text('★ 5')),
              ],
              onChanged: (v) => setState(() => _minRating = v ?? 0),
            ),
          ]),
          const SizedBox(height: 8),
          Expanded(child: _buildBody()),
        ]),
      ),
    );
  }

  Widget _buildBody() {
    if (_loading) return const Center(child: CircularProgressIndicator());

    if (_error != null) {
      return Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.error_outline, size: 48, color: kMaroon),
          const SizedBox(height: 8),
          Text(_error!),
          const SizedBox(height: 8),
          ElevatedButton(onPressed: _load, child: const Text('Coba lagi')),
        ]),
      );
    }

    final list = _filtered;
    if (list.isEmpty) return const Center(child: Text('Buku tidak ditemukan'));

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (_, i) {
        final b = list[i];
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GenreTag(b.genre),
                  const SizedBox(height: 4),
                  Text(b.title,
                      style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: kMaroon)),
                  Text(b.author, style: const TextStyle(fontSize: 12)),
                  const SizedBox(height: 4),
                  Text(b.synopsis,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12)),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RatingRow(b.rating),
                        TextButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BookDetailPage(book: b))),
                          child: const Text('Detail >'),
                        ),
                      ]),
                ]),
          ),
        );
      },
    );
  }
}