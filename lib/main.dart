import 'package:flutter/material.dart';
import 'presentation/screens/about_page.dart';
import 'presentation/screens/browse_page.dart';
import 'presentation/screens/favorites_page.dart';
import 'presentation/screens/profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _pages = [
    const BrowsePage(),
    const FavoritesPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: false,
      ),
      routes: {
        '/FavoritesPage': (context) => const FavoritesPage(

        ),
        '/profile': (context) => const ProfilePage(),
        '/about': (context) => const AboutPage(),
        '/BrowsePage': (context) => const BrowsePage(),
        '/AboutPage': (context) => const AboutPage(),
      },
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "VIDEO GAME CATALOGUE",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 16,
              letterSpacing: 1.5,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.info),
              onPressed: () {
                print("Info icon pressed!!!!!!!!");
              },
            )
          ],
          centerTitle: true,
          elevation: 10,
          backgroundColor: Colors.blueGrey[900],
          shadowColor: Colors.black,
        ),
        drawer: Drawer(
          backgroundColor: Colors.blueGrey[500],
          child: Column(
            children: [
              DrawerHeader(
                child: Icon(Icons.gamepad_rounded,
                    size: 80,
                    color: Colors.blue[700],
                    shadows: const [
                      Shadow(
                          color: Colors.black,
                          blurRadius: 5,
                          offset: Offset(0, 5))
                    ]),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text("B R O W S E"),
                onTap: () {
                  Navigator.pushNamed(context, MaterialPageRoute(builder: (context_) => const BrowsePage()) as String);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.star),
                title: const Text("F A V O R I T E S"),
                onTap: () {
                  Navigator.pushNamed(context, MaterialPageRoute(builder: (context_) => const FavoritesPage()) as String);
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text("S E T T I N G S"),
                onTap: () {
                  Navigator.pushNamed(context, "/profile");
                },
              ),
              const ListTile(
                leading: Icon(Icons.logout),
                title: Text("L O G O U T"),
              ),
              const Spacer(),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text("A B O U T"),
                onTap: () {
                  Navigator.pushNamed(context, "/AboutPage");
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _navigateBottomBar,
          selectedItemColor: Colors.blueGrey[300],
          unselectedItemColor: Colors.blueGrey[700],
          backgroundColor: Colors.blueGrey[900],
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Browse',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.star_outlined,
                color: Color.fromARGB(255, 139, 117, 50),
              ),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
        backgroundColor: Colors.blueGrey[700],
        body: _pages[_selectedIndex],
      ),
    );
  }
}


