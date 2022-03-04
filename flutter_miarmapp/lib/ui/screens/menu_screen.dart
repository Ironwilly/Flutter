import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miarmapp/bloc/me_bloc/bloc/me_bloc.dart';
import 'package:flutter_miarmapp/models/me_response.dart';
import 'package:flutter_miarmapp/repository/me/me_repository.dart';
import 'package:flutter_miarmapp/ui/screens/home_screen.dart';
import 'package:flutter_miarmapp/ui/screens/profile_screen.dart';
import 'package:flutter_miarmapp/ui/screens/search_screen.dart';
import 'package:flutter_miarmapp/ui/screens/widgets/error_screen.dart';

import '../../repository/me/me_repository_imp.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _currentIndex = 0;

  late MeRepository meRepository = MeRepositoryImpl();

  List<Widget> pages = [
    const HomeScreen(),
    const SearchScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[_currentIndex], bottomNavigationBar: _buildBottomBar());
  }

  Widget _buildBottomBar() {
    return BlocProvider(
      create: (context) => MeBloc(meRepository)..add(const FetchMeEvent()),
      child: Container(
          decoration: BoxDecoration(
              border: const Border(
            top: BorderSide(
              color: Color(0xfff1f1f1),
              width: 1.0,
            ),
          )),
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: Icon(Icons.home,
                    color: _currentIndex == 0
                        ? Colors.black
                        : const Color(0xff999999)),
                onTap: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
              ),
              GestureDetector(
                child: Icon(Icons.search,
                    color: _currentIndex == 1
                        ? Colors.black
                        : const Color(0xff999999)),
                onTap: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                          color: _currentIndex == 2
                              ? Colors.black
                              : Colors.transparent,
                          width: 1)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: _createBottonBar(context),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget _createBottonBar(BuildContext context) {
    return BlocBuilder<MeBloc, MeState>(
      builder: (context, state) {
        if (state is MeInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MeFetchedError) {
          return ErrorPage(
            message: state.message,
            retry: () {
              context.watch<MeBloc>().add(const FetchMeEvent());
            },
          );
        } else if (state is MeFetched) {
          return _createBottonBarView(context, state.meResponse);
        } else {
          return const Text('Not support');
        }
      },
    );
  }

  Widget _createBottonBarView(BuildContext context, MeResponse meResponse) {
    final width = MediaQuery.of(context).size.width / 2.6;

    return CircleAvatar(
        child: Container(
      width: 35.0,
      height: 35.0,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(meResponse.avatar
                  .toString()
                  .replaceFirst('localhost', '10.0.2.2')))),
    ));
  }
}
