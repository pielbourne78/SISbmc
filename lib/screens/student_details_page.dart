import 'package:flutter/material.dart';

import '../models/student.dart';
import 'edit_student_page.dart';

class StudentDetailsPage extends StatelessWidget {
  final Student student;

  const StudentDetailsPage({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Details')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              student.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text('Student ID: ${student.id}'),
            Text('Course: ${student.course}'),
            Text('Year Level: ${student.yearLevel}'),
            Text('Email: ${student.email}'),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  final updatedStudent = await Navigator.push<Student>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditStudentPage(student: student),
                    ),
                  );

                  if (updatedStudent != null && context.mounted) {
                    Navigator.pop(context, updatedStudent);
                  }
                },
                icon: const Icon(Icons.edit),
                label: const Text('Edit Student'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

