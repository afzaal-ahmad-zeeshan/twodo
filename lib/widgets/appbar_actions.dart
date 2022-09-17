import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twodo/pages/login_page.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AppbarActions extends StatelessWidget {
  // put website link here.
  String url = "";
  bool loggedIn = false;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) {
        return [
          PopupMenuItem<int>(
            value: 0,
            child: Text(auth.currentUser?.email ?? "Log in"),
            onTap: () async {
              // use Google Sign In.
            },
          ),
          PopupMenuItem<int>(
            value: 1,
            child: const Text("Learn more"),
            onTap: () async {
              if (url.isNotEmpty && await canLaunchUrlString(url)) {
                launchUrlString(url);
              } else {
                // remove the button, or hide it.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Whoops, maybe there is nothing more to learn. 😉",
                    ),
                  ),
                );
              }
            },
          ),
        ];
      },
      onSelected: (value) async {
        if (value == 0) {
          debugPrint("My account menu is selected.");
          await Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => LoginPage(),
            ),
          );
        } else if (value == 1) {
          debugPrint("Settings menu is selected.");
        }
      },
    );
  }
}
