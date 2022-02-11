import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/models/geocoding_model.dart';
import 'package:weather/models/listDays_model.dart';
import 'package:weather/models/one_call_model.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/pages/tierra_ubicacion_page.dart';

late Future<List<WeatherModel>> items;

late String citiSelect = "";
late double latSelected = 0;
late double lngSelected = 0;

@override
Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const PlaceSelected2(title: 'Flutter Demo Home Page'),
  );
}

class PlaceSelected2 extends StatefulWidget {
  const PlaceSelected2({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<PlaceSelected2> createState() => _MyHomePageState2();
}

class _MyHomePageState2 extends State<PlaceSelected2> {
  late Future<List<Hourly>> items;
  late Future<Current> items2;
  late Future<List<Daily>> items3;
  late Future<WeatherModel> currentWeather;

  @override
  void initState() {
    items = fetchHourly();
    items2 = fetchCurrent();
    currentWeather = fetchWeather();
    items3 = fetchDaily();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (latSelected == 0) {
      return Scaffold(
          body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/images/lugar.jpg",
              ),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: Text(
            'NO HAY CIUDAD SELECCIONADA',
            style: TextStyle(
                color: Colors.red, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ));
    }
    return Scaffold(
        body: Container(
      height: 1100,
      decoration: BoxDecoration(
          color: Color.fromRGBO(0, 194, 255, 1),
          image: DecorationImage(
              image: AssetImage("assets/images/8.png"), fit: BoxFit.cover)),
      // margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: ListView(shrinkWrap: true, children: <Widget>[
        Row(
          children: [
            Icon(Icons.location_on_outlined),
            FutureBuilder<WeatherModel>(
              future: currentWeather,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return name(snapshot.data!);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/2.png",
              scale: 5,
            ),
          ],
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_currentWeatherTime()]),
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
                        return _hourlyList(snapshot.data!);
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

Widget name(WeatherModel weatherModel) {
  return Container(
    margin: EdgeInsets.only(left: 20),
    width: 300,
    child: Text(
      weatherModel.name,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 30,
      ),
      textAlign: TextAlign.center,
    ),
  );
}

Widget _hourlyList(List<Hourly> hourlyResponse) {
  return SizedBox(
    height: 250,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 24,
        itemBuilder: (context, index) {
          return _hourlyItem(hourlyResponse.elementAt(index), index);
        }),
  );
}

Widget _hourlyItem(Hourly hour, int index) {
  return Flexible(
      child: Container(
    child: Column(
      children: [
        Text(_convertHour(hour.dt, true),
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            )),
        //new SvgPicture.asset(
        //   'assets/images/icons/${hourly.weather[0].icon}.svg'),
        Image.asset(
          'assets/images/icons/${hour.weather[0].icon}.gif',
          scale: 6,
        ),
        Text(((hour.temp).toStringAsFixed(0) + "º"),
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
              style: TextStyle(fontSize: 80, color: Colors.white)),
          Text(
            current.weather[0].description,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.air),
              Text("Wind",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
              Text("|",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
              Text(current.windSpeed.toString() + " Km/h",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.opacity),
              Text("Hum",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
              Text("|",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
              Text(current.humidity.toString() + " %       ",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.call_missed_outgoing),
              Text("Ind.UV",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
              Text("|",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
              Text(current.uvi.toString() + " %         ",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _dailyList(List<Daily> dailyResponse) {
  return SizedBox(
    height: 360,
    child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 7,
        itemBuilder: (context, index) {
          return _dailyItem(dailyResponse.elementAt(index), index);
        }),
  );
}

Widget _currentWeatherTime() {
  String _selectedDateTime = formatDate(
      DateTime.now(), [DD, ", ", dd, " ", MM, " ", yyyy],
      locale: const SpanishDateLocale());
  return Text(_selectedDateTime,
      style: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ));
}

Widget _currentWeatherTime2() {
  String _selectedDateTime =
      formatDate(DateTime.now(), [DD, " "], locale: const SpanishDateLocale());
  return Text(_selectedDateTime);
}

Widget _dailyItem(Daily daily, dynamic index) {
  return Flexible(
      child: Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
            formatDate(
              listaDays[index].day,
              [DD],
              locale: const SpanishDateLocale(),
            ),
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red)),
        Image.asset(
          'assets/images/icons/${daily.weather[0].icon}.gif',
          scale: 6,
        ),
        Text(daily.temp.max.toStringAsFixed(0) + "º Max",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
        Text(daily.temp.min.toStringAsFixed(0) + "º Min",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
      ],
    ),
  ));
}

Future<WeatherModel> fetchWeather() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var lat = prefs.getDouble('lat');
  var lng = prefs.getDouble('lng');

  latSelected = lat!;
  lngSelected = lng!;
  final response = await http.get(Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=${latSelected}&lon=${lngSelected}&appid=f8e79a384cdfa0e8b60cdce1b67fb6dc&units=metric&lang=es'));
  if (response.statusCode == 200) {
    return WeatherModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load planets');
  }
}

Future<List<Daily>> fetchDaily() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var lat = prefs.getDouble('lat');
  var lng = prefs.getDouble('lng');

  latSelected = lat!;
  lngSelected = lng!;

  final response = await http.get(Uri.parse(
      'https://api.openweathermap.org/data/2.5/onecall?lat=${latSelected}&lon=${lngSelected}&exclude=minutely&appid=f8e79a384cdfa0e8b60cdce1b67fb6dc&units=metric&lang=es'));
  if (response.statusCode == 200) {
    return OneCallModel.fromJson(jsonDecode(response.body)).daily;
  } else {
    throw Exception('Failed to load planets');
  }
}

Future<List<Hourly>> fetchHourly() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var lat = prefs.getDouble('lat');
  var lng = prefs.getDouble('lng');

  latSelected = lat!;
  lngSelected = lng!;

  final response = await http.get(Uri.parse(
      'https://api.openweathermap.org/data/2.5/onecall?lat=${latSelected}&lon=${lngSelected}&exclude=minutely&appid=f8e79a384cdfa0e8b60cdce1b67fb6dc&units=metric&lang=es'));
  if (response.statusCode == 200) {
    return OneCallModel.fromJson(jsonDecode(response.body)).hourly;
  } else {
    throw Exception('Failed to load planets');
  }
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

Future<Current> fetchCurrent() async {
  final response = await http.get(Uri.parse(
      'https://api.openweathermap.org/data/2.5/onecall?lat=37.3753501&lon=-6.0250984&exclude={part}&appid=f8e79a384cdfa0e8b60cdce1b67fb6dc&unit=metric&lang=es'));
  if (response.statusCode == 200) {
    return OneCallModel.fromJson(jsonDecode(response.body)).current;
  } else {
    throw Exception('Failed to load weather');
  }
}
