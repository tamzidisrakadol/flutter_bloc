part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
  @override
  List<Object?> get props => [];
}

/// Initial load + load more (next pages)
class MovieFetched extends MovieEvent {}

/// Pull-to-refresh (starts from page 1 again)
class MovieRefreshed extends MovieEvent {}







