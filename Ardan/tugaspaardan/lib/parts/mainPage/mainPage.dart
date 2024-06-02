import 'package:flutter/material.dart';

import '../mainMenu/mainMenu.dart';
import '../halamanUtama/note.dart';
import '../loginReg/login.dart';

class MyHomePage extends StatefulWidget {
  final String email;

  MyHomePage({required this.email});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  late String email;
  late List<Widget> _widgetOptions;

  // final List<Widget> _widgetOptions = <Widget>[
  //   // MainMenu(),
  //   NotePage(email: email),
  //   MainPage(),
  //   // ProfilePage(),
  // ];

  @override
  void initState() {
    super.initState();
    email = widget.email;
    _widgetOptions = <Widget>[
      NotePage(email: email),
      MainPage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Theme.of(context).colorScheme.secondary,
        // selectedItemColor: ,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Main Page',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Profile Page',
          ),
        ],
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  // log out button to login page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          child: Text('Log Out'),
        ),
      ),
    );
  }
}
