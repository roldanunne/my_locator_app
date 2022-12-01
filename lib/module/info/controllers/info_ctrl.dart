import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:safe_here_app/global/app_theme.dart';
import 'package:safe_here_app/global/gbl_fn.dart';
import 'package:safe_here_app/module/common/controllers/main_ctrl.dart';
import 'package:safe_here_app/module/common/service/api_service.dart';
import 'package:safe_here_app/module/dashboard/controllers/dashboard_ctrl.dart';

class InfoController extends GetxController with GetSingleTickerProviderStateMixin {

  final storage = GetStorage();
  late BuildContext context;

  MainController mainCtrl = Get.find();
  DashboardController dashCtrl = Get.find();
  ApiService apiService = Get.find();
 
  var isLoading = false.obs;
  var tabFlag = false.obs;
  var isObscure = true.obs;
   
  late TabController tabController;

  TextEditingController oldpasswordCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController repasswordCtrl = TextEditingController();

  @override
  Future<void> onInit() async {
    tabController = TabController(length: 2, vsync: this);
    debugPrint("==> InfoController");
    loadInitialized();
    super.onInit();
  }
  
  @override
  Future<void> onClose() async {
    tabController.dispose();
    super.onClose();
  }

  loadInitialized() async {
  }

  // Header Page
  Widget header(title) {
    return Row( 
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
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
      ]
    );
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


  // Profile Page
  submitProfile() async {  
    try {
      isLoading.value = true;
      var data =  {
        'id' : apiService.userModel.id,
        'old_password' : oldpasswordCtrl.text,
        'password' : passwordCtrl.text
      };

      var res = await apiService.postData('/update-password',data);
      if (res.statusCode == 200 && res.data.toString()!='_error') {  
        storage.write('userdata', res.data.toString());
        oldpasswordCtrl.clear();
        passwordCtrl.clear();
        repasswordCtrl.clear();
        Get.back();
        GblFn.showSnackbar("Password", "Your password updated successfully.",'success');
      } else {      
        GblFn.showSnackbar("Password failed", "Your password is incorrect.",'error');
      }
    } catch (e) {
      GblFn.showSnackbar("Password failed", "Your request cannot be process, please try again.",'error');
    } finally {
      isLoading.value = false;
    }
    
  }

}
