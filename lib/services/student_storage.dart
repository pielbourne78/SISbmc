import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/student.dart';

class StudentStorage {
  static const _storageKey = 'students';

  static Future<List<Student>> loadStudents({
    required List<Student> initialStudents,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    final storedStudents = preferences.getString(_storageKey);

    if (storedStudents == null) {
      await saveStudents(initialStudents);
      return initialStudents;
    }

    final decodedStudents = jsonDecode(storedStudents) as List<dynamic>;
    return decodedStudents
        .map((student) => Student.fromJson(student as Map<String, dynamic>))
        .toList();
  }

  static Future<void> saveStudents(List<Student> students) async {
    final preferences = await SharedPreferences.getInstance();
    final encodedStudents = jsonEncode(
      students.map((student) => student.toJson()).toList(),
    );
    await preferences.setString(_storageKey, encodedStudents);
  }
}