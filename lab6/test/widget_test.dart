import 'package:exam/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('opens selected product detail page', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Product Name: Iphone 14'), findsOneWidget);

    await tester.tap(find.text('Product Name: Iphone 14'));
    await tester.pumpAndSettle();

    expect(find.text('Product Detail'), findsOneWidget);
    expect(find.text('Iphone 14'), findsOneWidget);
    expect(find.text('Product ID: P01'), findsOneWidget);
  });
}
