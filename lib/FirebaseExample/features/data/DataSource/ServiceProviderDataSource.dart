import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_b_sm/FirebaseExample/core/error/FirebaseFailure.dart';

import '../model/ServiceProviderModel.dart';

abstract class ServiceProviderDataSource{
  Future<ServiceProviderModel> addServiceProvider(ServiceProviderModel serviceProviderModel);
}


class ServiceProviderDataSourceImpl implements ServiceProviderDataSource{

  final DatabaseReference _databaseRef;


  ServiceProviderDataSourceImpl({DatabaseReference? databaseRef})
      : _databaseRef = databaseRef ?? FirebaseDatabase.instance.ref();

  static const String _serviceProvidersPath = 'serviceProviders';

  @override
  Future<ServiceProviderModel> addServiceProvider(ServiceProviderModel serviceProviderModel) async{
    try{
      final serviceProviderRef = _databaseRef.child(_serviceProvidersPath).push();
      final String? newId = serviceProviderRef.key;
      if(newId == null){
        throw FirebaseServerFailure("Failed to generate unique id");
      }
      await serviceProviderRef.set(serviceProviderModel.toJson());

      return serviceProviderModel.copyWith(id: newId);
    }on FirebaseException catch (e){
      throw FirebaseServerFailure(e.message ?? "Server Error");
    } catch(e){
      throw FirebaseServerFailure("Server Error");
    }
  }

}
