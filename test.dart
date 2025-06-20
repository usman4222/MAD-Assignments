 // https://www.jdoodle.com/ga/8mXAYY%2F9MfESCP514ibymw%3D%3D

import 'dart:io';

void main() {
  int number = 10;
  String greeting = "Welcome to Dart!";
  bool isLearning = true;

  print("Initial Variables:");
  print("Number: $number");
  print("Greeting: $greeting");
  print("Is Learning: $isLearning\n");

  stdout.write("Enter your name: ");
  String? name = stdin.readLineSync();

  stdout.write("Enter your age: ");
  int? age = int.tryParse(stdin.readLineSync()!);

  print("\nHello, $name! You are $age years old.\n");

  List<String> cities = ["Lahore", "Karachi", "Islamabad", "Multan", "Peshawar"];
  print("Cities in original order: $cities");
  print("Cities in reversed order: ${cities.reversed.toList()}\n");

  Map<String, int> studentMarks = {
    "Ali": 85,
    "Sara": 90,
    "John": 78,
  };

  studentMarks["Ayesha"] = 88;

  print("Updated Student Marks: $studentMarks\n");

  if (age != null) {
    String category = (age < 13)
        ? "Child"
        : (age >= 13 && age <= 19)
            ? "Teen"
            : (age >= 20 && age <= 59)
                ? "Adult"
                : "Senior";
    print("Age Category: $category");
  } else {
    print("Invalid age entered.");
  }
}
