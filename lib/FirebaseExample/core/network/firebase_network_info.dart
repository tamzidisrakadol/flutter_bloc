import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class FirebaseNetworkInfo{
  Stream<bool> get onConnectionChanged;
}


class FirebaseNetworkInfoImpl implements FirebaseNetworkInfo{
  final InternetConnection internetConnection;


  FirebaseNetworkInfoImpl(this.internetConnection);

  @override
  Stream<bool> get onConnectionChanged => internetConnection.onStatusChange.map((status){
    return status==InternetStatus.connected;
  });



}