import 'package:get/get.dart';
import 'package:safe_here_app/module/dashboard/controllers/dashboard_ctrl.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
  }
}
