import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../MovieBloc/movie_bloc.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  late final ScrollController _scrollController;
  late final MovieBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<MovieBloc>();
    _scrollController = ScrollController()..addListener(_onScroll);

    // initial load
    _bloc.add(MovieFetched());
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      context.read<MovieBloc>().add(MovieFetched());
    }
  }

  Future<void> _onRefresh() async {
    _bloc.add(MovieRefreshed());
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Movie List Screen"),backgroundColor: Colors.amberAccent,),
        body:  BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state.isLoadingFirstPage && state.movies.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.error != null && state.movies.isEmpty) {
          return Center(
            child: Text(state.error!, style: const TextStyle(color: Colors.red)),
          );
        }

        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: ListView.builder(
            controller: _scrollController,
            itemCount: state.movies.length + (state.hasReachedMax ? 0 : 1),
            itemBuilder: (context, index) {
              if (index < state.movies.length) {
                final movie = state.movies[index];
                return ListTile(
                  title: Text(movie.title ?? 'No title'),
                  subtitle: Text(movie.contentId ?? 'No contentid'),
                );
              }

              // loader at bottom while loading more
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(child: CircularProgressIndicator()),
              );
            },
          ),
        );
      },
    ));



  }
}
