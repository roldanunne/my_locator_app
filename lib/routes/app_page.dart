import 'package:get/get.dart';
import 'package:safe_here_app/module/dashboard/bindings/dashboard_binding.dart';
import 'package:safe_here_app/module/home/bindings/home_binding.dart';
import 'package:safe_here_app/module/home/views/call_help.dart';
import 'package:safe_here_app/module/home/views/contact_list.dart';
import 'package:safe_here_app/module/home/views/map.dart';
import 'package:safe_here_app/module/home/views/report.dart';
import 'package:safe_here_app/module/home/views/resources.dart';
import 'package:safe_here_app/module/home/views/resources_details.dart';
import 'package:safe_here_app/module/home/views/safety_tool.dart';
import 'package:safe_here_app/module/info/views/profile_details.dart';
import 'package:safe_here_app/module/login/bindings/login_binding.dart';
import 'package:safe_here_app/module/login/views/terms.dart'; 
import 'package:safe_here_app/module/tips/views/tips_details.dart';
import 'package:safe_here_app/routes/app_routes.dart';
import 'package:safe_here_app/module/dashboard/views/dashboard.dart';
import 'package:safe_here_app/module/login/views/login.dart';
import 'package:safe_here_app/module/common/views/splash.dart';

class AppPages {

  static final pages = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginPage(),
      binding: LoginBinding(),
      transition: Transition.fadeIn,
    ), 
    GetPage(
      name: Routes.TERMS,
      page: () => const TermsPage(),
      transitionDuration: const Duration(milliseconds: 200),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.DASHBOARD,
      page: () => DashboardPage(),
      binding: DashboardBinding(),
      transitionDuration: const Duration(milliseconds: 200),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.HOME_CALL_HELP,
      page: () => const CallHelpPage(),
      binding: HomeBinding(),
      transitionDuration: const Duration(milliseconds: 200),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.HOME_REPORT,
      page: () => const ReportPage(),
      binding: HomeBinding(),
      transitionDuration: const Duration(milliseconds: 200),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.HOME_SAFETY_TOOLS,
      page: () => const SafetyToolPage(),
      binding: HomeBinding(),
      transitionDuration: const Duration(milliseconds: 200),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.HOME_MAP,
      page: () => const MapPage(),
      binding: HomeBinding(),
      transitionDuration: const Duration(milliseconds: 200),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.HOME_RESOURCES,
      page: () => const ResourcesPage(),
      binding: HomeBinding(),
      transitionDuration: const Duration(milliseconds: 200),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.HOME_RESOURCES_DETAILS,
      page: () => const ResourcesDetailsPage(),
      binding: HomeBinding(),
      transitionDuration: const Duration(milliseconds: 200),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.HOME_CONTACT,
      page: () => const ContactPage(),
      binding: HomeBinding(),
      transitionDuration: const Duration(milliseconds: 200),
      transition: Transition.rightToLeft,
    ), 
    GetPage(
      name: Routes.TIPS_DETAILS,
      page: () => const TipsDetailsPage(),
      transitionDuration: const Duration(milliseconds: 200),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.PROFILE_DETAILS,
      page: () => const ProfilePage(),
      transitionDuration: const Duration(milliseconds: 200),
      transition: Transition.rightToLeft,
    ),
    
    
  ];
}
