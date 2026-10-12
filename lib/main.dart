import 'package:flutter/material.dart';

import 'models/student.dart';
import 'screens/add_student_page.dart';
import 'screens/student_details_page.dart';

void main() {
  runApp(const StudentInformationSystem());
}

class StudentInformationSystem extends StatelessWidget {
  const StudentInformationSystem({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Information System',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();
  List<Student> students = [
    Student(
      id: 1,
      name: 'Juan Dela Cruz',
      course: 'BS Information Technology',
      yearLevel: 2,
      email: 'juan@example.com',
    ),
    Student(
      id: 2,
      name: 'Maria Santos',
      course: 'BS Information Technology',
      yearLevel: 1,
      email: 'maria@example.com',
    ),
  ];
  List<Student> filteredStudents = [];

  @override
  void initState() {
    super.initState();
    filteredStudents = students;
  }

  List<Student> _filterStudents(String query) {
    final normalizedQuery = query.trim().toLowerCase();

    if (normalizedQuery.isEmpty) {
      return students;
    }

    return students.where((student) {
      final name = student.name.toLowerCase();
      final course = student.course.toLowerCase();
      return name.contains(normalizedQuery) || course.contains(normalizedQuery);
    }).toList();
  }

  void searchStudents(String query) {
    setState(() {
      filteredStudents = _filterStudents(query);
    });
  }

  Future<void> _showDeleteDialog(Student student) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure you want to delete\n${student.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      setState(() {
        students.removeWhere((item) => item.id == student.id);
        filteredStudents = _filterStudents(searchController.text);
      });
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Information System'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                'Total Students: ${students.length}',
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              onChanged: searchStudents,
              decoration: const InputDecoration(
                labelText: 'Search Student',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          if (filteredStudents.isEmpty)
            const Expanded(
              child: Center(
                child: Text('No students found.'),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: filteredStudents.length,
                itemBuilder: (context, index) {
                  final student = filteredStudents[index];

                  return ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(student.name),
                    subtitle: Text(student.course),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () async {
                            final updatedStudent = await Navigator.push<Student>(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    StudentDetailsPage(student: student),
                              ),
                            );

                            if (updatedStudent != null && mounted) {
                              setState(() {
                                final indexOfStudent = students.indexWhere(
                                  (item) => item.id == updatedStudent.id,
                                );

                                if (indexOfStudent != -1) {
                                  students[indexOfStudent] = updatedStudent;
                                } else {
                                  students.add(updatedStudent);
                                }

                                filteredStudents = _filterStudents(
                                  searchController.text,
                                );
                              });
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _showDeleteDialog(student),
                        ),
                      ],
                    ),
                    onTap: () async {
                      final updatedStudent = await Navigator.push<Student>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StudentDetailsPage(student: student),
                        ),
                      );

                      if (updatedStudent != null && mounted) {
                        setState(() {
                          final indexOfStudent = students.indexWhere(
                            (item) => item.id == updatedStudent.id,
                          );

                          if (indexOfStudent != -1) {
                            students[indexOfStudent] = updatedStudent;
                          } else {
                            students.add(updatedStudent);
                          }

                          filteredStudents = _filterStudents(searchController.text);
                        });
                      }
                    },
                  );
                },
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final student = await Navigator.push<Student>(
            context,
            MaterialPageRoute(builder: (context) => const AddStudentPage()),
          );

          if (student != null && mounted) {
            setState(() {
              students.add(student);
              filteredStudents = _filterStudents(searchController.text);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
