import 'package:get/get.dart';
import 'package:safe_here_app/module/login/controllers/login_ctrl.dart';

class LoginBinding extends Bindings{
  @override
  void dependencies() { 
    Get.put(LoginController());
  }

}