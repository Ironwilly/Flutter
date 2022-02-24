part of 'post_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {}

class PostsFetched extends PostsState {
  final List<Post> posts;

  const PostsFetched(this.posts);

  @override
  List<Object> get props => [posts];
}

class PostFetchError extends PostsState {
  final String message;
  const PostFetchError(this.message);

  @override
  List<Object> get props => [message];
}
