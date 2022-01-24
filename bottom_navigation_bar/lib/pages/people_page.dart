import 'dart:convert';

import 'package:bottom_navigation_bar/models/starwars_People_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PeoplePage extends StatefulWidget {
  const PeoplePage({
    Key? key,
  }) : super(key: key);

  @override
  State<PeoplePage> createState() => _peoplePageState();
}

class _peoplePageState extends State<PeoplePage> {
  late Future<List<People>> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('People'),
      ),
      body: Row(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(bottom: 600),
              child: ElevatedButton(
                // Within the SecondScreen widget
                onPressed: () {
                  // Navigate back to the first screen by popping the current route
                  // off the stack.
                  Navigator.pop(context);
                },
                child: const Text('Go back!'),
              ),
            ),
          ),
          Center(
            child: FutureBuilder<List<People>>(builder: (context, snapshot) {
              if (snapshot.hasData) {
                return _peopleList(snapshot.data!);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return const CircularProgressIndicator();
            }),
          )
        ],
      ),
    );
  }
}

Future<List<People>> fetchPeople() async {
  final response = await http.get(Uri.parse('https://swapi.dev/api/people'));
  if (response.statusCode == 200) {
    return StarResponse.fromJson(jsonDecode(response.body)).results;
  } else {
    throw Exception('Failed to load people');
  }
}

Widget _peopleList(List<People> peopleList) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: peopleList.length,
    itemBuilder: (context, index) {
      return _peopleItem(peopleList.elementAt(index), index);
    },
  );
}

Widget _peopleItem(People people, int index) {
  return Padding(
    padding: const EdgeInsets.all(9),
    child: Container(
      color: const Color.fromRGBO(1, 1, 1, 0),
      child: Padding(
        padding: const EdgeInsets.all(9),
        child: SizedBox(
          width: 150,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  people.name,
                  style: const TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.white),
                ),
              ),
              Image.network(
                "https://starwars-visualguide.com/assets/img/characters/${index + 1}.jpg",
                width: 90,
              )
            ],
          ),
        ),
      ),
    ),
  );
}
