import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo {
  final Connectivity connectivity;

  NetworkInfo(this.connectivity);

  Future<bool> get isConnected async {
    final List<ConnectivityResult> results = await connectivity.checkConnectivity();
    return !results.contains(ConnectivityResult.none);
  }
}
