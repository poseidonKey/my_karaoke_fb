import 'package:flutter/material.dart';
import 'package:my_karaoke_fb/pages/profile_page.dart';
import 'package:my_karaoke_fb/pages/songs_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _pages = [
    SongsPage(),
    ProfilePage(),
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Your Song"),
      // ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
    );
  }

  Widget _bottomNavigationBar(int selectedIndex) {
    return BottomNavigationBar(
      backgroundColor: Colors.grey[200],
      currentIndex: selectedIndex,
      onTap: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.note),
          label: 'Songs',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Profile',
        ),
      ],
    );
  }
}
