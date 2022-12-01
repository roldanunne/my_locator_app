import 'dart:async';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safe_here_app/global/app_theme.dart';
import 'package:safe_here_app/global/gbl_fn.dart'; 
import 'package:safe_here_app/module/common/controllers/main_ctrl.dart';
import 'package:safe_here_app/module/common/service/api_service.dart';
import 'package:safe_here_app/module/common/service/location_service.dart';
import 'package:safe_here_app/module/dashboard/controllers/dashboard_ctrl.dart';
import 'package:safe_here_app/module/home/models/user_contact_model.dart';
import 'package:safe_here_app/module/home/service/home_service.dart';
import 'package:safe_here_app/module/tips/models/campus_tips_model.dart';
import 'package:torch_light/torch_light.dart';

class HomeController extends GetxController {

  final storage = GetStorage();
  late BuildContext context;

  MainController mainCtrl = Get.find();
  DashboardController dashCtrl = Get.find(); 
  LocationService locService = Get.find();
  ApiService apiService = Get.find();
  HomeService homeService = Get.find();

  var isLoading = false.obs;
  var isCollapsed = false.obs;
  var countPage = 1.obs;
   
  var isTorchEnabled = false.obs;
  AudioCache audioCache = AudioCache();
  AudioPlayer player = AudioPlayer();
  var isPlayingSound = false.obs;

  Completer<GoogleMapController> mapController = Completer();
  Rx<LatLng> mapCenter = LatLng(16.01422881446728, 120.35533994436264).obs;
  Rx<LatLng> lastMapPosition = LatLng(16.01422881446728, 120.35533994436264).obs;
  Rx<MapType> currentMapType = MapType.hybrid.obs;
  Set<Marker> markers = {};
  Set<Polygon> mapPolygon = {};

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController numberCtrl = TextEditingController();

  late CampusTipsModel resourcesData; 
  
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
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
    mapCenter.value = LatLng(mainCtrl.campusData.lat, mainCtrl.campusData.lng);
    lastMapPosition.value = mapCenter.value;

