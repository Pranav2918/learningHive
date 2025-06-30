import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hivedemo/src/data/movies/movie_model.dart';
import 'package:hivedemo/src/data/posts/post_model.dart';
import 'package:hivedemo/src/domain/api_service.dart';
import 'package:hivedemo/src/presentation/posts/screens/post_screen.dart';
import 'package:hivedemo/src/presentation/movies/movies_cubit/movies_cubit.dart';
import 'package:hivedemo/src/presentation/posts/posts_cubit/post_cubit.dart';

void main() async {
  // Initialize hive
  await Hive.initFlutter();

  Hive.registerAdapter(PostsAdapter());
  Hive.registerAdapter(MovieListAdapter());
  Hive.registerAdapter(MoviesAdapter());
  // Opening the box
  await Hive.openBox<Posts>('posts');
  await Hive.openBox<Movies>('movies');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PostListCubit(apiService: ApiService()),
          ),
          BlocProvider(
            create: (context) => MovieCubit(apiService: ApiService()),
          )
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const PostScreen(),
        ));
  }
}
