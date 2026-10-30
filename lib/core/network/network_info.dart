import 'package:connectivity_plus/connectivity_plus.dart';

/// Kontrak interface untuk memeriksa ketersediaan koneksi internet.
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> get isConnected async {
    final results = await connectivity.checkConnectivity();
    // Jika hasilnya bukan 'none', berarti ada koneksi (WiFi, Seluler, atau Ethernet)
    return !results.contains(ConnectivityResult.none);
  }
}
