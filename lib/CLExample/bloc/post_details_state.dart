part of 'post_details_bloc.dart';

abstract class PostDetailsState{
  const PostDetailsState();

  @override
  List<Object> get props => [];
}

class PostDetailsInitial extends PostDetailsState {}
class PostDetailsLoading extends PostDetailsState {}
class PostDetailsLoaded extends PostDetailsState {
  final Product product;
  PostDetailsLoaded({required this.product});

  @override
  List<Object> get props => [product];
}
class PostDetailsFailure extends PostDetailsState {
  final String message;
  PostDetailsFailure({required this.message});

  @override
  List<Object> get props => [message];
}


