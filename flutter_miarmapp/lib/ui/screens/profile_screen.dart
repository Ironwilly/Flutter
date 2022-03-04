import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miarmapp/bloc/bloc/post_bloc.dart';
import 'package:flutter_miarmapp/bloc/me_bloc/bloc/me_bloc.dart';
import 'package:flutter_miarmapp/models/me_response.dart';
import 'package:flutter_miarmapp/models/post_response.dart';
import 'package:flutter_miarmapp/repository/me/me_repository.dart';
import 'package:flutter_miarmapp/repository/me/me_repository_imp.dart';
import 'package:flutter_miarmapp/repository/post_repository/post_repository.dart';
import 'package:flutter_miarmapp/repository/post_repository/post_repository_impl.dart';
import 'package:flutter_miarmapp/ui/screens/widgets/error_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late PostRepository postRepository;
  late MeRepository meRepository;

  @override
  void initState() {
    super.initState();
    postRepository = PostRepositoryImpl();
    meRepository = MeRepositoryImpl();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return MeBloc(meRepository)..add(const FetchMeEvent());
      },
      child: _createProfile(context),
    );
  }

  Widget _createProfile(BuildContext context) {
    return BlocBuilder<MeBloc, MeState>(
      builder: (context, state) {
        if (state is MeInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MeFetchedError) {
          return ErrorPage(
            message: state.message,
            retry: () {
              context.watch<MeBloc>().add(FetchMeEvent());
            },
          );
        } else if (state is MeFetched) {
          return _profile(context, state.meResponse);
        } else {
          return const Text('Not support');
        }
      },
    );
  }

  Widget _profile(BuildContext context, MeResponse meResponse) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            meResponse.nick,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          ),
          actions: const [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.menu,
                    size: 30,
                    color: Colors.black,
                  ),
                ))
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 12),
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(meResponse.avatar
                                  .toString()
                                  .replaceFirst('localhost', '10.0.2.2'))),
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  TextButton(
                                    onPressed: null,
                                    child: Text(
                                      meResponse.email.length.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                  Text("posts"),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      /*Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const FollowPage()));*/
                                    },
                                    child: Text(
                                      "Followers",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                  Text(
                                    "followers",
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        /*Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const FollowPage()));*/
                                      },
                                      child: Text("832",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black))),
                                  Text("following"),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(meResponse.nick.toString()),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          meResponse.nombre,
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    ],
                  ),
                  Container(
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      width: 320,
                      child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Edit Profile",
                            style: TextStyle(color: Colors.black),
                          )))

                  /* Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 120.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.white),
                        onPressed: () {},
                        child: const Text(
                          "Edit Profile",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),*/
                ],
              ),
              const Divider(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.table_chart_outlined)),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.person_search)),
                ],
              ),
              const SizedBox(
                width: 20,
              ),

              /*Image(  image: NetworkImage(user.publicaciones.elementAt(0).file.toString().replaceFirst('localhost', '10.0.2.2')),
                        
                        ),*/
              Flexible(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          color: Colors.white,
                          child: Image(
                            image: NetworkImage(meResponse.avatar
                                .toString()
                                .replaceFirst('localhost', '10.0.2.2')),
                            fit: BoxFit.cover,
                          ));
                    }),
              ),
              /*Container(
                width: 120,
                height: 150,
                child: Image(
                  image: AssetImage('assets/images/luismi.png'),
                  fit: BoxFit.contain,
                )),*/
              const SizedBox(
                width: 20,
              ),
            ],
          ),
        ));
  }
}

Widget _createPostProfile(BuildContext context) {
  return BlocBuilder<PostsBloc, PostsState>(
    builder: (context, state) {
      if (state is PostsInitial) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is PostFetchError) {
        return ErrorPage(
          message: state.message,
          retry: () {
            context.watch<PostsBloc>().add(const FetchPostPublic());
          },
        );
      } else if (state is PostsFetched) {
        return _createPostPublicViewProfile(context, state.posts);
      } else {
        return const Text('Not support');
      }
    },
  );
}

Widget _createPostPublicViewProfile(BuildContext context, List<Post> posts) {
  return ListView(children: <Widget>[
    Container(
      child: SizedBox(
        height: 100,
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return _createPostItemProfile(context, posts[index]);
          },
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          scrollDirection: Axis.vertical,
          separatorBuilder: (context, index) => const VerticalDivider(
            color: Colors.transparent,
            width: 6.0,
          ),
          itemCount: posts.length,
        ),
      ),
    ),
  ]);
}

Widget _createPostItemProfile(BuildContext context, Post post) {
  return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          post.userNick,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
        actions: const [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.menu,
                  size: 30,
                  color: Colors.black,
                ),
              ))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(post.avatar
                                .toString()
                                .replaceFirst('localhost', '10.0.2.2'))),
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              children: const [
                                TextButton(
                                  onPressed: null,
                                  child: Text(
                                    "3",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                                Text("Posts"),
                              ],
                            ),
                            Column(
                              children: const [
                                TextButton(
                                  onPressed: null,
                                  child: Text(
                                    "35",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                                Text(" Seguidores "),
                              ],
                            ),
                            Column(
                              children: const [
                                TextButton(
                                  onPressed: null,
                                  child: Text(
                                    "40",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                                Text(" Siguiendo"),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                                /*
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const FollowPage()));
                                  },
                                  child: Text(
                                    "1.174",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                                Text(
                                  "followers",
                                ),
                              ],
                              */
                                ),
                            const SizedBox(
                              width: 5,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              /*
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const FollowPage()));
                                    },
                                    child: Text("832",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black))),
                                Text("following"),
                              ],
                              */
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                ),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text("Miguel Campos"),
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text("miguelcampos@gmail.com"),
                    )
                  ],
                ),
                Container(
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border:
                          Border.all(color: Color.fromARGB(255, 0, 183, 255)),
                    ),
                    width: 320,
                    child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Edit Profile",
                          style: TextStyle(color: Colors.black),
                        )))
                /* Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 120.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.white),
                        onPressed: () {},
                        child: const Text(
                          "Edit Profile",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),*/
              ],
            ),
            const Divider(
              height: 10,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.table_chart_outlined)),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.person_search)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        width: 90,
                        height: 150,
                        child: const Image(
                          image: AssetImage("assets/images/avatar.jpeg"),
                          fit: BoxFit.contain,
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                        width: 90,
                        height: 150,
                        child: const Image(
                          image: AssetImage("assets/images/miguel.jpg"),
                          fit: BoxFit.contain,
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                        width: 90,
                        height: 150,
                        child: const Image(
                          image: AssetImage("assets/images/avatar.jpeg"),
                          fit: BoxFit.contain,
                        ))
                  ],
                )
              ],
            )
          ],
        ),
      ));
}
