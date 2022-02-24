part of 'post_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class FetchPostPublic extends PostsEvent {
  const FetchPostPublic();

  @override
  List<Object> get props => [];
}
