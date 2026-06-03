import 'package:flutter_test/flutter_test.dart';

import 'package:essence/app.dart';

void main() {
  testWidgets('shows welcome screen', (WidgetTester tester) async {
    await tester.pumpWidget(const EssenceApp());

    expect(find.text('Como você quer\nse sentir hoje?'), findsOneWidget);
  });
}
