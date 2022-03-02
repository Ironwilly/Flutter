import 'package:flutter_miarmapp/models/post_response.dart';
import 'package:flutter_miarmapp/repository/post_repository/post_repository.dart';
import 'package:http/http.dart';

import 'post_repository.dart';
import 'dart:convert';

class PostRepositoryImpl extends PostRepository {
  final Client _client = Client();

  @override
  Future<List<Post>> fetchPosts() async {
    final response = await _client
        .get(Uri.parse('http://10.0.2.2:8080/post/public'), headers: {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJhYzE4OTAwMS03ZjQ3LTE2MDAtODE3Zi00Nzg3ZmY2YzAwMDAiLCJpYXQiOjE2NDYyNTg5NzUsIm5vbWJyZSI6IldpbGx5IiwiYXBlbGxpZG9zIjoiZmVycmFyaSBmZXJyYXJpIiwicm9sZSI6IlVTRVIifQ.8zQWYx-CduLl8y42VEfqyVYoVOoxlWzfDtB21sxHZpsWsjmVOSEJWDojmErbzJC7'
    });
    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((e) => Post.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
