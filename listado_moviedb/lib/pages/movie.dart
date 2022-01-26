import 'package:flutter/material.dart';

class Movie extends StatefulWidget {
  const Movie({Key? key}) : super(key: key);

  @override
  _MovieState createState() => _MovieState();
}

class _MovieState extends State<Movie> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: Container(
        margin: EdgeInsets.only(left: 10, bottom: 400),
        width: 400,
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
                              hintText: 'Search',
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
          ],
        ),
      ),
    );
  }
}
