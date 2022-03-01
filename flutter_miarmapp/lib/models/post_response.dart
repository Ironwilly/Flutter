class Post {
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
