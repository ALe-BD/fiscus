import 'package:fiscus/screens/home_page.dart';
import 'package:fiscus/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/signup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // FOR TESTING: Force sign out any currently logged-in user
  await FirebaseAuth.instance.signOut();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fiscus Finance',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
<<<<<<< HEAD
      home: const AuthWrapper(),
      routes: {
        '/signup': (context) => SignUpPage(),
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            ),
          );
        }

        // If the user is logged in, show HomePage
        if (snapshot.hasData && snapshot.data != null) {
          print('User is logged in: ${snapshot.data!.email}');
          return HomePage();
        }
        // Otherwise, show LoginPage
        else {
          print('User is not logged in');
          return LoginPage();
        }
      },
=======
      home: HomeScreen(),
/*
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            return const HomeScreen();
          }
          return const AuthScreen();
        },
      ),
*/
>>>>>>> 1bcd348387ccea8f1a3e1525c7e41d9637b8317f
    );
  }
}
