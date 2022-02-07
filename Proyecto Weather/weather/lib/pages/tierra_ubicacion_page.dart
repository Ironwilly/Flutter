import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:weather/models/current_weather.dart';
import 'package:http/http.dart' as http;
import 'package:weather/models/timehour.dart';

class TierraUbicacionPage extends StatefulWidget {
  const TierraUbicacionPage({Key? key}) : super(key: key);

  @override
  _TierraUbicacionPageState createState() => _TierraUbicacionPageState();
}

class _TierraUbicacionPageState extends State<TierraUbicacionPage> {
  late Future<List<Hourly>> items;

  @override
  void initState() {
    items = fetchHourly();

    super.initState();
  }

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
          margin: EdgeInsets.only(top: 10),
          child: SizedBox(
            width: 380,
            height: 210,
            child: FutureBuilder<List<Hourly>>(
                future: items,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return _hourList(snapshot.data!);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  return const CircularProgressIndicator();
                }),
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

Future<List<Hourly>> fetchHourly() async {
  final response = await http.get(Uri.parse(
      'https://api.openweathermap.org/data/2.5/onecall?lat=37.3753501&lon=-6.0250984&exclude={part}&appid=f8e79a384cdfa0e8b60cdce1b67fb6dc&unit=metric'));
  if (response.statusCode == 200) {
    return TimeHour.fromJson(jsonDecode(response.body)).hourly;
  } else {
    throw Exception('Failed to load weather');
  }
}

Widget _hourList(List<Hourly> hourList) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: hourList.length,
    itemBuilder: (context, index) {
      return _hourItem(hourList.elementAt(index));
    },
  );
}

Widget _hourItem(Hourly hourly) {
  return Flexible(
      child: Container(
    child: Column(children: [
      Image.network(
        'https://api.openweathermap.org/data/2.5/onecall?lat=37.3753501&lon=-6.0250984&exclude={part}&appid=f8e79a384cdfa0e8b60cdce1b67fb6dc&unit=metric',
        scale: 2,
      ),
      Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: 100,
            child: Column(
              children: [
                Image.network(
                    'http://openweathermap.org/img/wn/${hourly.weather[0].icon}.png'),
                Text(hourly.dt.toString()),
                Text(((hourly.temp - 273).toStringAsFixed(2) + "º"),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.fade,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          ))
    ]),
  ));
}
