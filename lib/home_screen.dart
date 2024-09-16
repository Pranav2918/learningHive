import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hivedemo/movie_screen.dart';
import 'package:hivedemo/post_model.dart';
import 'package:hivedemo/posts_cubit/post_cubit.dart';
import 'package:hivedemo/posts_cubit/post_states.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
