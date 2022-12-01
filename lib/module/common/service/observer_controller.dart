import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safe_here_app/module/common/controllers/main_ctrl.dart';

class ObserverService extends GetxService with WidgetsBindingObserver {

  MainController mainCtrl = Get.find();
 
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        debugPrint("==>1 app in resumed"); 
        break;
      case AppLifecycleState.paused:
        debugPrint("==>1 app in paused");
        break;
      case AppLifecycleState.inactive:
        debugPrint("==>1 app in inactive");
        break;
      case AppLifecycleState.detached:
        debugPrint("==>1 app in detached");
        break;
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Future<void> onClose() async {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }


}
