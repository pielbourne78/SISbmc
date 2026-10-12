import 'package:flutter_test/flutter_test.dart';

import 'package:student_information_system/main.dart';

void main() {
  testWidgets('Student app loads with initial students and count', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const StudentInformationSystem());

    expect(find.text('Student Information System'), findsOneWidget);
    expect(find.text('Juan Dela Cruz'), findsOneWidget);
    expect(find.text('Maria Santos'), findsOneWidget);
    expect(find.text('Total Students: 2'), findsOneWidget);
  });
}
