
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _pages = [
    // NotesPage(),
    // ProfilePage(),
  ];
  int _selectedIndex = 0; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Song"),),
      body: Container(
        
      ),
    );
  }
}