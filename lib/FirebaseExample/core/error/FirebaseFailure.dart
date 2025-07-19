import 'package:equatable/equatable.dart';
import 'package:flutter_b_sm/CLExample/core/error/failure.dart';

abstract class FirebaseFailure extends Equatable{
  const FirebaseFailure([this.properties = const <dynamic>[]]);
  final List properties;

  @override
  List<Object?> get props => [properties];
}


class FirebaseServerFailure extends Failure{
  final String message;

  const  FirebaseServerFailure(this.message);
}


class FirebaseNetworkFailure extends Failure{
  final String message;
  const FirebaseNetworkFailure(this.message);
}


class AuthFailure extends Failure {
  final String message;
  AuthFailure({required this.message}) : super([message]);
}

class InvalidEmailPasswordFailure extends AuthFailure {
   InvalidEmailPasswordFailure({required super.message});
}

class EmailAlreadyInUseFailure extends AuthFailure {
   EmailAlreadyInUseFailure({required super.message});
}

class WeakPasswordFailure extends AuthFailure {
   WeakPasswordFailure({required super.message});
}

class UserNotFoundFailure extends AuthFailure {
   UserNotFoundFailure({required super.message});
}

class WrongPasswordFailure extends AuthFailure {
   WrongPasswordFailure({required super.message});
}
