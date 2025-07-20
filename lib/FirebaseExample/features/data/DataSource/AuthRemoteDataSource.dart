import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter_b_sm/FirebaseExample/core/error/FirebaseFailure.dart';
import 'package:flutter_b_sm/FirebaseExample/features/data/model/ServiceProviderModel.dart';
import 'package:flutter_b_sm/FirebaseExample/features/data/model/UserModel.dart';

abstract class AuthRemoteDataSource{
  Future<UserModel> signUpUserWithEmailAndPassword(String email,String password);
  Future<UserModel> loginUserWithEmailAndPassword(String email,String password);

}



class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{
  final fb_auth.FirebaseAuth _firebaseAuth;

  AuthRemoteDataSourceImpl({fb_auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? fb_auth.FirebaseAuth.instance;


  @override
  Future<UserModel> loginUserWithEmailAndPassword(String email, String password) async{
    try{
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      if(userCredential.user != null){
        return UserModel.fromFirebaseUser(userCredential.user!);
      }else{
        throw AuthFailure(message: 'Firebase user not found after sign up');
      }
    }on fb_auth.FirebaseAuthException catch(e){
      switch(e.code){
        case 'invalid-email':
          throw InvalidEmailPasswordFailure(message: 'Invalid email');
        case 'user-not-found':
          throw UserNotFoundFailure(message: 'User not found');
          case 'wrong-password':
          throw WrongPasswordFailure(message: 'Wrong password');
        default:
          throw AuthFailure(message: 'Authentication failed');
      }

    }catch(e){
      throw FirebaseServerFailure("Server Error");
    }
  }

  @override
  Future<UserModel> signUpUserWithEmailAndPassword(String email, String password) async {
    try{
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      if(userCredential.user != null){
        return UserModel.fromFirebaseUser(userCredential.user!);
      }else{
        throw AuthFailure(message: 'Firebase user not found after sign up');
      }
    }on fb_auth.FirebaseAuthException catch(e){
      switch(e.code){
        case 'invalid-email':
          throw InvalidEmailPasswordFailure(message: 'Invalid email');
        case 'user-not-found':
          throw UserNotFoundFailure(message: 'User not found');
        case 'wrong-password':
          throw WrongPasswordFailure(message: 'Wrong password');
        default:
          throw AuthFailure(message: 'Authentication failed');
      }

    }catch(e){
      throw FirebaseServerFailure("Server Error");
    }
  }

}