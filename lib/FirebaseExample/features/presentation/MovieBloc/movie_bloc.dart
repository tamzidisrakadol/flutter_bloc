// movie_bloc.dart
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart'; // if you use Either
import 'package:meta/meta.dart';

import '../../../../CLExample/core/error/failure.dart';
import 'package:flutter_b_sm/CLExample/features/Posts/Domain/repositories/post_repository.dart';
import 'package:flutter_b_sm/FirebaseExample/features/domain/Entities/MovieEntity.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final PostRepository postRepository;

  int _currentPage = 1;
  int _totalPages = 1;
  bool _isFetching = false; // local debounce/guard

  MovieBloc(this.postRepository) : super(MovieState.initial()) {
    on<MovieFetched>(_onFetched);
    on<MovieRefreshed>(_onRefreshed);
  }

  Future<void> _onFetched(MovieFetched event, Emitter<MovieState> emit) async {
    if (state.hasReachedMax || _isFetching) return;

    _isFetching = true;

    // First page?
    final isFirstPage = _currentPage == 1 && state.movies.isEmpty;

    if (isFirstPage) {
      emit(state.copyWith(
        isLoadingFirstPage: true,
        error: null,
      ));
    } else {
      emit(state.copyWith(
        isLoadingMore: true,
        error: null,
      ));
    }

    final response = await postRepository.getAllMovie(_currentPage);
    response.fold(
          (failure) {
        emit(state.copyWith(
          isLoadingFirstPage: false,
          isLoadingMore: false,
          error: _mapFailureToMessage(failure),
        ));
      },
          (movie) {
        _totalPages = movie.totalPages ?? _totalPages;

        final newItems = movie.results ?? [];
        final all = List<Results>.from(state.movies)..addAll(newItems);

        final reachedMax = (_currentPage >= _totalPages) || newItems.isEmpty;

        emit(state.copyWith(
          movies: all,
          hasReachedMax: reachedMax,
          isLoadingFirstPage: false,
          isLoadingMore: false,
          error: null,
        ));

        /// 🔥 Always increment if not reached max, regardless of item count
        if (!reachedMax) {
          _currentPage++;
        }
      },
    );

    _isFetching = false;
  }

  Future<void> _onRefreshed(
      MovieRefreshed event, Emitter<MovieState> emit) async {
    if (_isFetching) return;
    _isFetching = true;

    emit(state.copyWith(
      isRefreshing: true,
      error: null,
      hasReachedMax: false,
    ));

    _currentPage = 1;

    final response = await postRepository.getAllMovie(_currentPage);
    response.fold(
          (failure) {
        emit(state.copyWith(
          isRefreshing: false,
          error: _mapFailureToMessage(failure),
        ));
      },
          (movie) {
        final newItems = movie.results ?? [];
        _totalPages = movie.totalPages ?? 1;

        emit(state.copyWith(
          movies: newItems,
          hasReachedMax: _currentPage >= _totalPages || newItems.isEmpty,
          isRefreshing: false,
          isLoadingFirstPage: false,
          isLoadingMore: false,
          error: null,
        ));

        if (newItems.isNotEmpty && _currentPage < _totalPages) {
          _currentPage = 2; // next page
        }
      },
    );

    _isFetching = false;
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return (failure as ServerFailure).message;
      case NetworkFailure:
        return (failure as NetworkFailure).message;
      default:
        return 'Unexpected Error';
    }
  }
}
