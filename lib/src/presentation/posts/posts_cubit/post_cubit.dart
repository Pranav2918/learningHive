import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hivedemo/src/data/posts/post_model.dart';
import 'package:hivedemo/src/domain/api_service.dart';
import 'package:hivedemo/src/presentation/posts/posts_cubit/post_states.dart';

class PostListCubit extends Cubit<PostListStates> {
  final ApiService apiService;

  PostListCubit({required this.apiService}) : super(PostListStateInitial());

  void fetchPost() async {
    emit(PostListStateLoading());
    try {
      List<Posts> postList = await apiService.fetchPosts();
      emit(PostListStateSuccess(postList: postList));
    } catch (e) {
      emit(PostListStateFailed(errorMessage: "Something went wrong!"));
    }
  }
}
