import 'dart:math';

import 'package:flutter/material.dart';
import 'package:twodo/data/database.dart';
import 'package:twodo/widgets/group_card.dart';
import 'package:uuid/uuid.dart';

import '../main.dart';
import '../models/group.dart';

class GroupsView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GroupsViewState();
}

class _GroupsViewState extends State<GroupsView> {
  AppDatabase? database;
  List<Group>? groups;

  _GroupsViewState() {
    getDatabase();
  }

  Future getDatabase() async {
    final AppDatabase _database =
        await $FloorAppDatabase.databaseBuilder(MyApp.dbName).build();
    var _groups = await _database.groupDao.getAllGroups();

    if (_groups == null || _groups.isEmpty) {
      debugPrint("Adding groups to the database...");
      // dummy data
      _groups = <Group>[];
      for (int i = 0; i < 5; i++) {
        var g = Group(
          const Uuid().v4().toString(),
          "Group $i",
          DateTime.now().toString(),
          false,
          i,
          "1",
          Random().nextInt(50).toString(),
        );
        await _database.groupDao.addGroup(g);
      }
    }
    _groups = await _database.groupDao.getAllGroups();
    if (mounted) {
      setState(() {
        database = _database;
        groups = _groups;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (database == null || groups == null) {
      return const Card(
        child: Text("Loading..."),
      );
    }
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: <Widget>[
        for (var group in groups!) GroupCard(group),
      ],
    );
  }
}
