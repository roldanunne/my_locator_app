import 'package:get/get.dart';
import 'package:safe_here_app/module/home/controllers/home_ctrl.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() { 
    Get.put(HomeController());
  }

}