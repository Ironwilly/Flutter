import 'package:dise_login_2/style.dart';
import 'package:flutter/material.dart';

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
      theme: ThemeData(backgroundColor: Colors.red),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        margin: EdgeInsets.only(top: 250.00, bottom: 240, left: 10, right: 10),
        elevation: 4,
        child: Center(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [],
              ),
              Container(
                padding: EdgeInsets.only(top: 10, left: 25, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("El más barato,Buena puntuación",
                        style: DamStyle.textTitleCustom(
                            DamStyle.colorTextBarato, DamStyle.textSizeSmall)),
                    Text(
                      "45 ofertas",
                      style: DamStyle.textTitleCustom(
                          DamStyle.colorDescripCitroen, DamStyle.textSizeSmall),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20, bottom: 15),
                child: Image.asset(
                  'assets/images/c1.png',
                  scale: 3,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Mini",
                        style: DamStyle.textTitleCustom(
                            DamStyle.colorTextMini, DamStyle.textSizeBig)),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 5, left: 25, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("2-3 puertas · Citroen C1 Diesel o similar",
                        style: DamStyle.textTitleCustom(
                            DamStyle.colorDescripCitroen,
                            DamStyle.textSizeSmall)),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 120),
                padding: EdgeInsets.only(left: 15, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      "assets/images/palanca.png",
                      scale: 30,
                    ),
                    Text("Man.",
                        style: DamStyle.textTitleCustom(
                            DamStyle.colorTextMini, DamStyle.textSizeSmall)),
                    Image.asset(
                      "assets/images/frio.png",
                      scale: 30,
                    ),
                    Text("A/A"),
                    Image.asset(
                      "assets/images/person.png",
                      scale: 60,
                    ),
                    Text("4"),
                    Image.asset(
                      "assets/images/maleta.png",
                      scale: 50,
                    ),
                    Text("1")
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black12),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.only(left: 25, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("\$35",
                        style: DamStyle.textTitleCustom(
                            DamStyle.colorSeleccionar,
                            DamStyle.textSizeSeleccionar)),
                    Text(
                      "SELECCIONAR",
                      style: DamStyle.textTitleCustom(DamStyle.colorSeleccionar,
                          DamStyle.textSizeSeleccionar),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
