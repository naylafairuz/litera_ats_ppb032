import '../models/book.dart';
import '../models/review.dart';

/// Penyimpanan data sederhana (di memori).
class DataService {
  DataService._();
  static final DataService instance = DataService._();

  /// Ubah ke true untuk mencoba tampilan error + tombol "Coba lagi".
  static bool simulateError = false;

    final List<Book> _books = const [
    Book(
      title: 'Laut Bercerita',
      author: 'Leila S. Chudori',
      genre: 'Fiksi',
      rating: 4,
      synopsis:
          'Novel tentang penghilangan paksa aktivis mahasiswa pada era '
          'reformasi 1998, dikisahkan dari sudut pandang korban dan keluarga '
          'yang ditinggalkan.',
    ),
    Book(
      title: 'Hujan',
      author: 'Tere Liye',
      genre: 'Fiksi',
      rating: 4,
      synopsis:
          'Kisah Lail dan Esok di masa depan setelah bencana besar, tentang '
          'kehilangan, persahabatan, dan perasaan yang sulit dilupakan.',
    ),
    Book(
      title: 'Teka-Teki Rumah Aneh',
      author: 'Uketsu',
      genre: 'Fiksi',
      rating: 4,
      synopsis:
          'Denah sebuah rumah dengan ruang-ruang janggal menyimpan misteri. '
          'Pembaca diajak memecahkan teka-teki lewat gambar dan petunjuk.',
    ),
    Book(
      title: 'Pengabdian Tersangka X',
      author: 'Keigo Higashino',
      genre: 'Fiksi',
      rating: 5,
      synopsis:
          'Seorang guru matematika jenius membantu tetangganya menutupi '
          'sebuah pembunuhan, dan beradu kecerdasan dengan fisikawan Yukawa.',
    ),
    Book(
      title: 'Atomic Habits',
      author: 'James Clear',
      genre: 'Non-Fiksi',
      rating: 5,
      synopsis:
          'Panduan membangun kebiasaan baik dan meninggalkan kebiasaan buruk '
          'lewat perubahan kecil yang dilakukan secara konsisten.',
    ),
    Book(
      title: 'Kalkulus',
      author: 'Edwin J. Purcell',
      genre: 'Pelajaran',
      rating: 3,
      synopsis:
          'Buku teks yang membahas limit, turunan, dan integral dengan '
          'penjelasan bertahap dan contoh soal untuk mahasiswa.',
    ),
  ];

  final List<Review> reviews = [
    const Review(
      id: '1',
      title: 'Laut Bercerita',
      author: 'Leila S. Chudori',
      genre: 'Fiksi',
      rating: 4,
      text: 'Bagus. Membaca buku ini terasa seperti ditarik perlahan ke '
          'palung terdalam empat kemanusiaan.',
    )
  ];

  Future<List<Book>> loadBooks() async {
    await Future.delayed(const Duration(seconds: 1));
    if (simulateError) throw Exception('Gagal memuat data');
    return _books;
  }

  void addReview(Review r) => reviews.insert(0, r);

  void updateReview(Review r) {
    final i = reviews.indexWhere((e) => e.id == r.id);
    if (i != -1) reviews[i] = r;
  }

  void deleteReview(String id) => reviews.removeWhere((e) => e.id == id);
}