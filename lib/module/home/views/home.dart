import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:safe_here_app/global/app_theme.dart';
import 'package:safe_here_app/module/common/controllers/main_ctrl.dart';
import 'package:safe_here_app/module/home/controllers/home_ctrl.dart';
import 'package:safe_here_app/module/home/service/home_service.dart'; 
import 'package:safe_here_app/routes/app_routes.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    MainController mainCtrl = Get.find();
    HomeController homeCtrl = Get.find();
    HomeService homeService = Get.find();

    homeCtrl.context = context;
    double imgWH = (MediaQuery.of(context).size.width-30);

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Obx(() => LoadingOverlay(
        isLoading: homeService.isLoading.value,
        opacity: 0.5,
        progressIndicator: CircularProgressIndicator(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Header
            Container(
              color: AppTheme.white,
              height: 120.0,
              padding: EdgeInsets.fromLTRB(15, 40, 15, 10),
              child: homeCtrl.header("My Locator App")
            ),
            Divider(color: AppTheme.greyLight, height: 1, thickness: 0.5), 
  
            // Scrolling Page Area
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(15.0),
                      color: AppTheme.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ElevatedButton(
                                child: Column( 
                                  children: [
                                    Icon((homeService.isAlertGps.value)?Icons.navigation:Icons.help, size:50),
                                    if(homeService.isAlertGps.value)
                                    SizedBox(
                                      height: 20,
                                      child: AnimatedTextKit(
                                        repeatForever: true,
                                        pause: Duration(milliseconds: 10),
                                        animatedTexts: [
                                          ScaleAnimatedText('Emergency', textStyle: AppTheme.dynamicStyle(color:AppTheme.white, size:18.0)),
                                          ScaleAnimatedText('On Progress', textStyle: AppTheme.dynamicStyle(color:AppTheme.white, size:18.0)),
                                          ScaleAnimatedText('Click to Stop', textStyle: AppTheme.dynamicStyle(color:AppTheme.white, size:18.0)),
                                        ],
                                      ),
                                    )
                                    else 
                                    Text(
                                      "Alert",
                                      style: AppTheme.dynamicStyle(color:AppTheme.white, size:18.0)
                                    ),
                                  ],
                                ),
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(imgWH, 120),
                                  primary: AppTheme.red,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
                                ),
                                onPressed: () async { 
                                  if(!homeService.isAlertGps.value){
                                    // homeService.submitEmergency(1);
                                    homeService.chooseEmergency();
                                  } else {
                                    homeService.stopAlert();
                                  }
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ElevatedButton(
                                child: Column( 
                                  children: [
                                    Icon(Icons.phone, size:50),
                                    Text(
                                      "Emergency Hotlines",
                                      style: AppTheme.dynamicStyle(color:AppTheme.white, size:14.0)
                                    ),
                                  ],
                                ),
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  minimumSize: Size((imgWH/2)-5, 120),
                                  primary: AppTheme.purple, 
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
                                ),
                                onPressed: () async {
                                  await Get.toNamed(Routes.HOME_CALL_HELP);
                                },
                              ),
                              SizedBox(width: 10),
                              ElevatedButton(
                                child:Column( 
                                  children: [
                                    Icon(Icons.report_problem, size:50),
                                    Text(
                                      "Take Action",
                                      style: AppTheme.dynamicStyle(color:AppTheme.white, size:16.0)
                                    ),
                                  ],
                                ),
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  minimumSize: Size((imgWH/2)-5 , 120),
                                  primary: AppTheme.purple, 
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
                                ),
                                onPressed: () async {
                                  await Get.toNamed(Routes.HOME_REPORT);
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ElevatedButton(
                                child: Column( 
                                  children: [
                                    Icon((homeService.isFriendWalkGps.value)?Icons.connect_without_contact:Icons.transfer_within_a_station, size:50),
                                    if(homeService.isFriendWalkGps.value)
                                    SizedBox(
                                      height: 20,
                                      child: AnimatedTextKit(
                                        repeatForever: true,
                                        pause: Duration(milliseconds: 10),
                                        animatedTexts: [
                                          ScaleAnimatedText('Friend Walk', textStyle: AppTheme.dynamicStyle(color:AppTheme.white, size:16.0)),
                                          ScaleAnimatedText('On Progress', textStyle: AppTheme.dynamicStyle(color:AppTheme.white, size:16.0)),
                                          ScaleAnimatedText('Click to Stop', textStyle: AppTheme.dynamicStyle(color:AppTheme.white, size:16.0)),
                                        ],
                                      ),
                                    )
                                    else 
                                    Text(
                                      "Friend Walk",
                                      style: AppTheme.dynamicStyle(color:AppTheme.white, size:16.0)
                                    ),
                                  ],
                                ),
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  minimumSize: Size((imgWH/2)-5, 120),
                                  primary: AppTheme.purple, 
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
                                ),
                                onPressed: () async {
                                  if(!homeService.isFriendWalkGps.value){
                                    homeService.isLoading.value = true;
                                    homeService.submitEmergency(4);
                                  } else {
                                    homeService.stopFriendWalk();
                                  }
                                },
                              ),
                              SizedBox(width: 10),
                              ElevatedButton(
                                child: Column( 
                                  children: [
                                    Icon(Icons.map, size:50),
                                    Text(
                                      "Campus Map",
                                      style: AppTheme.dynamicStyle(color:AppTheme.white, size:16.0)
                                    ),
                                  ],
                                ),
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  minimumSize: Size((imgWH/2)-5, 120),
                                  primary: AppTheme.purple, 
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
                                ),
                                onPressed: () async { 
                                  // Get.toNamed(Routes.HOME_MAP);
                                  Get.toNamed(Routes.HOME_RESOURCES);
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 100),
                        ]
                      )
                    ), 
                  ],
                ),
              ),
            ),
          ]
        ))
      )
    );

  }

}
