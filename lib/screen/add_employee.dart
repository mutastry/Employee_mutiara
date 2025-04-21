import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class EmployeeForm extends StatefulWidget {
  @override
  _EmployeeFormState createState() => _EmployeeFormState();
}

class _EmployeeFormState extends State<EmployeeForm> {
  final nameController = TextEditingController();
  final positionController = TextEditingController();

  final DatabaseReference _dbRef =
  FirebaseDatabase.instance.ref().child('employees');

  void _saveEmployee() {
    final name = nameController.text.trim();
    final position = positionController.text.trim();

    if (name.isNotEmpty && position.isNotEmpty) {
      _dbRef.push().set({
        'name': name,
        'position': position,
      });

      nameController.clear();
      positionController.clear();

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Data saved successfully")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Employee")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: positionController,
              decoration: InputDecoration(labelText: 'Position'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveEmployee,
              child: Text("Save Employee"),
            ),
          ],
        ),
      ),
    );
  }
}
