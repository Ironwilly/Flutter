import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(235, 239, 244, 1),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'MiarmaApp',
              style: TextStyle(
                  fontFamily: 'miarma',
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 90.0),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    width: 300,
                    margin: EdgeInsets.only(top: 50),
                    color: Colors.white,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter Username',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    width: 300,
                    margin: EdgeInsets.only(top: 20, bottom: 30),
                    color: Colors.white,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        hintText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 170),
                    child: Text(
                      'Recovery password',
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 50,
                    margin: EdgeInsets.only(top: 20, bottom: 40),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        elevation: 0,
                        primary: Color.fromRGBO(244, 129, 105, 1),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        }
                      },
                      child: const Text('Sign in'),
                    ),
                  ),
                ],
              ),
            ),
            Text('----- Or continue with -----'),
            Container(
              margin: EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              width: 4.0),
                          color: Color.fromRGBO(235, 239, 244, 1)),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/google.png',
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              width: 4.0),
                          color: Color.fromRGBO(235, 239, 244, 1)),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/apple.png',
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              width: 4.0),
                          color: Color.fromRGBO(235, 239, 244, 1)),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/facebook.png',
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50),
              child: RichText(
                  text: const TextSpan(children: <TextSpan>[
                TextSpan(
                    text: 'Not a member?',
                    style: TextStyle(color: Colors.black)),
                TextSpan(
                    text: ' Register now',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue)),
              ])),
            )
          ],
        ));
  }
}
