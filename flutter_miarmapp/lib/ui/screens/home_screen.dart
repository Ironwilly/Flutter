import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miarmapp/bloc/bloc/post_bloc.dart';
import 'package:flutter_miarmapp/models/post_response.dart';
import 'package:flutter_miarmapp/models/user_response.dart';
import 'package:flutter_miarmapp/repository/post_repository/post_repository.dart';
import 'package:flutter_miarmapp/repository/post_repository/post_repository_impl.dart';
import 'package:flutter_miarmapp/ui/screens/widgets/error_screen.dart';
import 'package:flutter_miarmapp/widgets/home_app_bar.dart';
import 'package:http/http.dart';

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
            ],
          ),
          body: _createPost(context)),
    );
  }

  Widget _createPost(BuildContext context) {
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
          return _createPostPublicView(context, state.posts);
        } else {
          return const Text('Not support');
        }
      },
    );
  }

  Widget _createPostPublicView(BuildContext context, List<Post> posts) {
    final contentHeight = 12.0 * (MediaQuery.of(context).size.width / 2.7) / 3;
    return ListView(children: <Widget>[
      Container(
        child: SizedBox(
          height: contentHeight,
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return _createPostItem(context, posts[index]);
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

  Widget _createPostItem(BuildContext context, Post post) {
    final width = MediaQuery.of(context).size.width / 2.6;
    return Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          Container(
            width: 380,
            decoration: BoxDecoration(
              color: Colors.white,
              // border:
              //  Border(top: BorderSide(color: Colors.blue.withOpacity(.3))
              //)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Image.network(
                          'http://10.0.2.2' + post.avatar.substring(16),
                          width: 30,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text(
                      post.userNick,
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
              height: 390,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        post.imagen.replaceAll(
                            'http://localhost:8080', 'http://10.0.2.2:8080'),
                      ),
                      fit: BoxFit.cover))),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: const <Widget>[
                    Icon(Icons.favorite_border, size: 25),
                    SizedBox(
                      width: 12,
                    ),
                    Icon(Icons.comment_sharp, size: 25),
                    SizedBox(
                      width: 12,
                    ),
                    Icon(Icons.send, size: 25),
                  ],
                ),
                const Icon(Icons.bookmark_border, size: 25)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              post.descripcion,
              style:
                  TextStyle(fontSize: 12, color: Colors.black.withOpacity(.7)),
            ),
          ),
          Divider(
            thickness: 2,
          ),
        ]));
  }
}
