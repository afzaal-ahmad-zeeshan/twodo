import 'package:flutter/material.dart';

class GroupsView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GroupsViewState();
}

class _GroupsViewState extends State<GroupsView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: const <Widget>[
        ListTile(title: Text("Group 1")),
        ListTile(title: Text("Group 2")),
        ListTile(title: Text("Group 3")),
        ListTile(title: Text("Group 4")),
      ],
    );
  }
}
