class LoginResponse {
  LoginResponse({
    required this.email,
    required this.nick,
    required this.nombre,
    required this.fechNac,
    required this.apellidos,
    required this.avatar,
    required this.token,
  });
  late final String email;
  late final String nick;
  late final String nombre;
  late final String fechNac;
  late final String apellidos;
  late final String avatar;
  late final String token;

  LoginResponse.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    nick = json['nick'];
    nombre = json['nombre'];
    fechNac = json['fechNac'];
    apellidos = json['apellidos'];
    avatar = json['avatar'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['nick'] = nick;
    _data['nombre'] = nombre;
    _data['fechNac'] = fechNac;
    _data['apellidos'] = apellidos;
    _data['avatar'] = avatar;
    _data['token'] = token;
    return _data;
  }
}
