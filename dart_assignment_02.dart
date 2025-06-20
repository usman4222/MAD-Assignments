// Student Management System using OOP in Dart
// JDoodle Link: https://www.jdoodle.com/ga/cdnRQWR3Meprrefztt8Eyw%3D%3D
// GitHub Repo: https://github.com/usman4222/MAD-Assignments

class Person {
  String _name;
  int age;

  Person(this._name, this.age);

  String get name => _name;

  set name(String value) {
    if (value.isEmpty) {
      print("Name cannot be empty.");
    } else {
      _name = value;
    }
  }

  void display() {
    print("Name: $_name, Age: $age");
  }
}

class Student extends Person {
  int rollNumber;
  String course;

  Student(String name, int age, this.rollNumber, this.course)
      : super(name, age);

  Student.namedConstructor(
      {required String name,
      required int age,
      required this.rollNumber,
      required this.course})
      : super(name, age);

  @override
  void display() {
    print(
        "Name: $name, Age: $age, Roll No: $rollNumber, Course: $course");
  }
}

void displayStudentsByCourse(List<Student> students, String courseName) {
  print("\nStudents enrolled in $courseName:");
  for (var student in students) {
    if (student.course.toLowerCase() == courseName.toLowerCase()) {
      student.display();
    }
  }
}

void main() {
  Student s1 = Student("Ali", 20, 101, "Computer Science");
  Student s2 = Student.namedConstructor(
      name: "Sara", age: 21, rollNumber: 102, course: "Mathematics");
  Student s3 = Student("John", 22, 103, "Computer Science");
  Student s4 = Student.namedConstructor(
      name: "Ayesha", age: 23, rollNumber: 104, course: "Physics");

  s1.name = ""; 
  s1.name = "Ali Raza"; 

  List<Student> studentList = [s1, s2, s3, s4];

  print("All Students:\n");
  for (var student in studentList) {
    student.display();
  }

  displayStudentsByCourse(studentList, "Computer Science");
}
