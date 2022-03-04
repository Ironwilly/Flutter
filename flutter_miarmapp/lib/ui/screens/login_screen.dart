import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miarmapp/bloc/login_bloc/bloc/login_bloc.dart';
import 'package:flutter_miarmapp/models/login_dto.dart';
import 'package:flutter_miarmapp/models/login_response.dart';
import 'package:flutter_miarmapp/repository/auth_repository/auth_repository.dart';
import 'package:flutter_miarmapp/repository/auth_repository/auth_repository_impl.dart';
import 'package:flutter_miarmapp/repository/constants.dart';
import 'package:flutter_miarmapp/ui/screens/home_screen.dart';
import 'package:flutter_miarmapp/ui/screens/menu_screen.dart';
import 'package:flutter_miarmapp/ui/screens/register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthRepository authRepository;

  final _formKey = GlobalKey<FormState>();
  late Future<SharedPreferences> _sharedPreferences;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    authRepository = AuthRepositoryImpl();
    _sharedPreferences = SharedPreferences.getInstance();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return LoginBloc(authRepository);
        },
        child: _createBody(context));
  }

  _createBody(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
            Container(
                color: Color.fromARGB(255, 255, 255, 255),
                padding: const EdgeInsets.all(50),
                child: BlocConsumer<LoginBloc, LoginState>(
                    listenWhen: (context, state) {
                  return state is LoginSuccessState || state is LoginErrorState;
                }, listener: (context, state) async {
                  if (state is LoginSuccessState) {
                    _loginSuccess(context, state.loginResponse);

                    // Navigator.push(
                    // context,
                    //MaterialPageRoute(
                    //  builder: (context) => const HomeScreen()),
                    //);
                  } else if (state is LoginErrorState) {
                    _showSnackbar(context, state.message);
                  }
                }, buildWhen: (context, state) {
                  return state is LoginInitialState ||
                      state is LoginLoadingState;
                }, builder: (ctx, state) {
                  if (state is LoginInitialState) {
                    return buildForm(ctx);
                  } else if (state is LoginLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return buildForm(ctx);
                  }
                })),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 90.0),
            ),
            Container(
              margin: EdgeInsets.only(top: 50),
              child: RichText(
                  text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: 'Not a member?',
                    style: TextStyle(color: Colors.black)),
                TextSpan(
                  text: ' Register now',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen()));
                    },
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ])),
            )
          ],
        ));
  }

  Future<void> _loginSuccess(
      BuildContext context, LoginResponse loginResponse) async {
    _sharedPreferences.then((SharedPreferences sharedPreferences) {
      sharedPreferences.setString('token', loginResponse.token);
      sharedPreferences.setString('avatar', loginResponse.avatar);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MenuScreen()),
      );
    });
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Container(
            width: 300,
            margin: EdgeInsets.only(top: 50),
            color: Colors.white,
            child: TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Enter Email',
                border: OutlineInputBorder(),
              ),
              onSaved: (String? value) {},
              validator: (String? value) {
                return (value == null || !value.contains('@'))
                    ? 'Do not use the @ char.'
                    : null;
              },
            ),
          ),
          Container(
            width: 300,
            margin: EdgeInsets.only(top: 20, bottom: 30),
            color: Colors.white,
            child: TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                fillColor: Colors.white,
                hintText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              onSaved: (String? value) {},
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
          GestureDetector(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                final loginDto = LoginDto(
                    email: emailController.text,
                    password: passwordController.text);
                BlocProvider.of<LoginBloc>(context).add(DoLoginEvent(loginDto));
              }
            },
            child: Container(
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
                    final loginDto = LoginDto(
                        email: emailController.text,
                        password: passwordController.text);
                    BlocProvider.of<LoginBloc>(context)
                        .add(DoLoginEvent(loginDto));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: const Text('Sign in'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
