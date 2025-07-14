import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_b_sm/CLExample/features/Posts/Domain/post.dart';
import 'package:flutter_b_sm/CLExample/features/Posts/Domain/usecases/get_all_posts.dart';
import 'package:meta/meta.dart';

import '../core/error/failure.dart';
import '../features/Posts/Domain/repositories/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  //final GetAllPosts getAllPosts;
  final PostRepository postRepository;

  PostBloc(this.postRepository) : super(PostInitial()) {
    on<GetAllPostEvent>(_getAllPostEvent);
  }

  FutureOr<void> _getAllPostEvent(GetAllPostEvent event, Emitter<PostState> emit) async{
    emit(PostLoading());
    final failureOrPosts = await postRepository.getAllProducts();
    failureOrPosts.fold(
            (failure)=> emit(PostError(message: _mapFailureToMessage(failure))),
            (posts)=> emit(PostLoaded(posts: posts)));
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
