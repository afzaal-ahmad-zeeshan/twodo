import 'package:flutter/material.dart';
import 'package:twodo/pages/create_collection_page.dart';
import 'package:twodo/pages/create_group_page.dart';
import 'package:twodo/pages/create_todo_page.dart';

class CreateNewBottomsheetContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 235,
      child: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "Add a new record",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.group_add),
            title: const Text("Add group"),
            onTap: () async {
              debugPrint("Add a group");
              Navigator.pop(context);
              await Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => CreateGroupPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.collections_bookmark),
            title: const Text("Add collection"),
            onTap: () async {
              debugPrint("Add a collection");
              Navigator.pop(context);
              await Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => CreateCollectionPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_task),
            title: const Text("Add task"),
            onTap: () async {
              debugPrint("Add a task");
              Navigator.pop(context);
              await Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => CreateTaskPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
