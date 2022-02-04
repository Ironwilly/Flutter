import 'package:flutter/material.dart';

class TierraUbicacionPage extends StatefulWidget {
  const TierraUbicacionPage({Key? key}) : super(key: key);

  @override
  _TierraUbicacionPageState createState() => _TierraUbicacionPageState();
}

class _TierraUbicacionPageState extends State<TierraUbicacionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: 1100,
      decoration: BoxDecoration(
        color: Color.fromRGBO(0, 194, 255, 1),
      ),
      // margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: ListView(shrinkWrap: true, children: <Widget>[
        Row(
          children: [
            Icon(Icons.location_on_outlined),
            Text("Ubicación"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/2.png",
              scale: 5,
            )
          ],
        ),
        Container(
          margin: EdgeInsets.only(left: 30, right: 30, bottom: 10, top: 5),
          width: 286,
          height: 278,
          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(125, 222, 252, 0.4),
          ),
          alignment: AlignmentDirectional.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Fecha'),
              Text('17º', style: TextStyle(fontSize: 70, color: Colors.white)),
              Text('Soleado'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.air),
                  Text("Wind"),
                  Text("|"),
                  Text("10Km/h"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.opacity),
                  Text("Hum"),
                  Text("|"),
                  Text("54%       "),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.call_missed_outgoing),
                  Text("Ind.UV"),
                  Text(" |"),
                  Text("  54%        "),
                ],
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("29º"),
              Text("29º"),
              Text("29º"),
              Text("29º"),
              Text("29º")
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20, bottom: 20),
          decoration: BoxDecoration(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.light_mode),
              Icon(Icons.light_mode),
              Icon(Icons.light_mode),
              Icon(Icons.light_mode),
              Icon(Icons.light_mode),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("29º"),
              Text("29º"),
              Text("29º"),
              Text("29º"),
              Text("29º")
            ],
          ),
        ),
        Container(
          height: 40,
          margin: EdgeInsets.only(top: 30, bottom: 10),
          decoration: BoxDecoration(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Enero,4"),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.light_mode),
                ],
              ),
              Text("21º"),
            ],
          ),
        ),
        Container(
          height: 40,
          margin: EdgeInsets.only(top: 1, bottom: 10),
          decoration: BoxDecoration(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Enero,4"),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.light_mode),
                ],
              ),
              Text("21º"),
            ],
          ),
        ),
        Container(
          height: 40,
          margin: EdgeInsets.only(top: 1, bottom: 10),
          decoration: BoxDecoration(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Enero,4"),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.light_mode),
                ],
              ),
              Text("21º"),
            ],
          ),
        ),
        Container(
          height: 40,
          margin: EdgeInsets.only(top: 1, bottom: 10),
          decoration: BoxDecoration(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Enero,4"),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.light_mode),
                ],
              ),
              Text("21º"),
            ],
          ),
        ),
        Container(
          height: 40,
          margin: EdgeInsets.only(top: 1, bottom: 10),
          decoration: BoxDecoration(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Enero,4"),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.light_mode),
                ],
              ),
              Text("21º"),
            ],
          ),
        ),
        Container(
          height: 40,
          margin: EdgeInsets.only(top: 1, bottom: 10),
          decoration: BoxDecoration(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Enero,4"),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.light_mode),
                ],
              ),
              Text("21º"),
            ],
          ),
        ),
        Container(
          height: 40,
          margin: EdgeInsets.only(top: 1, bottom: 10),
          decoration: BoxDecoration(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Enero,4"),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.light_mode),
                ],
              ),
              Text("21º"),
            ],
          ),
        ),
      ]),
    ));
  }
}
