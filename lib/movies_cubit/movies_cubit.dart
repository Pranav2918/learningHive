import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hivedemo/api_service.dart';
import 'package:hivedemo/movie_model.dart';
import 'package:hivedemo/movies_cubit/movies_states.dart';

class MovieCubit extends Cubit<MoviesStates> {
  final ApiService apiService;

  MovieCubit({required this.apiService}) : super(MovieListInitial());

  void fetchMovies() async {
    emit(MovieListLoading());
    try{
      List<Movies> movies = await apiService.fetchMovies();
      emit(MovieListLoaded(movies: movies));
    }catch (e){
      emit(MovieListFailed(errorMessage: "Something went wrong"));
    }
  }
}