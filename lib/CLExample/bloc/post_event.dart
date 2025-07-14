part of 'post_bloc.dart';


abstract class PostEvent{

  const PostEvent();

  @override
  List<Object> get props => [];
}

class GetAllPostEvent extends PostEvent{}