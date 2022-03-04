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
import 'package:http/http.dart';

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
        return PostsBloc(postRepository)..add(const FetchPostPublic());
      },
      child: _createProfile(context),
    );
  }

  Widget _createProfile(BuildContext context) {
    return BlocBuilder<PostsBloc, PostsState>(
      builder: (context, state) {
        if (state is PostsInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PostFetchError) {
          return ErrorPage(
            message: state.message,
            retry: () {
              context.watch<PostsBloc>().add(FetchPostPublic());
            },
          );
        } else if (state is PostsFetched) {
          return _profile(context, state.posts[0]);
        } else {
          return const Text('Not support');
        }
      },
    );
  }

  Widget _profile(BuildContext context, Post post) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            post.user.nick,
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
                              image: NetworkImage(post.user.avatar
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
                                      post.user.email.length.toString(),
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
                                    onPressed: () {},
                                    child: Text(
                                      "1",
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
                                      onPressed: () {},
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
                        child: Text(post.user.nick.toString()),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          post.user.nombre,
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
              Flexible(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    ),
                    //itemCount: post.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          color: Colors.white,
                          child: Image(
                            image: NetworkImage(post.imagen
                                .toString()
                                .replaceFirst('localhost', '10.0.2.2')),
                            fit: BoxFit.cover,
                          ));
                    }),
              ),
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
          post.user.nick,
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
                            image: NetworkImage(post.user.avatar
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
                            Column(),
                            const SizedBox(
                              width: 5,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              ],
            )
          ],
        ),
      ));
}
