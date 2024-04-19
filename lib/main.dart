import 'package:flutter/material.dart';
import 'presentation/widgets/new_game_modal.dart';
import 'presentation/screens/available_games.dart';
import 'presentation/screens/login_page.dart';
import 'presentation/screens/registration_page.dart';
import 'presentation/screens/about_page.dart';
import 'presentation/screens/browse_page.dart';
import 'presentation/screens/favorites_page.dart';
import 'presentation/screens/profile_page.dart';
import 'presentation/data/accounts.dart';

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
  bool? _isNightMode;

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
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegistrationPage(),
        '/browse': (context) => const BrowsePage(),
        '/favorites': (context) => const FavoritesPage(),
        '/profile': (context) => const ProfilePage(),
        '/allgames': (context) => const AvailableGames(),
        '/about': (context) => const AboutPage(),
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
            Builder(builder: (context) {
              return IconButton(
                icon: const Icon(Icons.info),
                onPressed: () {
                  Navigator.pushNamed(context, '/about');
                },
              );
            })
          ],
          centerTitle: true,
          elevation: 10,
          backgroundColor: Colors.blueGrey[900],
          shadowColor: Colors.black,
        ),
        drawer: Drawer(
          backgroundColor: Colors.blueGrey[500],
          child: Builder(builder: (context) {
            return Column(
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
                  leading: const Icon(Icons.fitbit_outlined),
                  title: const Text("G A M E S"),
                  onTap: () {
                    Navigator.pushNamed(context, '/allgames');
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.dark_mode),
                  title: const Text("N I G H T  M O D E"),
                  trailing: Switch(
                    value: _isNightMode ?? false,
                    activeColor: Colors.blue[500],
                    onChanged: (value) => setState(() {
                      _isNightMode = value;
                    }),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text("L O G  O U T"),
                  onTap: () {
                    Navigator.pushNamed(context, "/login");
                  },
                ),
                const Spacer(),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text("A B O U T"),
                  onTap: () {
                    Navigator.pushNamed(context, "/about");
                  },
                ),
              ],
            );
          }),
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
        floatingActionButton: (accounts[0].userType == "Owner" ||
                    accounts[0].userType == "Admin") &&
                (_selectedIndex == 0)
            ? Builder(builder: (context) {
                return FloatingActionButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        constraints: const BoxConstraints(maxHeight: 600),
                        backgroundColor: Colors.blueGrey[800],
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25),
                          ),
                        ),
                        builder: (context) => const NewGameModal(),
                      );
                    },
                    child: const Icon(Icons.add));
              })
            : null,
        backgroundColor: Colors.blueGrey[700],
        body: _pages[_selectedIndex],
      ),
    );
  }
}
