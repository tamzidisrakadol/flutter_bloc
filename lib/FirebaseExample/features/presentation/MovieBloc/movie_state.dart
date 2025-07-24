// movie_state.dart
part of 'movie_bloc.dart';

class MovieState extends Equatable {
  final List<Results> movies;
  final bool hasReachedMax;
  final bool isLoadingFirstPage;
  final bool isLoadingMore;
  final bool isRefreshing;
  final String? error;

  const MovieState({
    required this.movies,
    required this.hasReachedMax,
    required this.isLoadingFirstPage,
    required this.isLoadingMore,
    required this.isRefreshing,
    this.error,
  });

  factory MovieState.initial() => const MovieState(
    movies: [],
    hasReachedMax: false,
    isLoadingFirstPage: false,
    isLoadingMore: false,
    isRefreshing: false,
    error: null,
  );

  MovieState copyWith({
    List<Results>? movies,
    bool? hasReachedMax,
    bool? isLoadingFirstPage,
    bool? isLoadingMore,
    bool? isRefreshing,
    String? error,          // pass null to reset
  }) {
    return MovieState(
      movies: movies ?? this.movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingFirstPage: isLoadingFirstPage ?? this.isLoadingFirstPage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    movies,
    hasReachedMax,
    isLoadingFirstPage,
    isLoadingMore,
    isRefreshing,
    error,
  ];
}
