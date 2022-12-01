import 'package:get/get.dart';
import 'package:safe_here_app/module/info/controllers/info_ctrl.dart'; 

class InfoBinding extends Bindings{
  @override
  void dependencies() { 
    Get.put(InfoController());
  }

}