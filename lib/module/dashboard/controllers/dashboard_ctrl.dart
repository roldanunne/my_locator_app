import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safe_here_app/module/home/bindings/home_binding.dart';
import 'package:safe_here_app/module/home/views/home.dart';
import 'package:safe_here_app/module/info/bindings/info_binding.dart';
import 'package:safe_here_app/module/info/views/info.dart'; 
import 'package:safe_here_app/module/tips/bindings/tips_binding.dart';
import 'package:safe_here_app/module/tips/views/tips.dart';

class DashboardController extends GetxController {
  static DashboardController get to => Get.find();

  var showBNavBar = true.obs;
  var currentIndex = 0.obs;
  var currentPage = ''.obs;
  var hasBooking = false.obs;
  var hasSocial = false.obs;
  var hasNotification = false.obs;

  final pages = <String>[
    '/home', 
    '/tips',   
    '/info',
  ];

  void changePage(int index) {
    currentIndex.value = index;
    Get.offNamed(pages[index], id: 1);
  } 
  
  void reloadApiData(page) async {
    if(page=='/home' || page=='/notifications') {
    }
  }

  
  Route? onGenerateRoute(RouteSettings settings) {
    currentPage.value = settings.name!;
    reloadApiData(settings.name);

    if (settings.name == '/home') {
      return GetPageRoute(
        settings: settings,
        page: () => HomePage(),
        binding: HomeBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 600),
      );
    }

    if (settings.name == '/tips') {
      return GetPageRoute(
        settings: settings,
        page: () => TipsPage(),
        binding: TipsBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 600),
      );
    }

    if (settings.name == '/info') {
      return GetPageRoute(
        settings: settings,
        page: () => InfoPage(),
        binding: InfoBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 600),
      );
    }

    return null;
  }
}
