import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:safe_here_app/global/app_config.dart';
import 'package:safe_here_app/module/common/service/location_service.dart';
import 'package:safe_here_app/module/login/models/user_model.dart';

class ApiService extends GetxService {

  final storage = GetStorage();
  LocationService locService = Get.find();
  
  late Dio _dio = Dio(); 
  late UserModel userModel;

  var accessToken = ''.obs;

  dio({bool hasToken=true}) { 
    var options = (hasToken)
      ?  BaseOptions(
        connectTimeout: 60000,
        receiveTimeout: 60000,
        baseUrl: AppConfig.baseUrl, 
        responseType: ResponseType.plain,
        contentType: 'application/json',
        headers : {
          'Content-type': 'application/json',
          'Accept': 'application/json', 
          'Authorization': 'Bearer ${accessToken.value}'
        }
      )
      :BaseOptions(
        baseUrl: AppConfig.webUrl,
        responseType: ResponseType.plain,
      ); 
    _dio = Dio(options);
    
    _dio.interceptors.add(
      PrettyDioLogger(
        logPrint: appDebugPrint,
        requestHeader: false,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
      )
    );
    return _dio;
  }

  appDebugPrint(Object message) {
    debugPrint(message.toString());
  } 
  
  getData(url) async {
    return await dio().get(url);
  }
  
  postData(url, data) async {
    return await dio().post(url, data: data);
  }

  putData(url, data) async {
    return await dio().put(url, data: data);
  }
  
  openLocationPermission() async { 
    bool settingsOpened = await openAppSettings();
    if (settingsOpened) {
      BasicMessageChannel<String?> lifecycleChannel = SystemChannels.lifecycle;
      lifecycleChannel.setMessageHandler((msg) async {
        if (msg!.contains("resumed")) {
          lifecycleChannel.setMessageHandler(null);
          if (await Permission.location.isGranted) {
            locService.isGpsPermissionGranted.value = true;
          }
        }  
        return;
      });
    }
  }

}