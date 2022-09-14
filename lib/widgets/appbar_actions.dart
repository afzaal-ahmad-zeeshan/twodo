import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AppbarActions extends StatelessWidget {
  // put website link here.
  String url = "";

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) {
        return [
          PopupMenuItem<int>(
            value: 0,
            child: const Text("Login"),
            onTap: () {
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
      onSelected: (value) {
        if (value == 0) {
          debugPrint("My account menu is selected.");
        } else if (value == 1) {
          debugPrint("Settings menu is selected.");
        }
      },
    );
  }
}
