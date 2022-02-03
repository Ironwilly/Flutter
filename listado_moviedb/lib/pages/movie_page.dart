import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:listado_moviedb/models/popular.dart';
import 'package:listado_moviedb/models/upcoming.dart';
import 'package:http/http.dart' as http;

class MoviePage extends StatefulWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  _MovieState createState() => _MovieState();
}

class _MovieState extends State<MoviePage> {
  final _formKey = GlobalKey<FormState>();
  late Future<List<Results>> items;
  late Future<List<Results2>> items2;

  @override
  void initState() {
    items = fetchUpcoming();
    items2 = fetchPopular();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
        body: Container(
            child: ListView(shrinkWrap: true, children: <Widget>[
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(
              children: [
                Image.asset(
                  "assets/images/emoji.png",
                  scale: 35,
                ),
                const Text("      Erik Howel"),
                Container(
                  margin: const EdgeInsets.only(left: 200),
                  child: IconButton(
                      icon: const Icon(Icons.connected_tv), onPressed: () {}),
                )
              ],
            ),
            const SizedBox(
              width: 200,
              height: 100,
              child: Text(
                'Movie, Series, TV Shows...',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              children: [
                Form(
                  key: _formKey,
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 200,
                        height: 40,
                        margin: const EdgeInsets.only(top: 50),
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
                        margin: const EdgeInsets.only(top: 50, left: 110),
                        child: IconButton(
                            icon: const Icon(Icons.tune_outlined),
                            onPressed: () {}),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: SizedBox(
                width: 380,
                height: 210,
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
            ),
            Container(
              margin: EdgeInsets.only(top: 1),
              child: SizedBox(
                width: 380,
                height: 250,
                child: FutureBuilder<List<Results2>>(
                    future: items2,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return _popularList(snapshot.data!);
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }

                      return const CircularProgressIndicator();
                    }),
              ),
            )
          ])
        ])));
  }

  Future<List<Results>> fetchUpcoming() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/upcoming?api_key=75a43a37837f9668ea1aed215a226522&language=en-US&page=1'));
    if (response.statusCode == 200) {
      return Upcoming.fromJson(jsonDecode(response.body)).results;
    } else {
      throw Exception('Failed to load movie');
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
    return Flexible(
        child: Container(
      child: Column(children: [
        Image.network(
          'https://image.tmdb.org/t/p/w200${results.posterPath}',
          scale: 2,
        ),
        Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: 100,
              child: Text(results.title,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.fade,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
            ))
      ]),
    ));
  }

  Future<List<Results2>> fetchPopular() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=75a43a37837f9668ea1aed215a226522&language=en-US&page=1'));
    if (response.statusCode == 200) {
      return Popular.fromJson(jsonDecode(response.body)).results2;
    } else {
      throw Exception('Failed to load movie');
    }
  }

  Widget _popularList(List<Results2> popularList) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: popularList.length,
      itemBuilder: (context, index) {
        return _popularItem(popularList.elementAt(index));
      },
    );
  }

  Widget _popularItem(Results2 results2) {
    return Flexible(
        child: Container(
      child: Column(children: [
        Image.network(
          'https://image.tmdb.org/t/p/w200${results2.posterPath}',
          scale: 2,
        ),
        Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: 100,
              child: Text(results2.title,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.fade,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
            ))
      ]),
    ));
  }
}
