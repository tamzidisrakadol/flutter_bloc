import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_b_sm/FirebaseExample/features/domain/Repository/AuthRepository.dart';
import 'package:meta/meta.dart';

import '../../domain/Entities/UserEntity.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthStateInitial()) {
    on<SignUpRequest>(_onSignUpRequest);
  }

  FutureOr<void> _onSignUpRequest(SignUpRequest event, Emitter<AuthState> emit) {
    emit(AuthStateLoading());
    final result = authRepository.signUpUserWithEmailAndPassword(event.email, event.password);
    result.then((value) =>
        value.fold((error) => emit(AuthError(error.toString())),
            (user) => emit(AuthStateSuccess(user,"Success"))));


  }
}
