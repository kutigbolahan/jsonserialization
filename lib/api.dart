import 'dart:convert';
import 'dart:async';

import 'package:jsonserialization/models/news.dart';
import 'package:jsonserialization/models/serializers.dart';

import 'package:http/http.dart' as http;

const String newsUrl = 'https://www.reddit.com/r/popular/new.json?count=25';


//function getNews to pass back a list of post type
Future<List<Post>> getNews() async{
final response = await http.get(Uri.parse(newsUrl));

News news = serializers.deserializeWith(
  News.serializer, json.decode(response.body)
);
return news.data.children.map((Data data) => data.data).toList();
}
