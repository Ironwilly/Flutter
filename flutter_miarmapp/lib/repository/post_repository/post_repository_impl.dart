import 'package:flutter_miarmapp/repository/post_repository/post_repository.dart';
import 'package:http/http.dart';

import 'post_repository.dart';
import 'dart:convert';

class PostRepositoryImpl extends PostRepository {
  final Client _client = Client();

  @override
  Future<List<Publicacion>> fetchPublicaciones(String type) async {
    final response = await _client
        .get(Uri.parse('http://10.0.2.2:8080/post/$type'), headers: {
      'Authorization':
          'Bearer  ********* AQUI TENEMOS QUE PONER EL TOKEN *******'
    });
    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((e) => Publicacion.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load publicaciones');
    }
  }
}
