import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// https://github.com/usman4222/MAD-Assignments

class StudentFormScreen extends StatefulWidget {
  const StudentFormScreen({super.key});

  @override
  State<StudentFormScreen> createState() => _StudentFormScreenState();
}

class _StudentFormScreenState extends State<StudentFormScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();

  Map<String, dynamic>? latestStudent;

  Future<void> submitStudent() async {
    String name = _nameController.text.trim();
    String age = _ageController.text.trim();
    String course = _courseController.text.trim();

    if (name.isEmpty || age.isEmpty || course.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required")),
      );
      return;
    }

    DocumentReference docRef = await FirebaseFirestore.instance
        .collection('students')
        .add({
      "name": name,
      "age": int.parse(age),
      "course": course,
      "createdAt": Timestamp.now(),
    });

    DocumentSnapshot snapshot = await docRef.get();
    setState(() {
      latestStudent = snapshot.data() as Map<String, dynamic>;
    });

    _nameController.clear();
    _ageController.clear();
    _courseController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Student Form")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Full Name"),
            ),
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(labelText: "Age"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _courseController,
              decoration: const InputDecoration(labelText: "Course"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: submitStudent,
              child: const Text("Submit"),
            ),
            const SizedBox(height: 30),

            if (latestStudent != null) ...[
              const Text("Latest Student:",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              ListTile(
                title: Text(latestStudent!['name']),
                subtitle: Text(
                    "Age: ${latestStudent!['age']}, Course: ${latestStudent!['course']}"),
              ),
              const Divider(),
            ],

            const Text("All Students:",
                style: TextStyle(fontWeight: FontWeight.bold)),

            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('students')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();
                final students = snapshot.data!.docs;

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    final data = students[index].data() as Map<String, dynamic>;
                    return ListTile(
                      title: Text(data['name']),
                      subtitle:
                      Text("Age: ${data['age']}, Course: ${data['course']}"),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
