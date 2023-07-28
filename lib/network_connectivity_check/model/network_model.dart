import 'package:get/get.dart';
import 'package:lightonus/network_connectivity_check/controller/network_controller.dart';

class NetworkModel extends Bindings{

  @override
  void dependencies(){
    Get.lazyPut<NetworkController>(() => NetworkController());
  }

}