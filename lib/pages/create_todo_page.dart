import 'package:flutter/material.dart';

class CreateTaskPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create a task"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Create a new task.',
            ),
          ],
        ),
      ),
    );
  }
}
