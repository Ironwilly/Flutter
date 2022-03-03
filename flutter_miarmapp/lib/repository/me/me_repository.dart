import 'package:flutter_miarmapp/models/me_response.dart';

abstract class MeRepository {
  Future<MeResponse> fetchMe();
}
