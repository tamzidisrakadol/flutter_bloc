import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter_b_sm/FirebaseExample/features/domain/Entities/UserEntity.dart';

class UserModel extends UserEntity{

  const UserModel({required super.uid, required super.email});


  factory UserModel.fromFirebaseUser(fb_auth.User user) {
    return UserModel(
      uid: user.uid,
      email: user.email ?? '', // Firebase User email can be null for anonymous users
    );
  }


}