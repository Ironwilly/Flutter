import 'dart:convert';

import 'package:bottom_navigation_bar/models/meme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MemePage extends StatelessWidget {
  const MemePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memes'),
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
            child: SizedBox(
              height: 250,
              child: FutureBuilder<List<Data>>(builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return _personList(snapshot.data!);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                return const CircularProgressIndicator();
              }),
            ),
          )
        ],
      ),
    );
  }
}

Future<List<Data>> fetchPeople() async {
  final response = await http.get(Uri.parse('https://swapi.dev/api/people'));
  if (response.statusCode == 200) {
    return Data.fromJson(jsonDecode(response.body)).data;
  } else {
    throw Exception('Failed to load people');
  }
}

Widget _personList(List<Data> personList) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: personList.length,
    itemBuilder: (context, index) {
      return _personItem(personList.elementAt(index), index);
    },
  );
}

Widget _personItem(Data data, int index) {
  return Card(
      child: Column(children: [
    Container(
        child: CircleAvatar(
      backgroundImage: NetworkImage(
        'http://alpha-meme-maker.herokuapp.com/${index + 1}.jpg',
      ),
      radius: 100,
    )),
    Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(data.name,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)))
  ]));
}
