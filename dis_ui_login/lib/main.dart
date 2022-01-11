import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Path',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/path_logo.png'),
            const Text(
              'Beautiful,Private Sharing',
              style: TextStyle(color: Colors.white),
            ),
            TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(primary: Colors.white),
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 20),
                )),
            const Text('ff'),
          ],
        ),
      ),
      backgroundColor: const Color(0xFFE62F16),
    );
  }
}
