import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loading = true;
  bool loggedIn = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> authChanges() async {
    auth.authStateChanges().listen((User? user) {
      if (mounted) {
        setState(() {
          loggedIn = user != null;
        });
      }
    });
  }

  Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return null;
      }
      debugPrint(googleUser.toString());

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      debugPrint(credential.toString());
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (exception) {
      debugPrint(exception.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Could not log you in at the moment.",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    authChanges();
    if (loggedIn == false || auth.currentUser == null) {
      // User is not logged in.
      return Scaffold(
        appBar: AppBar(
          title: const Text("Your account"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SignInButton(
                Buttons.Google,
                onPressed: () {
                  signInWithGoogle();
                },
                // child: const Text("Google Signin"),
              ),
            ],
          ),
        ),
      );
    } else {
      // User is logged in.
      return Scaffold(
        appBar: AppBar(
          title: const Text("Your account"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You are logged in as ${auth.currentUser?.email}.',
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            auth.signOut();
          },
          tooltip: 'Logout',
          child: const Icon(Icons.logout),
        ),
      );
    }
  }
}
