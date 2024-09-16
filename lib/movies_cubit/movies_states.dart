import 'package:hivedemo/movie_model.dart';

class MoviesStates {}

class MovieListInitial extends MoviesStates {}

class MovieListLoading extends MoviesStates {}

class MovieListLoaded extends MoviesStates {
  final List<Movies> movies;

  MovieListLoaded({required this.movies});

}

class MovieListFailed extends MoviesStates {
  final String errorMessage;

  MovieListFailed({required this.errorMessage});
}