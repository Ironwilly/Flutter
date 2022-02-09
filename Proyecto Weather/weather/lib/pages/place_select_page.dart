import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/models/geocoding_model.dart';
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
            style: TextStyle(color: Colors.red, fontSize: 30),
          ),
        ),
      ));
    }
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
  return Text(
    weatherModel.name,
    style: const TextStyle(color: Colors.white, fontSize: 60),
  );
}

Widget _temperature(WeatherModel response) {
  String _selectedDateTime = formatDate(
      DateTime.now(), [DD, ", ", dd, " ", MM, " ", yyyy],
      locale: const SpanishDateLocale());

  double temperature = (response.main.temp) - 273;

  return Text(
    temperature.toStringAsFixed(1) + '˚C', //curent temperature
    style: TextStyle(
      color: temperature <= 0
          ? Colors.blue
          : temperature > 0 && temperature <= 15
              ? Colors.indigo
              : temperature > 15 && temperature < 30
                  ? Colors.deepPurple
                  : Colors.pink,
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
  return Container(
    width: 100,
    decoration: BoxDecoration(
      color: Colors.blue[800]?.withOpacity(0.8),
    ),
    child: Column(
      children: [
        Text(
          hour.pressure.toString(),
        )
      ],
    ),
  );
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

Widget _dailyList(List<Daily> dailyResponse) {
  return SizedBox(
    height: 330,
    child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 7,
        itemBuilder: (context, index) {
          return _dailyItem(dailyResponse.elementAt(index), index);
        }),
  );
}

Widget _dailyItem(Daily daily, int index) {
  return Container(
    width: 100,
    decoration: BoxDecoration(
      color: Colors.blue[800]?.withOpacity(0.8),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Temp Media: ",
            style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold)),
        Image.network('http://openweathermap.org/img/wn/' +
            daily.weather[0].icon +
            '.png'),
        Text(daily.temp.day.toString() + "º",
            style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold)),
      ],
    ),
  );
}

Future<WeatherModel> fetchWeather() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var lat = prefs.getDouble('lat');
  var lng = prefs.getDouble('lng');

  latSelected = lat!;
  lngSelected = lng!;
  final response = await http.get(Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=${latSelected}&lon=${lngSelected}&appid=b67e3a6f41956f3d2f21725d8148ee93'));
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
      'https://api.openweathermap.org/data/2.5/onecall?lat=${latSelected}&lon=${lngSelected}&exclude=minutely&appid=b67e3a6f41956f3d2f21725d8148ee93&units=metric'));
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
      'https://api.openweathermap.org/data/2.5/onecall?lat=${latSelected}&lon=${lngSelected}&exclude=minutely&appid=b67e3a6f41956f3d2f21725d8148ee93&units=metric'));
  if (response.statusCode == 200) {
    return OneCallModel.fromJson(jsonDecode(response.body)).hourly;
  } else {
    throw Exception('Failed to load planets');
  }
}
