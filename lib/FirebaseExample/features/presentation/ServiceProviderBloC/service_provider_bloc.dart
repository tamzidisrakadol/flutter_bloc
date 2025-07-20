import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_b_sm/FirebaseExample/features/domain/Entities/ServiceProviderEntity.dart';
import 'package:flutter_b_sm/FirebaseExample/features/domain/Repository/AuthRepository.dart';
import 'package:meta/meta.dart';

part 'service_provider_event.dart';

part 'service_provider_state.dart';

class ServiceProviderBloc
    extends Bloc<ServiceProviderEvent, ServiceProviderState> {
  final AuthRepository repository;

  ServiceProviderBloc(this.repository) : super(ServiceProviderInitial()) {
    on<UploadServiceProviderEvent>(_onServiceProviderEvent);
  }

  FutureOr<void> _onServiceProviderEvent(
    UploadServiceProviderEvent event,
    Emitter<ServiceProviderState> emit,
  ) async {
    emit(ServiceProviderLoading());

    final result = await repository.addServiceProvider(
      event.serviceProviderEntity,
    );
    result.fold(
      (error) => emit(ServiceProviderError(message: error.toString())),
      (data) => emit(
        ServiceProviderSuccess(
          serviceProviderEntity: event.serviceProviderEntity,
        ),
      ),
    );
  }
}
