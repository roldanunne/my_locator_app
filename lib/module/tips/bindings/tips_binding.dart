import 'package:get/get.dart';
import 'package:safe_here_app/module/tips/controllers/tips_ctrl.dart'; 

class TipsBinding extends Bindings{
  @override
  void dependencies() { 
    Get.put(TipsController());
  }

}