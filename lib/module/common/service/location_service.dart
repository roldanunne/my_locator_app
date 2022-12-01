import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart'; 
import 'package:safe_here_app/global/gbl_fn.dart';

class LocationService extends GetxService {
  
  late BuildContext context;

  Location location = Location();
  late LocationData locationData;
   
  var isGpsServiceEnabled = false.obs;
  var isGpsPermissionGranted = false.obs;
  var isGpsLocationService = false.obs;
  var isGpsLocationBackground = false.obs;

  @override
  Future<void> onInit() async {
    print("==> LocationService");
    loadInitialized();
    super.onInit();
  }
  
  loadInitialized() async {

    await getGpsPermissionGranted();
    if(!isGpsPermissionGranted.value) return;

    await getGpsServiceEnabled();
  } 

  getGpsPermissionGranted() async {    
    PermissionStatus permission = await location.hasPermission();
    if(permission == PermissionStatus.denied) {
      isGpsPermissionGranted.value = false;
      permission = await location.requestPermission();
      if (permission != PermissionStatus.granted) {
        GblFn.showSnackbar("Oops", "Failed to request location permission.",'error');
        return;
      } else {
        isGpsPermissionGranted.value = true;
      }
    } else {
      isGpsPermissionGranted.value = true;
    }
    location.changeSettings(accuracy: LocationAccuracy.high);
    locationData = await location.getLocation();
    if(isGpsPermissionGranted.value) {
      loadGpsLocationBackground();
    } 
  } 

  getGpsServiceEnabled() async {  
    isGpsServiceEnabled.value = await location.serviceEnabled();
    if(!isGpsServiceEnabled.value) {
      isGpsServiceEnabled.value = await location.requestService();
      if (!isGpsServiceEnabled.value) {
        GblFn.showSnackbar("Oops", "Failed to request location service.",'error');
        return;
      }
    } 
    locationData = await location.getLocation();
    loadGpsLocationBackground();
  } 

  loadGpsLocationBackground() async { 
    bool bgModeEnabled = await location.isBackgroundModeEnabled();
    if (bgModeEnabled) {
      return true;
    } else {
      try {
        await location.enableBackgroundMode();
      } catch (e) {
        debugPrint(e.toString());
      }
      try {
        bgModeEnabled = await location.enableBackgroundMode();
      } catch (e) {
        debugPrint(e.toString());
      }
      print(bgModeEnabled); //True!
      return bgModeEnabled;
    }
  } 

}