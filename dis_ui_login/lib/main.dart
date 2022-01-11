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
      body: Column(
        children: <Widget>[
          const Padding(padding: EdgeInsets.only(top: 230.0)),
          Container(
            child: Center(
              child: Image.asset(
                "assets/images/path_logo.png",
                width: 200.0,
              ),
            ),
          ),
          const Text('Beautiful, Private Sharing',
              style: TextStyle(color: Colors.white54, fontSize: 16)),
          const Padding(padding: EdgeInsets.only(bottom: 130.0)),
          Container(
            child: SizedBox(
              width: 250,
              height: 55,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ),
                child: Text(
                  "Sign up",
                  style: TextStyle(
                      color: Color(0xFFE62F16),
                      fontSize: 20.00,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 20.0)),
          const Text('Already have a Path account?',
              style: TextStyle(color: Colors.white54, fontSize: 14)),
          const Padding(padding: EdgeInsets.only(bottom: 5.0)),
          SizedBox(
            width: 250,
            height: 55,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  primary: Color(0xFFE62F16),
                  side: BorderSide(color: Colors.white)),
              child: Text(
                "Log in",
                style: TextStyle(
                    color: Color(0xFFE62F16),
                    fontSize: 20.00,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 20.00)),
          Text("By using Path, you agree to Path´s",
              style: TextStyle(color: Colors.white)),
          Text(
            "Term of Use and Privacy Policy",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFE62F16),
    );
  }
}
