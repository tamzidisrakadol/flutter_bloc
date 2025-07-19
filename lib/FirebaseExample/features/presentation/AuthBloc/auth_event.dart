part of 'auth_bloc.dart';

abstract class AuthEvent{
  const AuthEvent();

  @override
  List<Object?> get props => [];
}


class SignUpRequest extends AuthEvent{
  final String email;
  final String password;

  const SignUpRequest({required this.email,required this.password});

  @override
  List<Object?> get props => [email,password];
}









