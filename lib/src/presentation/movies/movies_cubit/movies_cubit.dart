import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hivedemo/src/data/movies/movie_model.dart';
import 'package:hivedemo/src/domain/api_service.dart';
import 'package:hivedemo/src/presentation/movies/movies_cubit/movies_states.dart';

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