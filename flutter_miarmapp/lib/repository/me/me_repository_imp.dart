import 'dart:convert';

import 'package:flutter_miarmapp/models/me_response.dart';
import 'package:flutter_miarmapp/repository/me/me_repository.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MeRepositoryImpl extends MeRepository {
  final Client _client = Client();

  @override
  Future<MeResponse> fetchMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await _client.get(Uri.parse('http://10.0.2.2:8080/me'),
        headers: {'Authorization': 'Bearer ${prefs.getString('token')}'});
    if (response.statusCode == 200) {
      return MeResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
