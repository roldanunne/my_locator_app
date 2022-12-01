import 'dart:async';
import 'dart:io'; 
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safe_here_app/global/app_theme.dart';
import 'package:safe_here_app/module/common/controllers/main_ctrl.dart';
import 'package:safe_here_app/module/dashboard/controllers/dashboard_ctrl.dart'; 
import 'package:safe_here_app/module/tips/models/campus_tips_model.dart';

class TipsController extends GetxController {

  final storage = GetStorage();
  late BuildContext context;

  MainController mainCtrl = Get.find();
  DashboardController dashCtrl = Get.find();
 
  var isLoading = false.obs;
  
  late CampusTipsModel tipsData;
  var dateAgo = ''.obs;

  @override
  Future<void> onInit() async {
    debugPrint("==> HomeController");
    loadInitialized();
    super.onInit();
  }
  
  @override
  Future<void> onClose() async {
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


}
