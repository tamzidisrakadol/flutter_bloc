import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_b_sm/FirebaseExample/features/domain/Repository/AuthRepository.dart';
import '../../domain/Entities/UserEntity.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthStateInitial()) {
    on<SignUpRequest>(_onSignUpRequest);
  }

  Future<void> _onSignUpRequest(
    SignUpRequest event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthStateLoading());

    //register
     final result = await authRepository.signUpWithEmailAndPassword(email: event.email, password: event.password);

     //sign in
    // final result = await authRepository.loginUserWithEmailAndPassword(
    //   event.email,
    //   event.password,
    // );

    //must use await to use fold
    result.fold(
      (error) => emit(AuthError(error.toString())),
      (user) => emit(AuthStateSuccess(user, "Success")),
    );
  }
}
