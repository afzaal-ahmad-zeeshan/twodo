import 'package:flutter/material.dart';

class UpNextView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UpNextViewState();
}

class _UpNextViewState extends State<UpNextView> {
  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Text("Up next!"),
    );
  }
}
