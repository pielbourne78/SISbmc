class Student {
  int id;
  String name;
  String course;
  int yearLevel;
  String email;

  Student({
    required this.id,
    required this.name,
    required this.course,
    required this.yearLevel,
    required this.email,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] as int,
      name: json['name'] as String,
      course: json['course'] as String,
      yearLevel: json['yearLevel'] as int,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'course': course,
        'yearLevel': yearLevel,
        'email': email,
      };
}