import 'package:hivedemo/src/data/posts/post_model.dart';

class PostListStates {}

class PostListStateInitial extends PostListStates {}

class PostListStateLoading extends PostListStates {}

class PostListStateFailed extends PostListStates {
  final String errorMessage;

  PostListStateFailed({required this.errorMessage});
}

class PostListStateSuccess extends PostListStates {
  final List<Posts> postList;

  PostListStateSuccess({required this.postList});
}
