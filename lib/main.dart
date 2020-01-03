import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jsonserialization/api.dart';
import 'package:jsonserialization/models/news.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> _posts = [];

  @override
  void initState() {
    super.initState();
    getNews().then((posts) {
      setState(() {
        _posts = posts;
      });
    });
  }

  List<Widget> buildListTiles() {
    return _posts
        .map((post) => ListTile(
              leading: CircleAvatar(
                child: Image.network(
                  '${!post.thumbnail.contains('.jpg') ? 'http://via.placeholder.com/300' : post.thumbnail}',
                  scale: 0.2,
                ),
              ),
              title: Text('Title: ${post.title} by ${post.author}' ),
              subtitle: Text(
                'News: ${post.subreddit} with ${post.ups} upvotes'
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.more_vert),
        title: Text('Top News'),
      ),
      body: RefreshIndicator(
        //allows us update our post
        onRefresh: () async {
          getNews().then((posts) {
            setState(() {
              _posts = posts;
            });
          });
        },
        child: AnimatedCrossFade(
          duration: Duration(microseconds: 300),
          firstChild: Center(
            child: CircularProgressIndicator(),
          ),
          secondChild: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
            children:  buildListTiles(),
            ),
          ),
          crossFadeState: _posts != null
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
        ),
      ),
    );
  }
}
