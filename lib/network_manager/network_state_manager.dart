import 'dart:async';

import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkManager extends GetxController {
  var connectionStatus = 0.obs;

  var isConnected = false.obs;

  late StreamSubscription<InternetConnectionStatus> _streamSubscription;
  @override
  void onInit() {
    super.onInit();
    // getConnectionType();
    _streamSubscription = InternetConnectionChecker()
        .onStatusChange
        .listen((InternetConnectionStatus status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          connectionStatus.value = 1;
          break;
        case InternetConnectionStatus.disconnected:
          connectionStatus.value = 0;
      }
    });
  }

  Future<bool> checkInternetConnection() async {
    isConnected.value = await InternetConnectionChecker().hasConnection;
    return isConnected.value;
  }

  @override
  void onClose() {
    // ignore: todo
    // TODO: implement onClose
    super.onClose();
    _streamSubscription.cancel();
  }

  /*  Future<void> getConnectionType() async {
    var connectivityResult;
    try {
      connectivityResult = await (_connectivity.checkConnectivity());
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return _updateState(connectivityResult);
  }

  _updateState(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionStatus.value = 1;
        update();
        break;
      case ConnectivityResult.mobile:
        connectionStatus.value = 2;
        update();
        break;
      case ConnectivityResult.none:
        connectionStatus.value = 0;
        update();
        break;

      default:
        Get.snackbar('Network Error', 'Failed to get network status');
        break;
    }
  } */
}
