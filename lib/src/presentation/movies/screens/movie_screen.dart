import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hivedemo/src/presentation/movies/movies_cubit/movies_cubit.dart';
import 'package:hivedemo/src/presentation/movies/movies_cubit/movies_states.dart';
import 'package:hivedemo/src/data/movies/movie_model.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {

  @override
  void initState() {
    context.read<MovieCubit>().fetchMovies();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MOVIES"),
      ),
      body: BlocBuilder<MovieCubit, MoviesStates>(
        builder: (context, state) {
          if (state is MovieListLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MovieListFailed) {
            return Center(
              child: Text(state.errorMessage),
            );
          } else if (state is MovieListLoaded) {
            List<Movies> movies = state.movies;
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(movies[index].title),
                  subtitle: Text(movies[index].overview),
                );
              },
            );
          } else {
            return const Center(
              child: Text("Unusual happened"),
            );
          }
        },
      ),
    );
  }
}
