import 'package:dise_login_2/style.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(backgroundColor: Colors.red),
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
      body: Card(
        margin: EdgeInsets.only(top: 200.00, left: 10, right: 10),
        elevation: 4,
        child: Center(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("El más barato,Buena puntuación",
                      style: DamStyle.textTitleCustom(
                          DamStyle.colorTextBarato, DamStyle.textSizeSmall)),
                  Text("32424242"),
                ],
              ),
              Image.asset(
                'assets/images/c1.png',
                scale: 5,
              ),
              Text("fwfwfwffw"),
            ],
          ),
        ),
      ),
    );
  }
}
