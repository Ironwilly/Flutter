import 'package:flutter/material.dart';

class TierraPage extends StatefulWidget {
  const TierraPage({Key? key}) : super(key: key);

  @override
  _TierraPageState createState() => _TierraPageState();
}

class _TierraPageState extends State<TierraPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: 900,
      decoration: BoxDecoration(
        color: Color.fromRGBO(0, 194, 255, 1),
      ),
      // margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: ListView(shrinkWrap: true, children: <Widget>[
        Row(
          children: [Icon(Icons.location_on_outlined), Text("Ubicación")],
        ),
        Container(
          margin: EdgeInsets.only(left: 30, right: 30, bottom: 10, top: 30),
          width: 286,
          height: 378,
          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(125, 222, 252, 0.4),
          ),
          alignment: AlignmentDirectional.center,
          child: Column(
            children: [
              Text('Fecha'),
              Image.asset(
                "assets/images/14.png",
                scale: 4.7,
              )
            ],
          ),
        ),
        Container(
            width: 400,
            height: 300,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Image.asset(
                  "assets/images/8.png",
                ),
                ElevatedButton(
                  onPressed: () {
                    // Respond to button press
                  },
                  child: Text('Elige Ubicación'),
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(249, 196, 83, 1)),
                ),
              ],
            ))
      ]),
    ));
  }
}
