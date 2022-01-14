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
        backgroundColor: const Color(0xECECECFF),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Card(
            margin: EdgeInsets.only(top: 200.00, left: 10, right: 10),
            elevation: 4,
            color: Color(0XF8F8F8FF),
            child: Row(
              children: <Widget>[
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("20:55",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Text("SALIDA"),
                    SizedBox(height: 75),
                    Text("22:05",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Text("LLEGADA", style: TextStyle(color: Colors.black)),
                  ],
                ),
                SizedBox(width: 70),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          primary: Color(0XF8F8F8FF),
                          side: BorderSide(color: Colors.black)),
                      child: Text(
                        "MAD",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.00,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Image.asset(
                      'assets/images/iberia.png',
                      scale: 35,
                    ),
                    Text("Duración",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.normal)),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          primary: Color(0XF8F8F8FF),
                          side: BorderSide(color: Colors.black)),
                      child: Text(
                        "LHR",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.00,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Text("Madrid",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 20),
                    Text("Iberia 7448",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.normal)),
                    Text("2h 10m",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.normal)),
                    Text("Londres",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
