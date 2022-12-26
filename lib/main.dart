import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:twodo/firebase_options.dart';
import 'package:twodo/pages/login_page.dart';
import 'package:twodo/widgets/create_todo_sheet.dart';
import 'package:twodo/widgets/todo_list.dart';
import 'package:twodo/widgets/upnext_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid || Platform.isIOS || Platform.isMacOS || kIsWeb) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
    );
  }

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await FirebaseFirestore.instance.enablePersistence();
  }

  // Ideal time to initialize
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String dbName = "twodo.app";
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'twodo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.purple,
        textTheme: GoogleFonts.openSansTextTheme(),
      ),
      home: const MyHomePage(title: 'twodo'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void handleAddBtn() {
    // show the bottom sheet
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8.0),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: CreateTodoSheet(),
        );
      },
    );
    // addTodos();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.userChanges().listen(
      (User? user) async {
        if (user == null) {
          // move to the login page
          // await Navigator.push(
          //   context,
          //   MaterialPageRoute<void>(
          //     builder: (BuildContext context) => LoginPage(),
          //   ),
          // );

          // Navigator.of(context).pushAndRemoveUntil(
          //   MaterialPageRoute(builder: (context) => LoginPage()),
          //   (Route<dynamic> route) => false,
          // );

          // refresh the icon?
          setState(() {});
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('twodo'),
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => LoginPage(),
                ),
              );
              setState(() {});
            },
            tooltip: "Account",
            icon: Icon(
              Icons.account_circle_rounded,
              color: FirebaseAuth.instance.currentUser == null
                  ? Colors.black
                  : Colors.purple,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            TodoList(),
            // child,
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: handleAddBtn,
        tooltip: 'Add new',
        child: const Icon(Icons.add),
      ),
    );
  }
}
