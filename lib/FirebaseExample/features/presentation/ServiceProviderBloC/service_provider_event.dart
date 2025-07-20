part of 'service_provider_bloc.dart';

abstract class ServiceProviderEvent{
  const ServiceProviderEvent();

  @override
  List<Object> get props => [];


}

class UploadServiceProviderEvent extends ServiceProviderEvent{
  final ServiceProviderEntity serviceProviderEntity;

  const UploadServiceProviderEvent({required this.serviceProviderEntity});

  @override
  List<Object> get props => [serviceProviderEntity];

}






