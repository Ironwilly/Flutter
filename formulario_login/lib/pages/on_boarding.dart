import 'package:flutter/material.dart';
import 'package:formulario_login/pages/login.dart';
import 'package:formulario_login/pages/registrer.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(210, 210, 210, 1),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 62.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(38.0),
                child: Image.asset(
                  "assets/images/pantalla1.jpg",
                  scale: 2,
                  width: 350.0,
                  height: 350.0,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40.0, left: 90, right: 90),
              child: Text(
                "Discover your Dream job Here",
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin:
                  EdgeInsets.only(top: 30.0, left: 70, right: 70, bottom: 50.0),
              child: Text(
                "Explore all the most exiting job roles based on your interest And study major",
                textAlign: TextAlign.center,
                style: TextStyle(color: Color.fromRGBO(15, 15, 15, 0.4)),
              ),
            ),
            Container(
              width: 300,
              height: 60,
              child: Stack(
                children: [
                  Positioned(
                      right: 10,
                      child: SizedBox(
                        width: 165,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            elevation: 0,
                            primary: Colors.grey,
                          ),
                          child: Text('Sign In',
                              style:
                                  TextStyle(color: Color.fromRGBO(0, 0, 0, 1))),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                            print('Pressed');
                          },
                        ),
                      )),
                  Positioned(
                      left: 10,
                      child: SizedBox(
                        width: 150,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            elevation: 0,
                            primary: Colors.white,
                          ),
                          child: Text(
                            'Registrer',
                            style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Registrer()),
                            );
                            print('Pressed');
                          },
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
