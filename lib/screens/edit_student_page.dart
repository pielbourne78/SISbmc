import 'package:flutter/material.dart';

import '../models/student.dart';

class EditStudentPage extends StatefulWidget {
  final Student student;

  const EditStudentPage({
    super.key,
    required this.student,
  });

  @override
  State<EditStudentPage> createState() => _EditStudentPageState();
}

class _EditStudentPageState extends State<EditStudentPage> {
  late final TextEditingController nameController;
  late final TextEditingController courseController;
  late final TextEditingController yearController;
  late final TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.student.name);
    courseController = TextEditingController(text: widget.student.course);
    yearController = TextEditingController(text: widget.student.yearLevel.toString());
    emailController = TextEditingController(text: widget.student.email);
  }

  bool _saveStudent() {
    final name = nameController.text.trim();
    final course = courseController.text.trim();
    final email = emailController.text.trim();
    final yearLevel = int.tryParse(yearController.text.trim());

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Name is required.')),
      );
      return false;
    }

    if (course.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Course is required.')),
      );
      return false;
    }

    if (yearLevel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid year level.')),
      );
      return false;
    }

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email is required.')),
      );
      return false;
    }

    final updatedStudent = Student(
      id: widget.student.id,
      name: name,
      course: course,
      yearLevel: yearLevel,
      email: email,
    );

    Navigator.pop(context, updatedStudent);
    return true;
  }

  @override
  void dispose() {
    nameController.dispose();
    courseController.dispose();
    yearController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Student')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Student Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: courseController,
              decoration: const InputDecoration(
                labelText: 'Course',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: yearController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Year Level',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveStudent,
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
