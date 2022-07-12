import 'package:flutter/material.dart';
import 'package:my_karaoke_fb/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;

class SongsPage extends StatefulWidget {
  const SongsPage({Key key}) : super(key: key);
  static const String routeName = 'songs-page';

  @override
  State<SongsPage> createState() => _SongsPageState();
}

class _SongsPageState extends State<SongsPage> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<firebaseAuth.User>();
    print(">>>${user.uid}");
    return Scaffold(
      appBar: AppBar(
        title: Text("Songs"),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthProvider>().signOut();
            },
            icon: Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: Center(
        child: Text("Your Songs"),
      ),
    );
  }
}
