import 'package:flutter/material.dart';
import 'package:twodo/pages/about_page.dart';
import 'package:twodo/pages/settings_page.dart';
import 'package:url_launcher/url_launcher_string.dart';

void main() {
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
        primarySwatch: Colors.purple,
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
  int _counter = 0;

  // put website link here.
  String url = "";

  void handleAddBtn() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          PopupMenuButton(
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
          ),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
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
