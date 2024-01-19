import 'package:flutter/material.dart';

class BackToPlaylist extends StatelessWidget {
  const BackToPlaylist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
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
              title: Text('B A C K TO P L A Y L I S T'),
              leading: Icon(Icons.back_hand_outlined),
              onTap: () => Navigator.pop(context),
            ),
          ),
        ]),
      ),
    );
  }
}
