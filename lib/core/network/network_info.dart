import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity _connectivity;
  final InternetConnectionChecker _checker;

  NetworkInfoImpl(this._connectivity, this._checker);

  @override
  Future<bool> get isConnected async {
    final connResult = await _connectivity.checkConnectivity();
    if (connResult == ConnectivityResult.none) return false;
    // Additional check to detect captive portals / actual internet access
    return await _checker.hasConnection;
  }
}
