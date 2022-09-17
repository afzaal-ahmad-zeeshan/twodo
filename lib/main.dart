import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:twodo/models/user.dart';
import 'package:twodo/pages/about_page.dart';
import 'package:twodo/pages/settings_page.dart';
import 'package:twodo/widgets/appbar_actions.dart';
import 'package:twodo/widgets/collections_view.dart';
import 'package:twodo/widgets/create_new_bottomsheet.dart';
import 'package:twodo/widgets/groups_view.dart';
import 'package:twodo/widgets/upnext_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Ideal time to initialize
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
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
  AppUser user = AppUser();

  void handleAddBtn() {
    // show the bottom sheet
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return CreateNewBottomsheetContent();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // find child
    var child = page == ActivePage.upnext
        ? UpNextView()
        : page == ActivePage.groups
            ? GroupsView()
            :
            /* page == ActivePage.collections ? */
            CollectionsView();

    FirebaseAuth.instance.userChanges().listen((User? user) {});

    return Scaffold(
      appBar: AppBar(
        title: Text('twodo - ${page.toString().split(".")[1]}'),
        actions: [
          AppbarActions(),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.purple,
                image: DecorationImage(
                  image: AssetImage("assets/images/planning.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  '# todos for two',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.navigate_next,
              ),
              title: const Text('Up next'),
              onTap: () {
                // Load the next task card
                setState(() {
                  page = ActivePage.upnext;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.group,
              ),
              title: const Text('My groups'),
              onTap: () {
                // Load groups
                setState(() {
                  page = ActivePage.groups;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.collections_bookmark,
              ),
              title: const Text('My collections'),
              onTap: () {
                // Show my collections
                setState(() {
                  page = ActivePage.collections;
                });
                Navigator.pop(context);
              },
            ),
            const Divider(
              color: Colors.black,
              thickness: 0.25,
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
              ),
              title: const Text('Settings'),
              onTap: () async {
                // Go to settings page
                Navigator.pop(context);
                await Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => SettingsPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.info,
              ),
              title: const Text('About'),
              onTap: () async {
                // Open the about page
                Navigator.pop(context);
                await Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => AboutPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
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
