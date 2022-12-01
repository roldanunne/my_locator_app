import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pusher_beams/pusher_beams.dart';
import 'package:safe_here_app/global/app_theme.dart';
import 'package:safe_here_app/global/gbl_fn.dart';
import 'package:safe_here_app/module/common/models/hotline_number_model.dart';
import 'package:safe_here_app/module/common/models/walkthrough_model.dart';
import 'package:safe_here_app/module/common/service/api_service.dart';
import 'package:safe_here_app/module/common/service/location_service.dart';
import 'package:safe_here_app/module/dashboard/controllers/dashboard_ctrl.dart';
import 'package:safe_here_app/module/home/models/campus_data_model.dart'; 
import 'package:safe_here_app/module/home/models/user_contact_model.dart';
import 'package:safe_here_app/module/home/service/home_service.dart';
import 'package:safe_here_app/module/login/models/user_model.dart';
import 'package:safe_here_app/module/tips/models/campus_tips_model.dart'; 

class MainController extends GetxController {

  final storage = GetStorage();
  late BuildContext context;
  
  LocationService locService = Get.find();
  ApiService apiService = Get.find();
  HomeService homeService = Get.find();
  
  var isAnimated = false.obs;
  var isAuthenticated = false.obs; 
 
  var pages = 0.obs;
  
  late CampusDataModel campusData; 

  RxList<HotlineNumberModel> hotlineNumberList = <HotlineNumberModel>[].obs; 
  RxList<UserContactModel> userContactList = <UserContactModel>[].obs;  
  RxList<CampusTipsModel> campusTipsList = <CampusTipsModel>[].obs; 
  RxList<CampusTipsModel> campusResourcesList = <CampusTipsModel>[].obs; 
  RxList<WalkthroughModel> walkthroughList = <WalkthroughModel>[].obs; 

  @override
  Future<void> onInit() async {
    super.onInit();
    debugPrint("==> MainController");
    loadInitialized();
  }

  loadInitialized() async {
    checkLoginStatus();

    getCampusWalkthrough();
    getCampusData();
    getHotlineNumber();
    getUserContact(); 
    getCampusTips();
    getCampusResources();
 
  }
  
  getCampusWalkthrough() async { 
    if(storage.hasData('campuswalkthrough') && storage.read('campuswalkthrough').isNotEmpty) {
      walkthroughList.assignAll(walkthroughModelFromJson(storage.read('campuswalkthrough')));
      walkthroughList.refresh();
    }
    try {
      var res = await apiService.getData('/get-campus-walkthrough'); 
      if (res.statusCode == 200) {   
        storage.write('campuswalkthrough', res.data.toString());
        walkthroughList.assignAll(walkthroughModelFromJson(res.data.toString()));
        walkthroughList.refresh();
      } 
    } catch (e) {
      print(e.toString());
    } 
  } 

  getCampusData() async { 
    if(storage.hasData('campusdata') && storage.read('campusdata').isNotEmpty) {
      campusData = campusDataModelFromJson(storage.read('campusdata'));
    }
    try {
      var res = await apiService.getData('/get-campus-data'); 
      if (res.statusCode == 200) {   
        storage.write('campusdata', res.data.toString());
        campusData = campusDataModelFromJson(storage.read('campusdata'));
      } 
    } catch (e) {
      print(e.toString());
    } 
  } 

  checkLoginStatus() async {
    if(storage.hasData('userdata') && storage.read('userdata').isNotEmpty) {
      apiService.userModel = userModelFromJson(storage.read('userdata'));
      isAuthenticated.value = true;
    } else {
      isAuthenticated.value = false;
    }
    if(isAuthenticated.value) {
      try {
        var data =  {
          'id' : apiService.userModel.id
        };
        var res = await apiService.postData('/user-data',data);
        if (res.statusCode == 200) {   
          storage.write('userdata', res.data.toString());
          apiService.userModel = userModelFromJson(res.data.toString());
        } 
      } catch (e) {
        print(e.toString());
      } 
    } 
  }

  getHotlineNumber() async { 
    if(storage.hasData('hotlinenumber') && storage.read('hotlinenumber').isNotEmpty) {
      hotlineNumberList.assignAll(hotlineNumberModelFromJson(storage.read('hotlinenumber')));
      hotlineNumberList.refresh();
    }
    try {
      var res = await apiService.getData('/get-hotline-number'); 
      if (res.statusCode == 200) {   
        storage.write('hotlinenumber', res.data.toString());
        hotlineNumberList.assignAll(hotlineNumberModelFromJson(res.data.toString()));
        hotlineNumberList.refresh();
      } 
    } catch (e) {
      print(e.toString());
    } 
  } 

  getUserContact() async { 
    if(storage.hasData('usercontact') && storage.read('usercontact').isNotEmpty) {
      userContactList.assignAll(userContactModelFromJson(storage.read('usercontact')));
      userContactList.refresh();
    }
    try {
      var res = await apiService.getData('/get-user-contact?id='+apiService.userModel.id.toString()); 
      if (res.statusCode == 200) {   
        storage.write('usercontact', res.data.toString());
        userContactList.assignAll(userContactModelFromJson(res.data.toString()));
        userContactList.refresh();
      } 
    } catch (e) {
      print(e.toString());
    } 
  } 
 

  getCampusTips() async { 
    if(storage.hasData('campustips') && storage.read('campustips').isNotEmpty) {
      campusTipsList.assignAll(campusTipsModelFromJson(storage.read('campustips')));
      campusTipsList.refresh();
    }
    try {
      var res = await apiService.getData('/get-campus-tips'); 
      if (res.statusCode == 200) {   
        storage.write('campustips', res.data.toString());
        campusTipsList.assignAll(campusTipsModelFromJson(res.data.toString()));
        campusTipsList.refresh();
      } 
    } catch (e) {
      print(e.toString());
    } 
  } 

  getCampusResources() async { 
    if(storage.hasData('campusresources') && storage.read('campusresources').isNotEmpty) {
      campusResourcesList.assignAll(campusTipsModelFromJson(storage.read('campusresources')));
      campusResourcesList.refresh();
    }
    try {
      var res = await apiService.getData('/get-campus-resources'); 
      if (res.statusCode == 200) {   
        storage.write('campusresources', res.data.toString());
        campusResourcesList.assignAll(campusTipsModelFromJson(res.data.toString()));
        campusResourcesList.refresh();
      } 
    } catch (e) {
      print(e.toString());
    } 
  } 
    

}
