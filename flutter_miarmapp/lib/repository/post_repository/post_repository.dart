abstract class PostRepository {
  Future<List<Publicacion>> fetchPublicacion(String type);
}
