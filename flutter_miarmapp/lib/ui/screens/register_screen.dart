import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late String _dateCount;
  late String _range;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              margin: const EdgeInsets.only(top: 60),
              child: const Text(
                'Miarmapp',
                style: TextStyle(
                    fontFamily: 'miarma',
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )),
          Container(
              child: const Text(
            'Registrate para ver fotos y videos de tus amigos.',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          )),
          Container(
            height: 400,
            child: ListView(
                padding: const EdgeInsets.only(left: 30, right: 30),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    width: 300,
                    height: 40,
                    margin: const EdgeInsets.only(top: 50),
                    color: Colors.white,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter Name',
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
                    height: 40,
                    margin: const EdgeInsets.only(top: 50),
                    color: Colors.white,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter Nick',
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
                    height: 40,
                    margin: const EdgeInsets.only(top: 50),
                    color: Colors.white,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter Surname',
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
                    height: 40,
                    margin: const EdgeInsets.only(top: 50),
                    color: Colors.white,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter Adress',
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
                    height: 40,
                    margin: const EdgeInsets.only(top: 50),
                    color: Colors.white,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter Phone',
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
                    height: 40,
                    margin: const EdgeInsets.only(top: 50),
                    color: Colors.white,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter Date of birth',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 40,
                    margin: const EdgeInsets.only(top: 50),
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
                    width: 300,
                    height: 40,
                    margin: EdgeInsets.only(top: 50),
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
                    height: 40,
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
                      child: const Text('Sign up'),
                    ),
                  ),
                ]),
          ),
          Text('----- Or continue with -----'),
          Container(
            width: 450,
            height: 80,
            margin: EdgeInsets.only(top: 15),
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
        ]));
  }

  @override
  void initState() {
    _dateCount = '';
    _range = '';
    super.initState();
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range =
            DateFormat('dd/MM/yyyy').format(args.value.startDate).toString() +
                ' - ' +
                DateFormat('dd/MM/yyyy')
                    .format(args.value.endDate ?? args.value.startDate)
                    .toString();
      } else if (args.value is DateTime) {
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      }
    });
  }
}
