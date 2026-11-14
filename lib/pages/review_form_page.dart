import 'package:flutter/material.dart';
import '../data/data_service.dart';
import '../models/review.dart';
import '../widgets/common.dart';

/// Halaman Tambah Review (review == null) atau Edit Review (review != null).
/// Saat ditutup mengembalikan 'saved' atau 'deleted'.
class ReviewFormPage extends StatefulWidget {
  final Review? review;
  const ReviewFormPage({super.key, this.review});

  @override
  State<ReviewFormPage> createState() => _ReviewFormPageState();
}

class _ReviewFormPageState extends State<ReviewFormPage> {
  static const _genres = ['Fiksi', 'Non-Fiksi', 'Pelajaran'];

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _title;
  late final TextEditingController _author;
  late final TextEditingController _text;
  late String _genre;
  late int _rating;
  bool _ratingError = false;

  bool get _isEdit => widget.review != null;

  @override
  void initState() {
    super.initState();
    final r = widget.review;
    _title = TextEditingController(text: r?.title ?? '');
    _author = TextEditingController(text: r?.author ?? '');
    _text = TextEditingController(text: r?.text ?? '');
    _genre = r?.genre ?? 'Fiksi';
    _rating = r?.rating ?? 0;
  }

  @override
  void dispose() {
    _title.dispose();
    _author.dispose();
    _text.dispose();
    super.dispose();
  }

  void _save() {
    final valid = _formKey.currentState!.validate();
    setState(() => _ratingError = _rating == 0);
    if (!valid || _rating == 0) return;

    final review = Review(
      id: widget.review?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: _title.text.trim(),
      author: _author.text.trim(),
      genre: _genre,
      rating: _rating,
      text: _text.text.trim(),
    );

    if (_isEdit) {
      DataService.instance.updateReview(review);
    } else {
      DataService.instance.addReview(review);
    }

    final messenger = ScaffoldMessenger.of(context);
    Navigator.pop(context, 'saved');
    messenger.showSnackBar(SnackBar(
        content: Text(_isEdit ? 'Review diperbarui' : 'Review ditambahkan')));
  }

  Future<void> _delete() async {
    if (!await confirmDelete(context)) return;
    DataService.instance.deleteReview(widget.review!.id);
    if (!mounted) return;
    Navigator.pop(context, 'deleted');
  }

  InputDecoration _dec(String hint) => InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      );

  Widget _label(String t) => Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 6),
        child: Text(t,
            style: const TextStyle(
                fontWeight: FontWeight.w600, color: kMaroon, fontSize: 15)),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isEdit ? 'Edit Review' : 'Tambah Review')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _label('Judul Buku *'),
            TextFormField(
              controller: _title,
              decoration: _dec('Masukkan judul buku'),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Judul tidak boleh kosong'
                  : null,
            ),
            _label('Penulis *'),
            TextFormField(
              controller: _author,
              decoration: _dec('Masukkan nama penulis'),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Penulis tidak boleh kosong'
                  : null,
            ),
            _label('Pilihan Genre & Kategori'),
            DropdownButtonFormField<String>(
              value: _genre,
              decoration: _dec(''),
              items: _genres
                  .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                  .toList(),
              onChanged: (v) => setState(() => _genre = v ?? _genre),
            ),
            _label('Beri Rating *'),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: kSand, borderRadius: BorderRadius.circular(12)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (i) {
                  return IconButton(
                    iconSize: 36,
                    color: kGold,
                    icon: Icon(i < _rating ? Icons.star : Icons.star_border),
                    onPressed: () => setState(() {
                      _rating = i + 1;
                      _ratingError = false;
                    }),
                  );
                }),
              ),
            ),
            if (_ratingError)
              const Padding(
                padding: EdgeInsets.only(top: 6, left: 12),
                child: Text('Rating wajib dipilih',
                    style: TextStyle(color: Colors.red, fontSize: 12)),
              ),
            _label('Ulasan Lengkap *'),
            TextFormField(
              controller: _text,
              maxLines: 6,
              decoration: _dec('Tulis ulasan kamu di sini'),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Ulasan tidak boleh kosong'
                  : null,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: kMaroon,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14)),
                onPressed: _save,
                icon: const Icon(Icons.save),
                label: const Text('Simpan Review'),
              ),
            ),
            if (_isEdit) ...[
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                      foregroundColor: kMaroon,
                      padding: const EdgeInsets.symmetric(vertical: 14)),
                  onPressed: _delete,
                  icon: const Icon(Icons.delete_outline),
                  label: const Text('Hapus Review'),
                ),
              ),
            ],
          ]),
        ),
      ),
    );
  }
}