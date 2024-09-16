import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hivedemo/movie_model.dart';
import 'package:hivedemo/post_model.dart';

class ApiService {
  final Dio _dio = Dio();
  final Box<Posts> postsBox = Hive.box<Posts>('posts');
  final Box<Movies> moviesBox = Hive.box<Movies>('movies');

  Future<List<Posts>> fetchPosts() async {
    const url = 'https://jsonplaceholder.typicode.com/posts';
    try {
      var response = await _dio.get(url);
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        List<Posts> postData = data
            .map(
              (json) => Posts.fromJson(json),
            )
            .toList();
        print("Check posts ${postData[0].title}");
        await _cachePosts(postData);
        return postData;
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      print("Getting data from cache...");
      return _getCachedPosts();
    }
  }

  // Cache posts to Hive
  Future<void> _cachePosts(List<Posts> posts) async {
    await postsBox.clear(); // Clear existing data
    for (var post in posts) {
      await postsBox.put(post.id, post); // Use post ID as the key
    }
  }

  // Get cached posts from Hive
  List<Posts> _getCachedPosts() {
    return postsBox.values.toList();
  }

  //MOVIE
  Future<List<Movies>> fetchMovies() async {

    String url = "https://api.themoviedb.org/3/movie/popular?api_key=e25f618ffbb51eedda1c85ced86fe649";
    try{
      var response = await _dio.get(url);
      if(response.statusCode == 200){
        MovieList movieList = MovieList.fromJson(response.data);
        _cacheMovies(movieList.movies);
       return movieList.movies;
      } else {
        throw Exception('Failed to load posts');
      }
    }catch (e){
      print("Getting data from cache...");
      return _getCachedMovies();
    }
  }


  Future<void> _cacheMovies(List<Movies> movies) async {
    await moviesBox.clear();
    for(var movie in movies){
      moviesBox.put(movie.id, movie);
    }
  }

  List<Movies> _getCachedMovies(){
    return moviesBox.values.toList();
  }
}
