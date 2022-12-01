import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safe_here_app/module/common/controllers/main_ctrl.dart';
import 'package:safe_here_app/module/dashboard/controllers/dashboard_ctrl.dart';
import 'package:safe_here_app/global/app_theme.dart';
import 'package:safe_here_app/global/gbl_fn.dart';


class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainController mainCtrl = Get.find();
    mainCtrl.context = context;
    
    // Check if notification has value

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        extendBody: false,
        body: Navigator(
          key: Get.nestedKey(1),
          initialRoute: '/home',
          onGenerateRoute: controller.onGenerateRoute,
        ),
        bottomNavigationBar: Obx(() => BottomNavigationBar(
          backgroundColor: AppTheme.white, 
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.currentIndex.value,
          selectedItemColor:AppTheme.purple,
          selectedLabelStyle: AppTheme.dynamicStyle( size:14.0, weight: FontWeight.w600),
          unselectedItemColor:AppTheme.purpleBlur,
          unselectedLabelStyle: AppTheme.dynamicStyle( size:12.0, weight: FontWeight.normal),
          onTap: controller.changePage,
          items: [
            GblFn.bottomNavigationBarItem(
              Icons.home,
              Icons.home_outlined,
              "Home",
              false,
            ), 
            GblFn.bottomNavigationBarItem(
              Icons.tips_and_updates,
              Icons.tips_and_updates_outlined,
              "Resources",
              controller.hasBooking.value,
            ),
            GblFn.bottomNavigationBarItem(
              Icons.info,
              Icons.info_outlined,
              "About",
              controller.hasNotification.value,
            ),
          ],
        ),
      )),
    );
  }
}
