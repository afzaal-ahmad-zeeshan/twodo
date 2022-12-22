import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:twodo/models/todo.dart';
import 'package:twodo/pages/about_page.dart';
import 'package:twodo/pages/login_page.dart';
import 'package:twodo/pages/settings_page.dart';
import 'package:twodo/services/todos_service.dart';
import 'package:twodo/widgets/upnext_view.dart';
import 'package:uuid/uuid.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid || Platform.isIOS || Platform.isMacOS || kIsWeb) {
    await Firebase.initializeApp();
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
      ),
      home: const MyHomePage(title: 'twodo'),
      debugShowCheckedModeBanner: false,
    );
  }
}

enum ActivePage {
  upnext,
  groups,
  collections,
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ActivePage page = ActivePage.upnext;

  // Navigation
  int pageIndex = 0;

  void onPageChanged(int index) {
    setState(() {
      page = ActivePage.values[index];
    });
  }

  void handleAddBtn() {
    // show the bottom sheet
    // showModalBottomSheet(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return CreateNewBottomsheetContent();
    //   },
    // );
    // addTodos();
  }

  @override
  Widget build(BuildContext context) {
    // find child
    // var child = page == ActivePage.upnext
    //     ? UpNextView()
    //     :
    //     /* page == ActivePage.collections ? */
    //     CollectionsView();
    var child = UpNextView();

    FirebaseAuth.instance.userChanges().listen((User? user) {});

    return Scaffold(
      appBar: AppBar(
        title: Text('twodo - ${page.toString().split(".")[1]}'),
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => LoginPage(),
                  // builder: (BuildContext context) => const SignInScreen(
                  //   providers: [],
                  // ),
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
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.navigate_next),
      //       label: 'Up next',
      //       tooltip: "Upcoming items to wrap up",
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.group),
      //       label: 'Groups',
      //       tooltip: "My groups with my friends",
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.collections_bookmark),
      //       label: 'Collections',
      //       tooltip: "The collections that I own",
      //     ),
      //   ],
      //   currentIndex: page.index,
      //   selectedItemColor: Colors.purple,
      //   onTap: onPageChanged,
      // ),
      // bottomNavigationBar: NavigationBar(
      //   onDestinationSelected: onPageChanged,
      //   selectedIndex: page.index,
      //   destinations: const <Widget>[
      //     NavigationDestination(
      //       icon: Icon(Icons.navigate_next),
      //       label: 'Up next',
      //       tooltip: "Upcoming items to wrap up",
      //     ),
      //     NavigationDestination(
      //       icon: Icon(Icons.group),
      //       label: 'Groups',
      //       tooltip: "My groups with my friends",
      //     ),
      //     NavigationDestination(
      //       // selectedIcon: Icon(Icons.collections_bookmark),
      //       icon: Icon(Icons.collections_bookmark),
      //       label: 'Collections',
      //       tooltip: "The collections that I own",
      //     ),
      //   ],
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: page == ActivePage.upnext
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            child,
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
