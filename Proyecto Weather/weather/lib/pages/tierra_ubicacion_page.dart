import 'dart:convert';
import 'dart:ffi';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  late Future<Current> items2;
  late Future<List<Daily>> items3;

  @override
  void initState() {
    items = fetchHourly();
    items2 = fetchCurrent();
    items3 = fetchDaily();
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
          width: 386,
          height: 278,
          padding:
              EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10, right: 10),
          decoration: BoxDecoration(
            color: Color.fromRGBO(125, 222, 252, 0.4),
          ),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 310,
                height: 278,
                child: FutureBuilder<Current>(
                    future: items2,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return _hourItem2(snapshot.data!);
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }

                      return const CircularProgressIndicator();
                    }),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 380,
                height: 130,
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
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: SizedBox(
            width: 380,
            height: 510,
            child: FutureBuilder<List<Daily>>(
                future: items3,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return _dailyList(snapshot.data!);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  return const CircularProgressIndicator();
                }),
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

Future<Current> fetchCurrent() async {
  final response = await http.get(Uri.parse(
      'https://api.openweathermap.org/data/2.5/onecall?lat=37.3753501&lon=-6.0250984&exclude={part}&appid=f8e79a384cdfa0e8b60cdce1b67fb6dc&unit=metric'));
  if (response.statusCode == 200) {
    return TimeHour.fromJson(jsonDecode(response.body)).current;
  } else {
    throw Exception('Failed to load weather');
  }
}

Future<List<Daily>> fetchDaily() async {
  final response = await http.get(Uri.parse(
      'https://api.openweathermap.org/data/2.5/onecall?lat=37.3753501&lon=-6.0250984&exclude={part}&appid=f8e79a384cdfa0e8b60cdce1b67fb6dc&unit=metric'));
  if (response.statusCode == 200) {
    return TimeHour.fromJson(jsonDecode(response.body)).daily;
  } else {
    throw Exception('Failed to load weather');
  }
}

Widget _dailyList(List<Daily> dailyList) {
  return ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: dailyList.length,
    itemBuilder: (context, index) {
      return _dailyItem(dailyList.elementAt(index));
    },
  );
}

Widget _dailyItem(Daily daily) {
  return Flexible(
      child: Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          _convertHour(daily.dt, true),
          style: TextStyle(fontSize: 20),
        ),
        Text(daily.moonPhase.toString(), style: TextStyle(fontSize: 20)),
        Text((daily.weather[0].description), style: TextStyle(fontSize: 20)),
      ],
    ),
  ));
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
    child: Column(
      children: [
        Text(_convertHour(hourly.dt, true)),
        new SvgPicture.asset(
          'assets/images/icons/${hourly.weather[0].icon}.svg',
        ),
        Text(((hourly.temp - 273).toStringAsFixed(2) + "º"),
            textAlign: TextAlign.center,
            overflow: TextOverflow.fade,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            )),
      ],
    ),
  ));
}

Widget _hourItem2(Current current) {
  return Flexible(
    child: Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(125, 222, 252, 0.4),
      ),
      alignment: AlignmentDirectional.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(((current.temp - 273).toStringAsFixed(0)) + "º",
              style: TextStyle(fontSize: 70, color: Colors.white)),
          Text(
            current.weather[0].description,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.air),
              Text("Wind"),
              Text("|"),
              Text(current.windSpeed.toString() + " Km/h"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.opacity),
              Text("Hum"),
              Text("|"),
              Text(current.humidity.toString() + " %       "),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.call_missed_outgoing),
              Text("Ind.UV"),
              Text("|"),
              Text(current.uvi.toString() + " %         "),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _currentWeatherTime() {
  String _selectedDateTime = formatDate(
      DateTime.now(), [DD, ", ", dd, " ", MM, " ", yyyy],
      locale: const SpanishDateLocale());
  return Text(_selectedDateTime);
}

DateTime _dtConverter(int timestamp) {
  return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
}

_convertHour(int timestamp, bool op) {
  var result = _dtConverter(timestamp).toString().split(' ');
  if (op) {
    return result[1].replaceRange(4, 11, '');
  } else {
    return result[0];
  }
}
