import 'package:built_collection/built_collection.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/serializer.dart';
import 'package:jsonserialization/models/news.dart';

part 'serializers.g.dart';

@SerializersFor(const[
  News,
])
final Serializers serializers = 
(_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();


