import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safe_here_app/global/app_config.dart';
import 'package:safe_here_app/global/app_theme.dart';
import 'package:safe_here_app/global/gbl_fn.dart';
import 'package:safe_here_app/module/common/service/api_service.dart';
import 'package:safe_here_app/module/common/service/location_service.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dio/dio.dart' as dio;

class HomeService extends GetxService {

  final storage = GetStorage();
  late BuildContext context;

  ApiService apiService = Get.find();
  LocationService locService = Get.find();

  var isLoading = false.obs;
  var isCollapsed = false.obs;
  var isSendingGps = false.obs;
  var isAlertGps = false.obs;

  var typeStatus = 0.obs;

  late Timer? timer; 
  late Timer? fTimer; 

  // Call
  var hotlineId = 0.obs;
  var hotlineNumber = ''.obs;
   
  // Report
  final picker = ImagePicker();
  TextEditingController subjectCtrl = TextEditingController();
  TextEditingController detailsCtrl = TextEditingController();
  List<CroppedFile> fileList = <CroppedFile>[].obs;
  Rx<CroppedFile> attachedFile = CroppedFile('').obs;
  
  // FriendWalk
  var isSendingFriendWalkGps = false.obs;
  var isFriendWalkGps = false.obs;
  var linkCode = ''.obs;

  @override
  Future<void> onInit() async {
    debugPrint("==> HomeService");
    loadInitialized();
    
    super.onInit();
  }
  
  loadInitialized() async {
  } 

