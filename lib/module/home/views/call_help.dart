import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:safe_here_app/global/app_theme.dart';
import 'package:safe_here_app/module/common/controllers/main_ctrl.dart';
import 'package:safe_here_app/module/home/controllers/home_ctrl.dart';
import 'package:safe_here_app/module/home/service/home_service.dart';

class CallHelpPage extends StatelessWidget {
  const CallHelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    MainController mainCtrl = Get.find();
    HomeController homeCtrl = Get.find();
    HomeService homeService = Get.find();

    homeCtrl.context = context;

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
              child: homeCtrl.headerPage("Emergency Hotline")
            ),
            Divider(color: AppTheme.greyLight, height: 1, thickness: 0.5), 
  
            // Scrolling Page Area
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: mainCtrl.hotlineNumberList.length,
                padding: EdgeInsets.all(20),
                itemBuilder: (_, i){
                  var v = mainCtrl.hotlineNumberList[i];
                  print(v.title);
                  return Container(
                    color: AppTheme.white,
                    margin: EdgeInsets.only(bottom: 15),
                    child: ElevatedButton(
                      child: Row( 
                        children: [  
                          Icon(Icons.phone, size:32, color: AppTheme.white),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  v.title,
                                  style: AppTheme.dynamicStyle(color:AppTheme.white, size:18.0, weight: FontWeight.w600)
                                ), 
                                SizedBox(height: 8), 
                                Text(
                                  v.contact,
                                  style: AppTheme.dynamicStyle(color:AppTheme.white, size:16.0)
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.maxFinite, 90),
                        primary: AppTheme.purple,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                        
                      ),
                      onPressed: () async { 
                        homeService.hotlineId.value = v.id;
                        homeService.hotlineNumber.value = v.contact;
                        homeService.dialHotlineNumber(v.contact);
                        homeService.isLoading.value = true;
                        homeService.submitEmergency(2);
                      },
                    ),  
                  );
                }
              ),
            ),
          ]
        ))
      )
    );

  }

}
