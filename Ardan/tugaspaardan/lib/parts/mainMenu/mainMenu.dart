import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _selectedDrawerIndex = 0;

  final List<Widget> _drawerItems = [
    // GamesMenu(),
    // OfflinePage(),
    // TimeConverterPage(),
    GamesMenu(),
    GamesMenu(),
    GamesMenu(),
  ];

  void _onSelectItem(int index) {
    setState(() {
      _selectedDrawerIndex = index;
      Navigator.pop(context); // Close the drawer
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Menu'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Browse Games'),
              onTap: () => _onSelectItem(0),
            ),
            ListTile(
              title: Text('Offline Menu'),
              onTap: () => _onSelectItem(1),
            ),
            ListTile(
              title: Text('Server Time Converter'),
              onTap: () => _onSelectItem(2),
            ),
          ],
        ),
      ),
      body: _drawerItems[_selectedDrawerIndex],
    );
  }
}

class GamesMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Games Menu Content',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
