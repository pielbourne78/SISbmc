import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:student_information_system/main.dart';
import 'package:student_information_system/models/student.dart';
import 'package:student_information_system/services/student_storage.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('Student app loads with initial students and count', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const StudentInformationSystem());
    await tester.pumpAndSettle();

    expect(find.text('Student Information System'), findsOneWidget);
    expect(find.text('Juan Dela Cruz'), findsOneWidget);
    expect(find.text('Maria Santos'), findsOneWidget);
    expect(find.text('Total Students: 2'), findsOneWidget);
  });

  test('student changes are available after loading storage again', () async {
    final originalStudent = Student(
      id: 17,
      name: 'Alex Rivera',
      course: 'Computer Science',
      yearLevel: 2,
      email: 'alex@example.com',
    );
    final editedStudent = Student(
      id: originalStudent.id,
      name: 'Alex Rivera Updated',
      course: originalStudent.course,
      yearLevel: originalStudent.yearLevel,
      email: originalStudent.email,
    );

    await StudentStorage.saveStudents([editedStudent]);
    final studentsAfterReload = await StudentStorage.loadStudents(
      initialStudents: [],
    );

    expect(studentsAfterReload, hasLength(1));
    expect(studentsAfterReload.single.name, 'Alex Rivera Updated');
  });
}
