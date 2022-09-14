import 'package:flutter/material.dart';

class CreateCollectionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreateCollectionPageState();
}

class _CreateCollectionPageState extends State<CreateCollectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create a group"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Create a new collection.',
            ),
          ],
        ),
      ),
    );
  }
}
