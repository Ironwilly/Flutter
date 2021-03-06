import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miarmapp/models/post_response.dart';
import 'package:flutter_miarmapp/repository/post_repository/post_repository.dart';
part 'post_event.dart';
part 'post_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostRepository postRepository;

  PostsBloc(this.postRepository) : super(PostsInitial()) {
    on<FetchPostPublic>(_postsFetched);
  }

  void _postsFetched(FetchPostPublic event, Emitter<PostsState> emit) async {
    try {
      final posts = await postRepository.fetchPosts();
      emit(PostsFetched(posts));
      return;
    } on Exception catch (e) {
      emit(PostFetchError(e.toString()));
    }
  }
}
