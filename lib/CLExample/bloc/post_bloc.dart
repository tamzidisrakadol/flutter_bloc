import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_b_sm/CLExample/core/network/network_info.dart';
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
  final NetworkInfo networkInfo;
  late StreamSubscription<bool> _connectionSubscription;

  PostBloc(this.postRepository,this.networkInfo) : super(PostInitial()) {
    _connectionSubscription = networkInfo.onConnectionChanged.listen((isConnected){
      if(isConnected){
        add(GetAllPostEvent());
      }else{
        add(NetworkErrorEvent());
      }
    });
    on<GetAllPostEvent>(_getAllPostEvent);
    on<NetworkErrorEvent>(_networkErrorEvent);
    on<UserSignOutEvent>(_userSignOutEvent);
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

  FutureOr<void> _networkErrorEvent(NetworkErrorEvent event, Emitter<PostState> emit) {
    emit(PostNetworkError(message: "No Internet Connection"));
  }

  @override
  Future<void> close() {
    _connectionSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _userSignOutEvent(UserSignOutEvent event, Emitter<PostState> emit) async{
    // do it from repository and make sure current user is not null;
    await FirebaseAuth.instance.signOut();
    emit(UserSignedOutState(message: "User signed out"));
  }
}
