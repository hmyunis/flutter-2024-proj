import 'package:flutter/material.dart';
import 'browse_page.dart';
import 'favorites_page.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(this.isNightMode, this.toggleNightMode, {super.key});
  final bool isNightMode;
  final Function toggleNightMode;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _pages = [
    const BrowsePage(),
    const FavoritesPage(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  value: widget.isNightMode,
                  activeColor: Colors.blue[500],
                  onChanged: (value) => setState(() {
                    widget.toggleNightMode();
                  }),
                ),
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey[900]!.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _navigateBottomBar,
            selectedItemColor: Colors.blueAccent,
            unselectedItemColor: Colors.blueGrey[700],
            backgroundColor: Colors.blueGrey[900],
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.explore_rounded),
                label: 'Explore',
                backgroundColor: _selectedIndex == 0
                    ? Colors.blueGrey[800]
                    : Colors.transparent,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.star_rounded,
                  color: Colors.amber[300],
                ),
                label: 'Favorites',
                backgroundColor: _selectedIndex == 1
                    ? Colors.blueGrey[800]
                    : Colors.transparent,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.person_rounded),
                label: 'Profile',
                backgroundColor: _selectedIndex == 2
                    ? Colors.blueGrey[800]
                    : Colors.transparent,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.blueGrey[700],
      body: _pages[_selectedIndex],
    );
  }
}
