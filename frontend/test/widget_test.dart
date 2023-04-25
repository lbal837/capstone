import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/main.dart';
import 'package:frontend/ui/home/home.dart';

void main() {
  testWidgets('MyApp should display MyHomePage with the correct title',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    final MyHomePage myHomePage = tester.firstWidget(find.byType(MyHomePage));
    expect(myHomePage.title, 'LifeSavers');
  });
}
