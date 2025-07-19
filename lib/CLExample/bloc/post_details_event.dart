part of 'post_details_bloc.dart';

abstract class PostDetailsEvent{
  const PostDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetPostDetailsEvent extends PostDetailsEvent{
  final Product product;
  GetPostDetailsEvent({required this.product});

  @override
  List<Object> get props => [product];
}




