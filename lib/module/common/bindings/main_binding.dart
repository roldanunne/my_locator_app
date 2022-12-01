import 'package:get/get.dart';
import 'package:safe_here_app/module/common/controllers/main_ctrl.dart';
import 'package:safe_here_app/module/common/service/observer_controller.dart';

class MainBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(MainController());
    Get.put(ObserverService(), permanent: true);
  }

}