import 'package:flutter/material.dart';
import 'package:music_player_app/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(children: [
        DrawerHeader(
          child: Center(
            child: Icon(
              Icons.music_note,
              size: 25.0,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 25.0, top: 25.0),
          child: ListTile(
            title: Text('H O M E'),
            leading: Icon(Icons.home),
            onTap: () => Navigator.pop(context),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 25.0, top: 25.0),
          child: ListTile(
            title: Text('S E T T I N G S'),
            leading: Icon(Icons.settings),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingsPage(),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
