import 'package:flutter/material.dart';

class MartePage extends StatefulWidget {
  const MartePage({Key? key}) : super(key: key);

  @override
  _MartePageState createState() => _MartePageState();
}

class _MartePageState extends State<MartePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/1.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      height: 900,
      child: ListView(shrinkWrap: true, children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/9.png",
              scale: 1.3,
            ),
            Text(
              "Marte",
              style: TextStyle(fontSize: 70, color: Colors.white),
            ),
            Container(
              width: 286,
              height: 308,
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              decoration: BoxDecoration(
                color: Color.fromRGBO(125, 222, 252, 0.4),
              ),
              alignment: AlignmentDirectional.center,
              child: Column(
                children: [
                  Text('Fecha'),
                ],
              ),
            ),
          ],
        ),
      ]),
    ));
  }
}
