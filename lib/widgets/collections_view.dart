import 'package:flutter/material.dart';

class CollectionsView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CollectionsViewState();
}

class _CollectionsViewState extends State<CollectionsView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: const <Widget>[
        ListTile(title: Text("Collection 1")),
        ListTile(title: Text("Collection 2")),
        ListTile(title: Text("Collection 3")),
        ListTile(title: Text("Collection 4")),
      ],
    );
  }
}
