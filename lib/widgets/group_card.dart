import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twodo/models/group.dart';

import '../data/database.dart';

class GroupCard extends StatefulWidget {
  final Group group;

  GroupCard(this.group);

  @override
  State<StatefulWidget> createState() => _GroupCardState();
}

class _GroupCardState extends State<GroupCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.group.title,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      widget.group.favorite = !widget.group.favorite;
                    });
                  },
                  icon: Icon(
                    Icons.star,
                    color: (widget.group.favorite == true
                        ? Colors.orange
                        : Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
