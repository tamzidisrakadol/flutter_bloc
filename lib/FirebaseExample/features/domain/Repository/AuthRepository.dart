import 'package:dartz/dartz.dart';
import 'package:flutter_b_sm/FirebaseExample/core/error/FirebaseFailure.dart';
import 'package:flutter_b_sm/FirebaseExample/features/domain/Entities/ServiceProviderEntity.dart';
import 'package:flutter_b_sm/FirebaseExample/features/domain/Entities/UserEntity.dart';

import '../../data/DataSource/AuthRemoteDataSource.dart';
import '../../data/DataSource/ServiceProviderDataSource.dart';
import '../../data/model/ServiceProviderModel.dart';

abstract class AuthRepository {
  Future<Either<FirebaseFailure, UserEntity>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<FirebaseFailure, UserEntity>> loginUserWithEmailAndPassword(
    String email,
    String password,
  );

  Future<Either<FirebaseFailure, ServiceProviderEntity>> addServiceProvider(
    ServiceProviderEntity serviceProviderEntity,
  );
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final ServiceProviderDataSource serviceProviderDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource, this.serviceProviderDataSource);

  @override
  Future<Either<FirebaseFailure, UserEntity>> loginUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final user = await authRemoteDataSource.loginUserWithEmailAndPassword(
        email,
        password,
      );
      return Right(user);
    } on FirebaseFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(FirebaseServerFailure("Server Error") as FirebaseFailure);
    }
  }

  @override
  Future<Either<FirebaseFailure, UserEntity>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await authRemoteDataSource.signUpUserWithEmailAndPassword(
        email,
        password,
      );
      return Right(user);
    } on FirebaseFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(FirebaseServerFailure("Server Error") as FirebaseFailure);
    }
  }

  @override
  Future<Either<FirebaseFailure, ServiceProviderEntity>> addServiceProvider(
    ServiceProviderEntity serviceProviderEntity,
  ) async {
    try {
      final serviceProviderModel = ServiceProviderModel(
        nameOfService: serviceProviderEntity.nameOfService,
        nameOfEmployee: serviceProviderEntity.nameOfEmployee,
        address: serviceProviderEntity.address,
      );

      final uploadModel = await serviceProviderDataSource.addServiceProvider(
        serviceProviderModel,
      );
      return Right(uploadModel);
    } on FirebaseServerFailure catch (e) {
      return Left(e as FirebaseFailure);
    } catch (e) {
      return Left(FirebaseServerFailure("Server Error") as FirebaseFailure);
    }
  }
}
