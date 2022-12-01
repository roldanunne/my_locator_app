import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:safe_here_app/global/app_config.dart';
import 'package:safe_here_app/module/common/service/api_service.dart';
import 'package:safe_here_app/module/common/service/location_service.dart';
import 'package:safe_here_app/module/home/service/home_service.dart';
import 'module/common/bindings/main_binding.dart';
import 'routes/app_page.dart';
import 'package:pusher_beams/pusher_beams.dart';

void main() async {
  await GetStorage.init();
  
  WidgetsFlutterBinding.ensureInitialized();
  await PusherBeams.instance.start(AppConfig.instanceIDPusherBeams);
  
  await initServices();
  runApp(MyApp());
}

Future<void> initServices() async {
  print('starting services ...');
  await Get.putAsync(() async => LocationService());
  await Get.putAsync(() async => ApiService());
  await Get.putAsync(() async => HomeService());
  print('All services started...');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: MainBinding(),
      getPages: AppPages.pages,
      enableLog: true,
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
    );
  }
}