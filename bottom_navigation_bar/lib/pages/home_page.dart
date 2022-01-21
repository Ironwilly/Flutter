import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navegación con rutas nombradas'),
      ),
      body: Center(
        child: Column(children: [
          ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/meme'),
              child: const Text('Ir a memes')),
        ]),
      ),
    );
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
