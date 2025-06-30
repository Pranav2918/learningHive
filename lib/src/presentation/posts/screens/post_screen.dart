import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hivedemo/src/presentation/movies/screens/movie_screen.dart';
import 'package:hivedemo/src/presentation/posts/posts_cubit/post_cubit.dart';
import 'package:hivedemo/src/presentation/posts/posts_cubit/post_states.dart';
import 'package:hivedemo/src/data/posts/post_model.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<Posts> postList = [];

  @override
  void initState() {
    context.read<PostListCubit>().fetchPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PostListCubit, PostListStates>(
        builder: (context, state) {
          if (state is PostListStateInitial || state is PostListStateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostListStateFailed) {
            return Center(child: Text(state.errorMessage));
          } else if (state is PostListStateSuccess) {
            return ListView.builder(
              itemCount: state.postList.length,
              itemBuilder: (context, index) {
                postList = state.postList;
                final post = postList[index];
                return ListTile(
                  title: Text(post.title),
                );
              },
            );
          } else {
            return const Center(
              child: Text("Unusual happen"),
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MovieScreen(),
                ));
          },
          child: const Center(
            child: Icon(Icons.arrow_forward_ios_rounded),
          ),
        ),
      ),
    );
  }
}
