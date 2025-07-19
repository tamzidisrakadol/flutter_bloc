import 'package:dartz/dartz.dart';
import 'package:flutter_b_sm/FirebaseExample/core/error/FirebaseFailure.dart';
import 'package:flutter_b_sm/FirebaseExample/features/domain/Entities/UserEntity.dart';

import '../../data/DataSource/AuthRemoteDataSource.dart';

abstract class AuthRepository{
  Future<Either<FirebaseFailure,UserEntity>> signUpUserWithEmailAndPassword(String email,String password);
  Future<Either<FirebaseFailure,UserEntity>> loginUserWithEmailAndPassword(String email,String password);
}

class AuthRepositoryImpl implements AuthRepository{
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<Either<FirebaseFailure, UserEntity>> loginUserWithEmailAndPassword(String email, String password) async{
    try{
      final user = await authRemoteDataSource.loginUserWithEmailAndPassword(email, password);
      return Right(user);
    }on FirebaseFailure catch(e){
      return Left(e);
    }catch (e){
      return Left(FirebaseServerFailure("Server Error") as FirebaseFailure);
    }
  }

  @override
  Future<Either<FirebaseFailure, UserEntity>> signUpUserWithEmailAndPassword(String email, String password) async{
    try{
      final user = await authRemoteDataSource.signUpUserWithEmailAndPassword(email, password);
      return Right(user);
    }on FirebaseFailure catch(e){
      return Left(e);
    }catch (e){
      return Left(FirebaseServerFailure("Server Error") as FirebaseFailure);
    }
  }

}





