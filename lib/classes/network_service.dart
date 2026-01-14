import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
// import 'dart:async';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

// class NetworkService {
//   final _controller = StreamController<bool>.broadcast();
//   Stream<bool> get connectionStream => _controller.stream;

//   late final StreamSubscription _connectivitySub;

//   NetworkService() {
//     _connectivitySub =
//         Connectivity().onConnectivityChanged.listen((result) async {
//       if (result == ConnectivityResult.none) {
//         _controller.add(false);
//       } else {
//         final hasInternet = await InternetConnection().hasInternetAccess;
//         _controller.add(hasInternet);
//       }
//     });
//   }

//   Future<bool> checkNow() async {
//     final connectivity = await Connectivity().checkConnectivity();
//     if (connectivity == ConnectivityResult.none) return false;
//     return await InternetConnection().hasInternetAccess;
//   }

//   void dispose() {
//     _connectivitySub.cancel();
//     _controller.close();
//   }
// }



class NetworkService {
  final _controller = StreamController<bool>.broadcast();
  Stream<bool> get connectionStream => _controller.stream;

  late final StreamSubscription<List<ConnectivityResult>> _connectivitySub;

  NetworkService() {
    _connectivitySub =
        Connectivity().onConnectivityChanged.listen((results) async {
      // If NONE is in the list → no network
      if (results.contains(ConnectivityResult.none)) {
        _controller.add(false);
        return;
      }

      // Network exists → check real internet
      final hasInternet = await InternetConnection().hasInternetAccess;
      _controller.add(hasInternet);
    });
  }

  Future<bool> checkNow() async {
    final results = await Connectivity().checkConnectivity();

    if (results.contains(ConnectivityResult.none)) {
      return false;
    }

    return await InternetConnection().hasInternetAccess;
  }

  void dispose() {
    _connectivitySub.cancel();
    _controller.close();
  }
}
