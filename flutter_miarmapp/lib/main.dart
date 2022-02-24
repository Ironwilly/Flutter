import 'package:flutter/material.dart';
import 'package:flutter_miarmapp/ui/screens/home_screen.dart';
import 'package:flutter_miarmapp/ui/screens/login_screen.dart';
import 'package:flutter_miarmapp/ui/screens/menu_screen.dart';
import 'package:flutter_miarmapp/ui/screens/profile_screen.dart';
import 'package:flutter_miarmapp/ui/screens/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MiarmApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/HomeScreen',
      routes: {
        '/': (context) => const MenuScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/HomeScreen': (context) => const HomeScreen(),
        '/ProfileScreen': (context) => const ProfileScreen()
      },
    );
  }
}
