import 'package:flutter/material.dart';
import 'package:twodo/pages/create_collection_page.dart';
import 'package:twodo/pages/create_group_page.dart';
import 'package:twodo/pages/create_todo_page.dart';

class GroupBottomsheet extends StatelessWidget {
  void prepareDb() async {}

  @override
  Widget build(BuildContext context) {
    prepareDb();

    return Container(
      height: 120,
      child: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "Group options",
            ),
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text("Delete"),
            onTap: () async {
              debugPrint("Delete the group");
              Navigator.pop(context);

              // delete the group in database
            },
          ),
        ],
      ),
    );
  }
}
