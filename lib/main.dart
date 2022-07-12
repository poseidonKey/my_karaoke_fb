import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:my_karaoke_fb/models/song_model.dart';
import 'package:my_karaoke_fb/pages/home_page.dart';
import 'package:my_karaoke_fb/pages/signin_page.dart';
import 'package:my_karaoke_fb/pages/signup_page.dart';
import 'package:my_karaoke_fb/pages/songs_page.dart';
import 'package:my_karaoke_fb/providers/auth_provider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  Widget isAuthenticated(BuildContext context) {
    if (context.watch<firebaseAuth.User>() != null) {
      return HomePage();
    }
    return SigninPage();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<firebaseAuth.User>.value(
          value: firebaseAuth.FirebaseAuth.instance.authStateChanges(),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Song_jsy',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Builder(
          builder: (context) => isAuthenticated(context),
        ),
        routes: {
          SigninPage.routeName: (context) => SigninPage(),
          SignupPage.routeName: (context) => SignupPage(),
          SongsPage.routeName: (context) => SongsPage(),
        },
      ),
    );
  }
}
