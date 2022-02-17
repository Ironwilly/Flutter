import 'package:flutter/material.dart';
import 'package:flutter_miarmapp/widgets/home_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          FlatButton(
              onPressed: () {},
              child: Text(
                'Next',
                style: Theme.of(context)
                    .primaryTextTheme
                    .subtitle1
                    ?.copyWith(color: Colors.blue),
              ))
        ],
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              color: Colors.grey,
              child: Stack(
                children: [
                  Positioned.fill(
                      child: Image.asset(
                    'assets/images/avatar.jpeg',
                    fit: BoxFit.cover,
                  )),
                  Positioned(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Container(
                            child: IconButton(
                                icon: Icon(
                                  Icons.zoom_out_map,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                onPressed: () {}),
                          ),
                          Expanded(child: Container()),
                          Container(
                            child: IconButton(
                                icon: Icon(Icons.camera,
                                    size: 16, color: Colors.white),
                                onPressed: () {}),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Container(
                            child: IconButton(
                                icon: Icon(Icons.format_shapes,
                                    size: 16, color: Colors.white),
                                onPressed: () {}),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Container(
                            child: IconButton(
                                icon: Icon(Icons.content_copy,
                                    size: 16, color: Colors.white),
                                onPressed: () {}),
                          )
                        ],
                      ),
                    ),
                    bottom: 0,
                    left: 0,
                    right: 0,
                  )
                ],
              ),
            ),
          ),
          Expanded(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2),
                  itemBuilder: (context, index) {
                    return InkResponse(
                      onTap: () {
//                      Navigator.of(context).push(
//                          MaterialPageRoute(builder: (context) => ExplorePage())
//                      );
                      },
                    );
                  }))
        ],
      ),
    );
  }
}