  chooseEmergency() async {
    typeStatus.value = 0;
    await Get.defaultDialog( 
      title: '',
      titlePadding: EdgeInsets.all(0),
      contentPadding: EdgeInsets.fromLTRB(20,5,20,10), 
      content: Obx(() => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Emergency Type", style: AppTheme.dynamicStyle(color: AppTheme.purple, size:20.0, weight:FontWeight.w600)),
            Divider(color: AppTheme.greyLight),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RadioListTile<int>(
                  title: Text("Medical Emergency", style: AppTheme.dynamicStyle(color:AppTheme.black, size:16.0)),
                  dense: true,
                  value: 1,
                  activeColor: AppTheme.black,
                  groupValue: typeStatus.value,
                  onChanged: (value) {
                    typeStatus.value = value!;
                  }, 
                ),

                RadioListTile<int>(
                  title: Text("Fire", style: AppTheme.dynamicStyle(color:AppTheme.black, size:16.0)),
                  dense: true,
                  value: 2,
                  activeColor: AppTheme.black,
                  groupValue: typeStatus.value,
                  onChanged: (value) {
                    typeStatus.value = value!;
                  }, 
                ),

                RadioListTile<int>(
                  title: Text("Violence", style: AppTheme.dynamicStyle(color:AppTheme.black, size:16.0)),
                  dense: true,
                  value: 3,
                  activeColor: AppTheme.black,
                  groupValue: typeStatus.value,
                  onChanged: (value) {
                    typeStatus.value = value!;
                  }, 
                ),
              ],
            ),
            Divider(color: AppTheme.greyLight),
            SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(180, 45),
                primary: AppTheme.purple,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
              onPressed: () {
                if(typeStatus.value!=0){
                  submitEmergency(1);
                  Get.back(result: true);
                } else {
                  GblFn.showSnackbar("Oops", "Please select emergency type!",'error');
                }
              },
              child: Text("Submit", style: AppTheme.dynamicStyle(color: AppTheme.white, size:18.0)),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(180, 45),
                primary: AppTheme.red,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
              onPressed: () {
                Get.back(result: false);
              },
              child: Text("Cancel", style: AppTheme.dynamicStyle(color: AppTheme.white, size:18.0)),
            ),
          ],
        )
      ) 
    );
  }


  //Submit Emergency
  submitEmergency(type) async {
    await locService.getGpsPermissionGranted();
    if(!locService.isGpsPermissionGranted.value) {
      var flag = await GblFn.showDefaultDialog(
        type:"error", 
        title: "Oops",
        btnYesLabel: "Ok",
        btnNoLabel: "Cancel",
        content: Column(
          children: <Widget>[
            Text("Please allow the app to use the location permission and try again!",
              style: AppTheme.dynamicStyle(color:AppTheme.black, size:18),
              textAlign: TextAlign.center
            ),
            SizedBox(height: 15),
          ],
        )
      );
      isLoading.value = false;
      if (flag) {
        await apiService.openLocationPermission();
        return;
      } else {
        return;
      }
    }
    
    await locService.getGpsServiceEnabled();
    if(!locService.isGpsServiceEnabled.value) {
      var flag = await GblFn.showDefaultDialog(
        type:"error", 
        title: "Oops",
        btnYesLabel: "Ok",
        btnNoLabel: "Cancel",
        content: Column(
          children: <Widget>[
            Text("Please allow the app to use the location service and try again!",
              style: AppTheme.dynamicStyle(color:AppTheme.black, size:18),
              textAlign: TextAlign.center
            ),
            SizedBox(height: 15),
          ],
        )
      );
      isLoading.value = false;
      if (flag) {
        await locService.getGpsServiceEnabled();
        return;
      } else {
        return;
      }
    }
    
    try {
      var data =  {
        "user_id": apiService.userModel.id,
        "type": type,
        "type_status": typeStatus.value.toString()
      };
      var res = await apiService.postData('/submit-emergency', data); 
      if (res.statusCode == 200 && res.data.toString()!='error') {  
        var emergencyId = res.data.toString();
        processEmergency(type,emergencyId);
      } 
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  } 

  //Process Emergency Type
  processEmergency(type,emergencyId) async {  
    if(type==1) {
      if(!isAlertGps.value){
        startAlert(emergencyId);
      } else {
        stopAlert();
      }
    } else if(type==2) {
      submitEmergencyCall(emergencyId);
    } else if(type==3) {
      submitEmergencyReport(emergencyId);
    } else if(type==4) {
      linkCode.value = GblFn.getRandomString(10);
      if(!isFriendWalkGps.value){
        startFriendWalk(emergencyId);
        shareLink();
      } else {
        stopFriendWalk();
      }
    } else if(type==5) {
       
    } else if(type==6) {
       
    } else if(type==7) {
       
    }
  } 

  //-------------------------------------------------------------------------
  //Start Emergency Alert
  startAlert(emergencyId) async {
    print("START Alert");
    isAlertGps.value = true;
    timer = Timer.periodic(Duration(seconds: 5), (_) async {
      if(!isSendingGps.value) submitEmergencyAlert(emergencyId);
    });
  }

  stopAlert() {
    print("STOP Alert");
    if(isAlertGps.value) timer!.cancel();
    isAlertGps.value = false;
  }
 
  submitEmergencyAlert(emergencyId) async {  
    try {
      isSendingGps.value = true;
      final locationData = await locService.location.getLocation();
      var data =  {
        "emergency_id": emergencyId,
        "lat": locationData.latitude,
        "lng": locationData.longitude
      };
      var res = await apiService.postData('/submit-emergency-alert', data); 
      if (res.statusCode == 200 && res.data.toString()!='error') {  
        print(res.data.toString());
      } 
    } catch (e) {
      print(e.toString());
    } finally {
      isSendingGps.value = false;
    }
  } 
  //End Emergency Alert
  //-------------------------------------------------------------------------


  //-------------------------------------------------------------------------
  //Start Emergency Call
  submitEmergencyCall(emergencyId) async {  
    try {
      final locationData = await locService.location.getLocation();
      var data =  {
        "emergency_id": emergencyId,
        "hotline_id": hotlineId.value,
        "hotline_number": hotlineNumber.value,
        "caller_number": apiService.userModel.mobile,
        "lat": locationData.latitude,
        "lng": locationData.longitude
      };
      var res = await apiService.postData('/submit-emergency-call', data); 
      if (res.statusCode == 200 && res.data.toString()!='error') {  
        print("200");
      } 
    } catch (e) {
      print(e.toString());
    } finally {
      isSendingGps.value = false;
    }
  } 
  
  Future<void> dialHotlineNumber(String phoneNumber) async {
    final url = Uri.parse("tel:$phoneNumber");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else { 
      GblFn.showSnackbar("Oops", "Failed to call this hotline number!",'error');
    }
    return;
  }
  //End Emergency Call
  //-------------------------------------------------------------------------

  //-------------------------------------------------------------------------
  //Start Emergency Report
  submitEmergencyReport(emergencyId) async {  
    try {
      final locationData = await locService.location.getLocation();
      var data = dio.FormData.fromMap({
        "emergency_id": emergencyId,
        "subject": subjectCtrl.text,
        "message": detailsCtrl.text,
        "lat": locationData.latitude,
        "lng": locationData.longitude,
        "files": [
          for (var file in fileList){
            await dio.MultipartFile.fromFile(file.path, filename: file.path.split('/').last)
          }.toList()
        ]
      });
      var res = await apiService.postData('/submit-emergency-report', data); 
      if (res.statusCode == 200 && res.data.toString()!='error') {  
        await GblFn.showSnackbar("Success", "Thank you, report summitted!", 'success');
        subjectCtrl.clear();  
        detailsCtrl.clear();  
        fileList.clear();
        Get.close(1);
      } 
    } catch (e) {
      print(e.toString());
    } finally {
      isSendingGps.value = false;
    }
  } 
  //End Emergency Call
  //-------------------------------------------------------------------------


  //-------------------------------------------------------------------------
  //Start Emergency Friend Walk
  startFriendWalk(emergencyId) async {
    print("START Friend Walk");
    isFriendWalkGps.value = true;
    fTimer = Timer.periodic(Duration(seconds: 5), (_) async {
      if(!isSendingFriendWalkGps.value) submitEmergencyFriendWalk(emergencyId);
    });
  }

  stopFriendWalk() {
    print("STOP Friend Walk");
    if(isFriendWalkGps.value) fTimer!.cancel();
    isFriendWalkGps.value = false;
  }
 
  submitEmergencyFriendWalk(emergencyId) async {  
    try {
      isSendingFriendWalkGps.value = true;
      final locationData = await locService.location.getLocation();
      var data =  {
        "emergency_id": emergencyId,
        "link_code": linkCode.value,
        "lat": locationData.latitude,
        "lng": locationData.longitude
      };
      var res = await apiService.postData('/submit-emergency-friendwalk', data); 
      if (res.statusCode == 200 && res.data.toString()!='error') {  
        print(res.data.toString());
      } 
    } catch (e) {
      print(e.toString());
    } finally {
      isSendingFriendWalkGps.value = false;
    }
  } 

  shareLink() async {
    Share.share('Hello, I want to share my current location in case of emergency in this link '+AppConfig.webUrl+'/friendwalk/'+linkCode.value);
  }
  //End Emergency Friend Walk
  //-------------------------------------------------------------------------


}
