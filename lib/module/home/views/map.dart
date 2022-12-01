import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safe_here_app/global/app_theme.dart';
import 'package:safe_here_app/module/common/controllers/main_ctrl.dart';
import 'package:safe_here_app/module/home/controllers/home_ctrl.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    MainController mainCtrl = Get.find();
    HomeController homeCtrl = Get.find();
    homeCtrl.context = context;

    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: AppBar(
        leading: GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: Icon(Icons.arrow_back, size:24, color: AppTheme.black),
          onTap: () {
            Get.back();
          },
        ),
        title: Text("Campus Map"), 
        titleTextStyle: AppTheme.dynamicStyle(color:AppTheme.purple, size:20.0, weight:FontWeight.w600), 
        backgroundColor: AppTheme.white, 
        centerTitle: true,
        elevation: 1
      ),
      body: Obx(() => Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: homeCtrl.onMapCreated,
            initialCameraPosition: CameraPosition(
              target: homeCtrl.mapCenter.value,
              zoom: mainCtrl.campusData.zoom,
              bearing: mainCtrl.campusData.bearing,
            ),
            polygons: homeCtrl.mapPolygon,
            mapType: homeCtrl.currentMapType.value,
            markers: homeCtrl.markers,
            onCameraMove: homeCtrl.onCameraMove,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                children: <Widget> [
                  FloatingActionButton(
                    child: Icon(Icons.map, size: 36.0),
                    onPressed: homeCtrl.onMapTypeButtonPressed,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: AppTheme.purple,
                    heroTag: null,
                  ),
                  SizedBox(height: 16.0),
                  FloatingActionButton( 
                    child: const Icon(Icons.add_location, size: 36.0),
                    onPressed: homeCtrl.onAddMarkerButtonPressed,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: AppTheme.purple,
                    heroTag: null,
                  ),
                ],
              ),
            ),
          ),
        ],  
      )),
    );

  }

}