    List<LatLng> polygonCoords = [];
    var latlng = mainCtrl.campusData.campusLatLng;
    for(int x=0;x<latlng.length;x++) {
      polygonCoords.add(LatLng(latlng[x].lat.toDouble(), latlng[x].lng.toDouble()));
    }
    mapPolygon.add(
      Polygon(
        polygonId: PolygonId('PHILCST'),
        points: polygonCoords,
        fillColor : Colors.deepPurple.withOpacity(0.3),
        strokeColor: AppTheme.purple,
        strokeWidth: 2
      )
    );

  } 

  
  // Header
  Widget header(title) {
    return Row( 
      children: <Widget>[
        Image.asset(
          "assets/images/logo-purple.png",
          width: 50.0,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Text( 
              title,
              textAlign: TextAlign.center,
              style: AppTheme.dynamicStyle(color:AppTheme.purple, size:24.0, weight:FontWeight.w600),
            ),
          ),
        ),
        Image.asset(
          "assets/images/logo-philcst.png",
          width: 50.0,
        ),
      ]
    );
  }

  // Header Page
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

  // Header Page
  Widget headerAddPage(title) {
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
        SizedBox(width: 4),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: Icon(Icons.person_add_alt_1, size:28, color: AppTheme.purple),
          onTap: () {
            GblFn.bottomSheet(contactBottomSheet('Add',''));
          },
        ),
      ]
    );
  }

  // Attachement
  Widget cameraBottomSheet() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  "Attachments",
                  style: AppTheme.dynamicStyle(color:AppTheme.greyDark, size:18.0, weight:FontWeight.w600)
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: Icon(Icons.close, color: AppTheme.black),
                onTap: () {
                  Get.back();
                },
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  style: AppTheme.bottomSheetButtonStyle(padding:10),
                  onPressed: () {
                    Get.back();
                    getImage(ImageSource.gallery);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Gallery", style: AppTheme.dynamicStyle(color:AppTheme.grey, size:16.0)),
                      SizedBox(width: 5),
                      Icon(Icons.add_photo_alternate, color: AppTheme.black),
                    ]
                  ),
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: ElevatedButton(
                  style: AppTheme.bottomSheetButtonStyle(padding:10),
                  onPressed: () {
                    Get.back();
                    getImage(ImageSource.camera);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Camera", style: AppTheme.dynamicStyle(color:AppTheme.grey, size:16.0)),
                      SizedBox(width: 5),
                      Icon(Icons.add_a_photo, color: AppTheme.black),
                    ]
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }

  // For attachment file
  cropImage(filePath) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: filePath,
    );
    if (croppedImage == null) return;
    homeService.attachedFile.value = croppedImage;
    homeService.fileList.add(homeService.attachedFile.value);
  }

  getImage(ImageSource imageSource) async {
    XFile? imageFile = await homeService.picker.pickImage(
      source: imageSource,
      maxWidth: 1080,
      maxHeight: 1080,
      imageQuality: 50
    );
    if (imageFile == null) return;
    cropImage(imageFile.path);
  }

  // For safety tools
  tryTorch() async {
    try {
      final isTorchAvailable = await TorchLight.isTorchAvailable();
      if(isTorchAvailable){
        if(!isTorchEnabled.value){
          isTorchEnabled.value = true;
          await TorchLight.enableTorch();
        } else {
          isTorchEnabled.value = false;
          await TorchLight.disableTorch();
        }
      } else {
        GblFn.showSnackbar("Oops", "Sorry, flashlight is not available!",'error');
      }
    } on Exception catch (_) {
      // Handle error
    }
  }
  
  playEmergency() async {
    final file = await audioCache.loadAsFile("sound/siren.mp3");
    final bytes = await file.readAsBytes();
    if(!isPlayingSound.value) {
      player = await audioCache.playBytes(bytes, loop: true);
      isPlayingSound.value = true;
    } else {
      player.pause();
      isPlayingSound.value = false;
    }
  }
  
  takePhoto() async {
    XFile? recordedImage = await homeService.picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1080,
      maxHeight: 1080,
      imageQuality: 50
    );
    if (recordedImage!=null && recordedImage.path.isNotEmpty) {
      GallerySaver.saveImage(recordedImage.path);
    } 
  }

  recordVideo() async {
    XFile? recordedVideo = await homeService.picker.pickVideo(
      source: ImageSource.camera
    );
    if (recordedVideo!=null && recordedVideo.path.isNotEmpty) {
      GallerySaver.saveVideo(recordedVideo.path);
    }
  }
 
  onMapTypeButtonPressed() {
    currentMapType.value = (currentMapType.value == MapType.normal)  
        ? MapType.hybrid  
        : MapType.normal; 
  }

  onAddMarkerButtonPressed() {
    markers.add(Marker(
      // This marker id can be anything that uniquely identifies each marker.
      markerId: MarkerId(lastMapPosition.toString()),
      position: lastMapPosition.value,
      infoWindow: InfoWindow(
        title: 'Really cool place',
        snippet: '5 Star Rating',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));
  }

  onCameraMove(CameraPosition position) {
    lastMapPosition.value = position.target;
    print(position.toString());
  }

  onMapCreated(GoogleMapController controller) {
    if (!mapController.isCompleted) { 
      mapController.complete(controller);
    }
  }


  Widget contactBottomSheet(title, data) {
    var id = 0;
    if(title!='Add'){ 
      id = data.id;
      nameCtrl.text = data.name;
      numberCtrl.text = data.contact;
    }
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title+" Contact",
                  style: AppTheme.dynamicStyle(color:AppTheme.greyDark, size:18.0, weight:FontWeight.w600)
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: Icon(Icons.close, color: AppTheme.black),
                onTap: () {
                  Get.back();
                },
              ),
            ],
          ),
          SizedBox(height: 25),
          
          // Subject  
          TextFormField(
            controller: nameCtrl,
            textCapitalization: TextCapitalization.sentences,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              hintText: 'Name',
              hintStyle: AppTheme.dynamicStyle(color: AppTheme.whiteOff, size:16.0),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppTheme.whiteBlur,
                  width: 1,
                ),
              ),
            ),
            style: AppTheme.dynamicStyle(color: AppTheme.black, size:16.0), 
          ),
          SizedBox(height: 20),
          
          // Number  
          TextFormField(
            controller: numberCtrl,
            textCapitalization: TextCapitalization.sentences,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: 'Number',
              hintStyle: AppTheme.dynamicStyle(color: AppTheme.whiteOff, size:16.0),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppTheme.whiteBlur,
                  width: 1,
                ),
              ),
            ),
            style: AppTheme.dynamicStyle(color: AppTheme.black, size:16.0), 
          ),
          SizedBox(height: 30),

          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton( 
              child: Text(
                "Save",
                style: AppTheme.dynamicStyle(color: AppTheme.white, size:18.0, weight:FontWeight.w700)
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.maxFinite, 50),
                primary: AppTheme.purple,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
              ),
              onPressed: () async {
                if(nameCtrl.text.isEmpty) { 
                  GblFn.showSnackbar("Oops", "Please enter name!",'error');
                } else if(numberCtrl.text.isEmpty) { 
                  GblFn.showSnackbar("Oops", "Please enter number!",'error');
                } else { 
                  if(title=='Add'){
                    submitUserContact();
                  } else {
                    updateUserContact(id);
                  }
                }
              },
            )
          ), 
          SizedBox(height: 15),
        ],
      ),
    );
  }

  //-------------------------------------------------------------------------
  //Start Emergency Call
  submitUserContact() async {  
    try {
      isLoading.value = true;
      var data =  {
        "user_id": apiService.userModel.id.toString(),
        "name": nameCtrl.text,
        "contact": numberCtrl.text
      };
      var res = await apiService.postData('/submit-user-contact', data); 
      if (res.statusCode == 200 && res.data.toString()=='_exist_contact') {  
        GblFn.showSnackbar("Oops", "This contact already exist!",'error');
      } else if (res.statusCode == 200 && res.data.toString()=='_error') {  
        GblFn.showSnackbar("Oops", "Cannot save this contact, please try again!",'error');
      } else {  
        storage.write('usercontact', res.data.toString());
        mainCtrl.userContactList.assignAll(userContactModelFromJson(res.data.toString()));
        mainCtrl.userContactList.refresh();
        nameCtrl.clear();
        numberCtrl.clear();

        Get.back();
      } 
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  } 

  updateUserContact(id) async {  
    try {
      isLoading.value = true;
      var data =  {
        "id": id.toString(),
        "user_id": apiService.userModel.id.toString(),
        "name": nameCtrl.text,
        "contact": numberCtrl.text
      };
      var res = await apiService.postData('/update-user-contact', data); 
      if (res.statusCode == 200 && res.data.toString()=='_exist_contact') {  
        GblFn.showSnackbar("Oops", "This contact already exist!",'error');
      } else if (res.statusCode == 200 && res.data.toString()=='_error') {  
        GblFn.showSnackbar("Oops", "Cannot save this contact, please try again!",'error');
      } else {  
        storage.write('usercontact', res.data.toString());
        mainCtrl.userContactList.assignAll(userContactModelFromJson(res.data.toString()));
        mainCtrl.userContactList.refresh();
        nameCtrl.clear();
        numberCtrl.clear();

        Get.back();
      } 
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  } 

  
} 
