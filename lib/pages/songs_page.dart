import 'package:flutter/material.dart';
import 'package:my_karaoke_fb/providers/auth_provider.dart';
import 'package:my_karaoke_fb/widgets/error_dialog.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;

import '../providers/song_provider.dart';

class SongsPage extends StatefulWidget {
  const SongsPage({Key key}) : super(key: key);
  static const String routeName = 'songs-page';

  @override
  State<SongsPage> createState() => _SongsPageState();
}

class _SongsPageState extends State<SongsPage> {
  String userId;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPersistentFrameCallback((_) async {
      final user = context.read<firebaseAuth.User>();
      userId = user.uid;
      try {
        await context.read<SongList>().getAllNotes(userId);
      } catch (e) {
        errorDialog(context, e);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final user = context.watch<firebaseAuth.User>();
    // print(">>>${user.uid}");
    final songList = context.watch<SongList>().state;
    return Scaffold(
      appBar: AppBar(
        title: Text("Songs"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: Center(
        child: Text("Your Songs"),
      ),
    );
  }
}
