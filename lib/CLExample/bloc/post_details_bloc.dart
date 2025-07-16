import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_b_sm/CLExample/features/Posts/Domain/post.dart';

part 'post_details_event.dart';

part 'post_details_state.dart';

class PostDetailsBloc extends Bloc<PostDetailsEvent, PostDetailsState> {
  PostDetailsBloc() : super(PostDetailsInitial()) {
    on<GetPostDetailsEvent>(_getPostDetailsEvent);
  }

  FutureOr<void> _getPostDetailsEvent(
    GetPostDetailsEvent event,
    Emitter<PostDetailsState> emit,
  ) {
    emit(PostDetailsLoading());
    final product = event.product;
    emit(PostDetailsLoaded(product: product));
  }
}
