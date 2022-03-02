class RegisterDto {
  RegisterDto({
    required this.nombre,
    required this.apellidos,
    required this.direccion,
    required this.email,
    required this.telefono,
    required this.nick,
    required this.fechNac,
    required this.isPublic,
    required this.password,
    required this.password2,
  });
  late final String nombre;
  late final String apellidos;
  late final String direccion;
  late final String email;
  late final String telefono;
  late final String nick;
  late final String fechNac;
  late final bool isPublic;
  late final String password;
  late final String password2;

  RegisterDto.fromJson(Map<String, dynamic> json) {
    nombre = json['nombre'];
    apellidos = json['apellidos'];
    direccion = json['direccion'];
    email = json['email'];
    telefono = json['telefono'];
    nick = json['nick'];
    fechNac = json['fechNac'];
    isPublic = json['isPublic'];
    password = json['password'];
    password2 = json['password2'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nombre'] = nombre;
    _data['apellidos'] = apellidos;
    _data['direccion'] = direccion;
    _data['email'] = email;
    _data['telefono'] = telefono;
    _data['nick'] = nick;
    _data['fechNac'] = fechNac;
    _data['isPublic'] = isPublic;
    _data['password'] = password;
    _data['password2'] = password2;
    return _data;
  }
}
