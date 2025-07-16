part of 'post_bloc.dart';

abstract class PostState{
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<Product> posts;
  PostLoaded({required this.posts});

  @override
  List<Object> get props => [posts];
}
class PostError extends PostState {
  final String message;
  PostError({required this.message});

  @override
  List<Object> get props => [message];
}

class PostNetworkError extends PostState {
  final String message;
  PostNetworkError({required this.message});

  @override
  List<Object> get props => [message];
}