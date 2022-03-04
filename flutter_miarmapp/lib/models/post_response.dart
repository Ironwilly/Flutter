/*class Post {
  Post({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.imagen,
    required this.isPublic,
    required this.userNick,
    required this.avatar,
  });
  late final int id;
  late final String titulo;
  late final String descripcion;
  late final String imagen;
  late final bool isPublic;
  late final String userNick;
  late final String avatar;

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titulo = json['titulo'];
    descripcion = json['descripcion'];
    imagen = json['imagen'];
    isPublic = json['isPublic'];
    userNick = json['userNick'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['titulo'] = titulo;
    _data['descripcion'] = descripcion;
    _data['imagen'] = imagen;
    _data['isPublic'] = isPublic;
    _data['userNick'] = userNick;
    _data['avatar'] = avatar;
    return _data;
  }
}
*/

class Post {
  Post({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.imagen,
    required this.isPublic,
    required this.user,
  });
  late final int id;
  late final String titulo;
  late final String descripcion;
  late final String imagen;
  late final bool isPublic;
  late final User user;

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titulo = json['titulo'];
    descripcion = json['descripcion'];
    imagen = json['imagen'];
    isPublic = json['isPublic'];
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['titulo'] = titulo;
    _data['descripcion'] = descripcion;
    _data['imagen'] = imagen;
    _data['isPublic'] = isPublic;
    _data['user'] = user.toJson();
    return _data;
  }
}

class User {
  User({
    required this.id,
    required this.nombre,
    required this.nick,
    required this.apellidos,
    required this.direccion,
    required this.email,
    required this.telefono,
    required this.avatar,
    required this.fechNaci,
    required this.password,
    required this.rol,
    required this.isPublic,
    required this.enabled,
    required this.accountNonExpired,
    required this.credentialsNonExpired,
    required this.authorities,
    required this.username,
    required this.accountNonLocked,
  });
  late final String id;
  late final String nombre;
  late final String nick;
  late final String apellidos;
  late final String direccion;
  late final String email;
  late final String telefono;
  late final String avatar;
  late final String fechNaci;
  late final String password;
  late final String rol;
  late final bool isPublic;
  late final bool enabled;
  late final bool accountNonExpired;
  late final bool credentialsNonExpired;
  late final List<Authorities> authorities;
  late final String username;
  late final bool accountNonLocked;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    nick = json['nick'];
    apellidos = json['apellidos'];
    direccion = json['direccion'];
    email = json['email'];
    telefono = json['telefono'];
    avatar = json['avatar'];
    fechNaci = json['fechNaci'];
    password = json['password'];
    rol = json['rol'];
    isPublic = json['isPublic'];
    enabled = json['enabled'];
    accountNonExpired = json['accountNonExpired'];
    credentialsNonExpired = json['credentialsNonExpired'];
    authorities = List.from(json['authorities'])
        .map((e) => Authorities.fromJson(e))
        .toList();
    username = json['username'];
    accountNonLocked = json['accountNonLocked'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nombre'] = nombre;
    _data['nick'] = nick;
    _data['apellidos'] = apellidos;
    _data['direccion'] = direccion;
    _data['email'] = email;
    _data['telefono'] = telefono;
    _data['avatar'] = avatar;
    _data['fechNaci'] = fechNaci;
    _data['password'] = password;
    _data['rol'] = rol;
    _data['isPublic'] = isPublic;
    _data['enabled'] = enabled;
    _data['accountNonExpired'] = accountNonExpired;
    _data['credentialsNonExpired'] = credentialsNonExpired;
    _data['authorities'] = authorities.map((e) => e.toJson()).toList();
    _data['username'] = username;
    _data['accountNonLocked'] = accountNonLocked;
    return _data;
  }
}

class Authorities {
  Authorities({
    required this.authority,
  });
  late final String authority;

  Authorities.fromJson(Map<String, dynamic> json) {
    authority = json['authority'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['authority'] = authority;
    return _data;
  }
}
