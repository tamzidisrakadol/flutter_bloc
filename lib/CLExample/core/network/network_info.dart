import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<bool> get onConnectionChanged;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnection internetConnection;

  NetworkInfoImpl(this.internetConnection);

  @override
  Future<bool> get isConnected => internetConnection.hasInternetAccess;

  @override
  Stream<bool> get onConnectionChanged => internetConnection.onStatusChange.map((status){
    return status == InternetStatus.connected;
  });
}