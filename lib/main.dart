import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee App',
      home: EmployeeForm(),
    );
  }
}

class EmployeeForm extends StatefulWidget {
  @override
  _EmployeeFormState createState() => _EmployeeFormState();
}

class _EmployeeFormState extends State<EmployeeForm> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref("employee");

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();

  void _addEmployee() {
    String name = _nameController.text;
    String position = _positionController.text;

    if (name.isNotEmpty && position.isNotEmpty) {
      _dbRef.push().set({
        "name": name,
        "position": position,
      }).then((_) {
        _nameController.clear();
        _positionController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Employee')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Name')),
            TextField(controller: _positionController, decoration: InputDecoration(labelText: 'Position')),
            SizedBox(height: 16),
            ElevatedButton(onPressed: _addEmployee, child: Text('Save Employee')),
          ],
        ),
      ),
    );
  }
}
