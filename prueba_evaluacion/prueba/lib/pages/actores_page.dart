import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prueba_evaluacion/models/people.dart';
import 'package:http/http.dart' as http;

class ActoresPage extends StatefulWidget {
  const ActoresPage({Key? key}) : super(key: key);

  @override
  _ActoresPageState createState() => _ActoresPageState();
}

class _ActoresPageState extends State<ActoresPage> {
  late Future<List<Results>> items;

  @override
  void initState() {
    items = fetchPeople() as Future<List<Results>>;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: ListView(shrinkWrap: true, children: <Widget>[
      Container(
        child: Text('Best Iranian Actor and Actresses'),
      ),
      Container(
        child: Text('March 2020'),
      ),
      Container(
        decoration: const BoxDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              child: FutureBuilder<List<Results>>(
                  future: items,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return _personList(snapshot.data!);
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                  }),
            ),
          ],
        ),
      ),
    ])));
  }
}

Future<List<PopularPeopleResponse>> fetchPeople() async {
  final response = await http.get(Uri.parse(
      'https://api.themoviedb.org/3/person/popular?api_key=75a43a37837f9668ea1aed215a226522&language=en-US&page=1'));
  if (response.statusCode == 200) {
    return Results().fromJson(jsonDecode(response.body)).person;
  }

  Widget _personList(List<Results> popularPeopleResponse) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return _peopleItem(popularPeopleResponse.elementAt(index), index);
          }),
    );
  }

  Widget _peopleItem(Results results, int index) {
    return Flexible(
        child: Column(children: [
      Image.network(
          'https://api.themoviedb.org/3/person/popular?api_key=75a43a37837f9668ea1aed215a226522&language=en-US&page=1')
    ]));
  }
}
