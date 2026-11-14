import 'package:flutter_test/flutter_test.dart';

import 'package:bookreview_032/main.dart';

void main() {
  testWidgets('Splash lalu masuk ke Beranda', (WidgetTester tester) async {
    await tester.pumpWidget(const LiteraApp());

    // Splash tampil
    expect(find.text('Litera'), findsOneWidget);

    // Tunggu splash (2 detik) dan loading data (1 detik)
    await tester.pump(const Duration(seconds: 2));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    // Beranda tampil dengan buku dummy
    expect(find.text('Beranda'), findsWidgets);
    expect(find.text('Laut Bercerita'), findsOneWidget);
  });
}