import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:listado_moviedb/models/upcoming.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  _MovieState createState() => _MovieState();
}

class _MovieState extends State<MoviePage> {
  final _formKey = GlobalKey<FormState>();
  late Future<List<Results>> items;

  @override
  void initState() {
    items = fetchUpcoming();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        body: /*Container(
        margin: EdgeInsets.only(left: 10, bottom: 400),
        width: 400,
        height: 800,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  child: Image.asset(
                    "assets/images/emoji.png",
                    scale: 35,
                  ),
                ),
                Container(
                  child: Text("      Erik Howel"),
                ),
                Container(
                  margin: EdgeInsets.only(left: 200),
                  child: IconButton(
                      icon: Icon(Icons.connected_tv), onPressed: () {}),
                )
              ],
            ),
            Container(
              width: 200,
              child: Text(
                'Movie, Series, TV Shows...',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              child: Row(
                children: [
                  Form(
                    key: _formKey,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 200,
                          height: 40,
                          margin: EdgeInsets.only(top: 50),
                          color: Colors.white,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              hintText: ('Search'),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 50, left: 110),
                          child: IconButton(
                              icon: Icon(Icons.tune_outlined),
                              onPressed: () {}),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            */
            Container(
          child: Row(
            children: [
              SizedBox(
                height: 250,
                child: FutureBuilder<List<Results>>(
                    future: items,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return _upcomingList(snapshot.data!);
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }

                      return const CircularProgressIndicator();
                    }),
              ),
            ],
          ),
        ));

    /*
      ),
    );
    */
  }

  Future<List<Results>> fetchUpcoming() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/upcoming?api_key=75a43a37837f9668ea1aed215a226522&language=en-US&page=1'));
    if (response.statusCode == 200) {
      return Upcoming.fromJson(jsonDecode(response.body)).results;
    } else {
      throw Exception('Failed to load people');
    }
  }

  Widget _upcomingList(List<Results> upcomingList) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: upcomingList.length,
      itemBuilder: (context, index) {
        return _upcomingItem(upcomingList.elementAt(index));
      },
    );
  }

  Widget _upcomingItem(Results results) {
    return Card(
        child: Column(children: [
      Container(
          child: CircleAvatar(
        backgroundImage: NetworkImage(
          'https://image.tmdb.org/t/p/w200${results.posterPath}.jpg',
        ),
      )),
      Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(results.title,
              style:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)))
    ]));
  }
}
