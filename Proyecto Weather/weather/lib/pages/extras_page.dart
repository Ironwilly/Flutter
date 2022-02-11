import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/models/listDays_model.dart';
import 'package:weather/models/one_call_model.dart';
import 'package:weather/models/weather_model.dart';

late Future<List<WeatherModel>> items;

late String citiSelect = "";
late double latSelected = 0;
late double lngSelected = 0;

@override
Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const ExtrasPage(title: 'Flutter Demo Home Page'),
  );
}

class ExtrasPage extends StatefulWidget {
  const ExtrasPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<ExtrasPage> createState() => _MyHomePageState2();
}

class _MyHomePageState2 extends State<ExtrasPage> {
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
        child: const Center(
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
      decoration: const BoxDecoration(
          color: Color.fromRGBO(0, 194, 255, 1.6),
          image: DecorationImage(
              image: AssetImage("assets/images/8.png"), fit: BoxFit.cover)),
      // margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: ListView(shrinkWrap: true, children: <Widget>[
        Row(
          children: [
            const Icon(Icons.location_on_outlined),
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
        Expanded(
          child: new Container(
              margin: const EdgeInsets.only(left: 0, right: 10),
              child: const Divider(
                  color: Colors.yellow, thickness: 3, indent: 20)),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: SizedBox(
            width: 380,
            height: 510,
            child: FutureBuilder<List<Daily>>(
                future: items3,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return _dailyList2(snapshot.data!);
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
    margin: const EdgeInsets.only(left: 20),
    width: 300,
    child: Text(
      weatherModel.name,
      style: const TextStyle(
          color: Color.fromARGB(255, 255, 0, 0),
          fontSize: 35,
          fontFamily: 'Arch'),
      textAlign: TextAlign.center,
    ),
  );
}

Widget _hourlyItem(Hourly hour, int index) {
  return Flexible(
      child: Container(
    child: Column(
      children: [
        Text(_convertHour(hour.dt, true)),
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

Widget _currentWeatherTime() {
  String _selectedDateTime = formatDate(
      DateTime.now(), [DD, ", ", dd, " ", MM, " ", yyyy],
      locale: const SpanishDateLocale());
  return Text(
    _selectedDateTime,
    style: const TextStyle(
        fontSize: 30,
        color: Color.fromARGB(255, 0, 0, 0),
        fontWeight: FontWeight.bold,
        fontFamily: 'Arch'),
  );
}

Widget _currentWeatherTime2() {
  String _selectedDateTime =
      formatDate(DateTime.now(), [DD, " "], locale: const SpanishDateLocale());
  return Text(_selectedDateTime, style: const TextStyle(fontFamily: 'Arch'));
}

Widget _dailyList2(List<Daily> dailyResponse) {
  return SizedBox(
    height: 360,
    child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 1,
        itemBuilder: (context, index) {
          return _dailyItem2(dailyResponse.elementAt(index), index);
        }),
  );
}

Widget _dailyItem2(Daily daily, dynamic index) {
  return Flexible(
      child: Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text("Temp.Max " + daily.temp.max.toStringAsFixed(0) + "º",
            style: const TextStyle(
                fontSize: 30,
                color: Color.fromARGB(255, 255, 255, 255),
                fontFamily: 'Arch')),
        const Divider(
            color: const Color.fromARGB(255, 255, 255, 255),
            thickness: 1,
            indent: 20),
        Text("Temp.Min " + daily.temp.min.toStringAsFixed(0) + "º",
            style: const TextStyle(
                fontSize: 30,
                color: Color.fromARGB(255, 253, 253, 253),
                fontFamily: 'Arch')),
        const Divider(
            color: const Color.fromARGB(255, 255, 255, 255),
            thickness: 1,
            indent: 20),
        Text("Humedad " + daily.humidity.toString() + "%",
            style: const TextStyle(
                fontSize: 30,
                color: Color.fromARGB(255, 255, 255, 255),
                fontFamily: 'Arch')),
        const Divider(
            color: Color.fromARGB(255, 255, 255, 255),
            thickness: 1,
            indent: 20),
        Text("Presión " + daily.pressure.toString() + " hPa",
            style: const TextStyle(
                fontSize: 30,
                color: Color.fromARGB(255, 255, 255, 255),
                fontFamily: 'Arch')),
        const Divider(
            color: const Color.fromARGB(255, 255, 255, 255),
            thickness: 1,
            indent: 20),
        Text("%Cielo nublado " + daily.clouds.toString() + "%",
            style: const TextStyle(
                fontSize: 30,
                color: Color.fromARGB(255, 255, 255, 255),
                fontFamily: 'Arch')),
        const Divider(
            color: Color.fromARGB(255, 255, 255, 255),
            thickness: 1,
            indent: 20),
        Text("Uvi " + daily.uvi.toString() + "%",
            style: const TextStyle(
                fontSize: 30,
                color: Color.fromARGB(255, 255, 255, 255),
                fontFamily: 'Arch')),
        const Divider(
            // ignore: unnecessary_const
            color: const Color.fromARGB(255, 255, 255, 255),
            thickness: 1,
            indent: 20),
        Text("Veloc. Viento " + daily.windSpeed.toString() + "Km/h",
            style: const TextStyle(
                fontSize: 30,
                color: Color.fromARGB(255, 255, 255, 255),
                fontFamily: 'Arch')),
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
