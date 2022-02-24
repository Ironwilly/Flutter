import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miarmapp/bloc/bloc/post_bloc.dart';
import 'package:flutter_miarmapp/models/post_response.dart';
import 'package:flutter_miarmapp/repository/post_repository/post_repository.dart';
import 'package:flutter_miarmapp/repository/post_repository/post_repository_impl.dart';
import 'package:flutter_miarmapp/ui/screens/widgets/error_screen.dart';
import 'package:flutter_miarmapp/widgets/home_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PostRepository postRepository;

  @override
  void initState() {
    super.initState();
    postRepository = PostRepositoryImpl();
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
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(
                Icons.camera_alt,
                size: 20,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            title: const Text(
              "MiarmaApp",
              style: TextStyle(
                  fontFamily: 'miarma', fontSize: 40, color: Colors.black),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.live_tv,
                  size: 20,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
              /*
          IconButton(
            icon: const Icon(
              Icons.send,
              size: 20,
              color: Colors.black,
            ),

            
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ChatPage()));
            },
          ),
          */
            ],
          ),
          body: _createPost(context)),
    );
  }

  Widget post(String image, name) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.withOpacity(.3)))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar.jpeg'),
            ),
            title: Text(
              name,
              style: TextStyle(
                  color: Colors.black.withOpacity(.8),
                  fontWeight: FontWeight.w400,
                  fontSize: 21),
            ),
            trailing: const Icon(Icons.more_vert),
          ),
          Image.asset(
            image,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: const <Widget>[
                    Icon(Icons.favorite_border, size: 31),
                    SizedBox(
                      width: 12,
                    ),
                    Icon(Icons.comment_sharp, size: 31),
                    SizedBox(
                      width: 12,
                    ),
                    Icon(Icons.send, size: 31),
                  ],
                ),
                const Icon(Icons.bookmark_border, size: 31)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            child: Text(
              'liked by you and 385 others',
              style:
                  TextStyle(fontSize: 16, color: Colors.black.withOpacity(.8)),
            ),
          )
        ],
      ),
    );
  }

  Widget _createPost(BuildContext context) {
    return BlocBuilder<PostsBloc, PostsState>(
      builder: (context, state) {
        if (state is PostFetchError) {
          return ErrorPage(
            message: state.message,
            retry: () {
              context.watch<PostsBloc>().add(const FetchPostPublic());
            },
          );
        } else if (state is PostsFetched) {
          return _createPostPublicView(context, state.posts);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _createPostPublicView(BuildContext context, List<Post> posts) {
    final contentHeight = 4.0 * (MediaQuery.of(context).size.width / 2.4) / 3;
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 20.0, right: 16.0),
          height: 48.0,
          child: Row(
            children: [
              const Expanded(
                flex: 1,
                child: Text(
                  'Popular',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16.0,
                    fontFamily: 'Muli',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Icon(Icons.arrow_forward, color: Colors.red),
            ],
          ),
        ),
        SizedBox(
          height: contentHeight,
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return _createPostItem(context, posts[index]);
            },
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const VerticalDivider(
              color: Colors.transparent,
              width: 6.0,
            ),
            itemCount: posts.length,
          ),
        ),
      ],
    );
  }

  Widget _createPostItem(BuildContext context, Post post) {
    final width = MediaQuery.of(context).size.width / 2.6;
    return Container(
        child: ListView(children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(
                  Icons.arrow_right,
                  size: 43,
                ),
                Text(
                  'Watch All',
                  style: TextStyle(
                      color: Colors.black.withOpacity(.8),
                      fontWeight: FontWeight.w600,
                      fontSize: 19),
                ),
              ],
            ),
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.only(left: 15),
        height: 122,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(post.imagen.replaceAll(
                                    'http://localhost:8080',
                                    'http://10.0.2.2:8080')),
                                fit: BoxFit.cover)),
                      ),
                      Positioned(
                        bottom: 0,
                        right: -1,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white)),
                          child: const Icon(Icons.add, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Mi historia',
                    style: TextStyle(
                        color: Colors.black.withOpacity(.8),
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          ],
        ),
      )
    ]));
  }
}
