import 'package:get/get.dart';
import 'package:the_staff_hound/network_manager/network_state_manager.dart';

class NetworkBinding extends Bindings {
  @override
  void dependencies() =>
      Get.lazyPut<NetworkManager>(() => NetworkManager(), fenix: true);
}
