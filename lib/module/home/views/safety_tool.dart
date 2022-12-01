import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:safe_here_app/global/app_theme.dart';
import 'package:safe_here_app/module/common/controllers/main_ctrl.dart';
import 'package:safe_here_app/module/home/controllers/home_ctrl.dart';
import 'package:safe_here_app/module/home/service/home_service.dart';

class SafetyToolPage extends StatelessWidget {
  const SafetyToolPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    MainController mainCtrl = Get.find();
    HomeController homeCtrl = Get.find();
    HomeService homeService = Get.find();

    homeCtrl.context = context;
    double imgWH = (MediaQuery.of(context).size.width-50);

    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Obx(() => LoadingOverlay(
        isLoading: homeService.isLoading.value,
        opacity: 0.5,
        progressIndicator: CircularProgressIndicator(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Header
            Container(
              color: Colors.white,
              height: 90.0,
              padding: EdgeInsets.fromLTRB(15, 40, 15, 10),
              child: homeCtrl.headerPage("Safety Toolbox")
            ),
            Divider(color: AppTheme.greyLight, height: 1, thickness: 0.5), 
  
            // Scrolling Page Area
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  color: AppTheme.white,
                  margin: EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 25),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            child: Column( 
                              children: [  
                                Icon(Icons.flashlight_on, size:40, color: AppTheme.white),
                                Text(
                                  "Flashlight",
                                  style: AppTheme.dynamicStyle(color:AppTheme.white, size:18.0, weight: FontWeight.w600)
                                ), 
                              ],
                            ),
                            style: ElevatedButton.styleFrom( 
                              minimumSize: Size((imgWH/2), 100),
                              primary: AppTheme.purple,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)), 
                            ),
                            onPressed: () async { 
                              homeCtrl.tryTorch();
                            },
                          ),  
                          SizedBox(width: 15),
                          ElevatedButton(
                            child: Column(
                              children: <Widget>[
                              Icon(Icons.graphic_eq, size:40, color: AppTheme.white),
                              if(homeCtrl.isPlayingSound.value)
                                SizedBox(
                                  height: 20,
                                  child: AnimatedTextKit(
                                    repeatForever: true,
                                    pause: Duration(milliseconds: 10),
                                    animatedTexts: [
                                      ScaleAnimatedText('Siren', textStyle: AppTheme.dynamicStyle(color:AppTheme.white, size:18.0)),
                                      ScaleAnimatedText('Playing', textStyle: AppTheme.dynamicStyle(color:AppTheme.white, size:18.0)),
                                    ],
                                  ),
                                )
                                else 
                                Text(
                                  "Siren",
                                  style: AppTheme.dynamicStyle(color:AppTheme.white, size:18.0, weight: FontWeight.w600)
                                ), 
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size((imgWH/2), 100),
                              primary: AppTheme.purple,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)), 
                            ),
                            onPressed: () async { 
                              homeCtrl.playEmergency();
                            },
                          ),  
                        ],
                      ),
                      SizedBox(height: 25),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.photo_camera, size:40, color: AppTheme.white),
                                Text(
                                  "Take Photo",
                                  style: AppTheme.dynamicStyle(color:AppTheme.white, size:18.0, weight: FontWeight.w600)
                                ), 
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size((imgWH/2), 100),
                              primary: AppTheme.purple,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)), 
                            ),
                            onPressed: () async { 
                              homeCtrl.takePhoto();
                            },
                          ),  
                          SizedBox(width: 15),
                          ElevatedButton(
                            child: Column( 
                              children: [  
                                Icon(Icons.videocam, size:40, color: AppTheme.white),
                                Text(
                                  "Take Video",
                                  style: AppTheme.dynamicStyle(color:AppTheme.white, size:18.0, weight: FontWeight.w600)
                                ), 
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size((imgWH/2), 100),
                              primary: AppTheme.purple,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)), 
                            ),
                            onPressed: () async { 
                              homeCtrl.recordVideo();
                            },
                          ),  
                        ],
                      ),
                    ]
                  ),
                ),
              ),
            ),
          ]
        ))
      )
    );

  }

}
