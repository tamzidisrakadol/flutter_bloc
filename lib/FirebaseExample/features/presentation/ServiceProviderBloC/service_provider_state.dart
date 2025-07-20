part of 'service_provider_bloc.dart';

abstract class ServiceProviderState {
  const ServiceProviderState();

  @override
  List<Object> get props => [];
}

class ServiceProviderInitial extends ServiceProviderState {}

class ServiceProviderLoading extends ServiceProviderState {}

class ServiceProviderSuccess extends ServiceProviderState {
  final ServiceProviderEntity serviceProviderEntity;

  const ServiceProviderSuccess({required this.serviceProviderEntity});

  @override
  List<Object> get props => [serviceProviderEntity];
}

class ServiceProviderError extends ServiceProviderState {
  final String message;

  const ServiceProviderError({required this.message});

  @override
  List<Object> get props => [message];
}
