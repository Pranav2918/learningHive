import 'package:hive/hive.dart';

part 'movie_model.g.dart';

@HiveType(typeId: 2)
class MovieList {
  @HiveField(0)
  final int page;
  @HiveField(1)
  final List<Movies> movies;

  MovieList({required this.page, required this.movies});

  factory MovieList.fromJson(Map<String, dynamic> json) => MovieList(
      page: json['page'] ?? 0,
      movies: json['results'] == null
          ? []
          : (json['results'] as List<dynamic>)
              .map(
                (e) => Movies.fromJson(e),
              )
              .toList());
}

@HiveType(typeId: 3)
class Movies {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String overview;
  @HiveField(2)
  final int id;

  Movies({required this.title, required this.overview, required this.id});

  factory Movies.fromJson(Map<String, dynamic> json) => Movies(
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      id: json['id'] ?? 0);
}
