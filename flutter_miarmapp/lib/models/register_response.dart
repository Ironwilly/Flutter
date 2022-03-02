class RegisterResponse {
  RegisterResponse({
    required this.id,
    required this.nombre,
    required this.email,
    required this.avatar,
    required this.fechNac,
    required this.nick,
    required this.isPublic,
  });
  late final String id;
  late final String nombre;
  late final String email;
  late final String avatar;
  late final String fechNac;
  late final String nick;
  late final bool isPublic;

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    email = json['email'];
    avatar = json['avatar'];
    fechNac = json['fechNac'];
    nick = json['nick'];
    isPublic = json['isPublic'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nombre'] = nombre;
    _data['email'] = email;
    _data['avatar'] = avatar;
    _data['fechNac'] = fechNac;
    _data['nick'] = nick;
    _data['isPublic'] = isPublic;
    return _data;
  }
}
