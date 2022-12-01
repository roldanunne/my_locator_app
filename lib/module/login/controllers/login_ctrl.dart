import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:safe_here_app/global/app_theme.dart';
import 'package:safe_here_app/global/gbl_fn.dart';
import 'package:safe_here_app/module/common/controllers/main_ctrl.dart';
import 'package:safe_here_app/module/common/service/api_service.dart';
import 'package:safe_here_app/module/common/service/location_service.dart';
import 'package:safe_here_app/routes/app_routes.dart';

class LoginController extends GetxController {

  final storage = GetStorage();

  ApiService apiService = Get.find();
  MainController mainCtrl = Get.find();
  LocationService locService = Get.find();

  var isLoading = false.obs;
  var isObscure = true.obs;
  var isAgreed = false.obs;

  TextEditingController studIdCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  @override
  Future<void> onInit() async {
    super.onInit();
    debugPrint("==> LoginController");
    loadInitialized();
  }

  loadInitialized() async {
    
  }

  Widget headerPage(title) {
    return Row( 
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: Icon(Icons.arrow_back, size:24, color: AppTheme.black),
          onTap: () {
            Get.back();
          },
        ),
        SizedBox(width: 10),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: AppTheme.dynamicStyle(color:AppTheme.purple, size:20.0, weight:FontWeight.w600),
            ),
          ),
        ), 
        SizedBox(width: 34),
      ]
    );
  }
    
  // Login Page
  submitLogin() async {  
    try {
      isLoading.value = true;
      var data =  {
        'id_no' : studIdCtrl.text,
        'password' : passwordCtrl.text
      };

      var res = await apiService.postData('/login',data);
      if (res.statusCode == 200) {  
        storage.write('userdata', res.data.toString());
        await mainCtrl.checkLoginStatus();
        if(mainCtrl.isAuthenticated.value){ 
          Get.offNamed(Routes.DASHBOARD);
        } else {      
          GblFn.showSnackbar("Login failed", "Your email or password is incorrect.",'error');
        }
      } else {      
        GblFn.showSnackbar("Login failed", "Your email or password is incorrect.",'error');
      }
    } catch (e) {
      GblFn.showSnackbar("Login failed", "Your request cannot be process, please try again.",'error');
    } finally {
      isLoading.value = false;
    }
    
  }
 
}
