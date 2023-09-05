import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newapp/provider/theme_provider.dart';
import 'package:newapp/router/app_route_constants.dart';
import 'package:provider/provider.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://accgroup.vn/wp-content/uploads/2023/02/Background-la-gi.jpg.webp')),
            ),
            child: Center(
                child: Text(
              'NEWS APP',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text(
              'Home',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              // Handle Home tap
            },
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text(
              'Categories',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              context.goNamed(MyAppRouteConstants.categoryselectRouteName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            trailing: ClipOval(
              child: Container(
                color: Colors.red,
                width: 20,
                height: 20,
                child: const Center(
                  child: Text(
                    '8',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
            title: const Text(
              'Favorites',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              context.go(MyAppRouteConstants.favoriteRouteName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.remove_red_eye),
            trailing: ClipOval(
              child: Container(
                color: Colors.amber,
                width: 20,
                height: 20,
                child: const Center(
                  child: Text(
                    '8',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
            title: const Text(
              'Seen',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              // Handle Favorites tap
            },
          ),
          ExpansionTile(
            leading: const Icon(Icons.settings),
            title: const Text(
              'Settings',
              style: TextStyle(fontSize: 20),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      themeProvider.themeMode == ThemeModeEnum.Dark
                          ? 'Dark'
                          : 'Light',
                      style: const TextStyle(fontSize: 24),
                    ),
                    Switch(
                      value: themeProvider.themeMode == ThemeModeEnum.Dark,
                      onChanged: (value) {
                        themeProvider.toggleTheme();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          ListTile(
            title: const Text(
              'Exit',
              style: TextStyle(fontSize: 20),
            ),
            leading: const Icon(Icons.exit_to_app),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
