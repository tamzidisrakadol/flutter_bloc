import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([this.properties = const <dynamic>[]]);
  final List properties;

  @override
  List<Object?> get props => [properties];
}


class ServerFailure extends Failure {
  final String message;
  const ServerFailure({required this.message});
}

class NetworkFailure extends Failure {
  final String message;
  const NetworkFailure({required this.message});
}