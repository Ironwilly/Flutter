import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:starwars/models/planets_response.dart';
import 'package:http/http.dart' as http;
import 'models/people.dart';

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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: ''),
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
  late Future<List<Person>> items;
  late Future<List<Planets>> items2;

  @override
  void initState() {
    items = fetchPeople();
    items2 = fetchPlanets();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("H"),
      ),
      body: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Card(
                child: SizedBox(
                  height: 250,
                  child: FutureBuilder<List<Person>>(
                      future: items,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return _personList(snapshot.data!);
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }

                        return const CircularProgressIndicator();
                      }),
                ),
              ),
            ),
            Container(
              child: Card(
                child: SizedBox(
                  height: 250,
                  child: FutureBuilder<List<Planets>>(
                      future: items2,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return _planetList(snapshot.data!);
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }

                        return const CircularProgressIndicator();
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Person>> fetchPeople() async {
    final response = await http.get(Uri.parse('https://swapi.dev/api/people'));
    if (response.statusCode == 200) {
      return People.fromJson(jsonDecode(response.body)).results;
    } else {
      throw Exception('Failed to load people');
    }
  }

  Widget _personList(List<Person> personList) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: personList.length,
      itemBuilder: (context, index) {
        return _personItem(personList.elementAt(index), index);
      },
    );
  }

  Widget _personItem(Person person, int index) {
    return Card(
        child: Column(children: [
      Container(
          child: CircleAvatar(
        backgroundImage: NetworkImage(
          'https://starwars-visualguide.com/assets/img/characters/${index + 1}.jpg',
        ),
        radius: 100,
      )),
      Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(person.name,
              style:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)))
    ]));
  }

  Future<List<Planets>> fetchPlanets() async {
    final response = await http.get(Uri.parse('https://swapi.dev/api/planets'));
    if (response.statusCode == 200) {
      return PlanetResponse.fromJson(jsonDecode(response.body)).results;
    } else {
      throw Exception('Failed to load people');
    }
  }

  Widget _planetList(List<Planets> planetList) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: planetList.length,
      itemBuilder: (context, index) {
        return _planetItem(planetList.elementAt(index), index);
      },
    );
  }

  Widget _planetItem(Planets planets, int index) {
    return Card(
        child: Column(children: [
      Container(
          child: CircleAvatar(
        backgroundImage: NetworkImage(
          'https://starwars-visualguide.com/assets/img/planets/${index + 1}.jpg',
        ),
        radius: 100,
      )),
      Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(planets.name,
              style:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)))
    ]));
  }
}
