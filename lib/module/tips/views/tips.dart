import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:safe_here_app/global/app_theme.dart';
import 'package:safe_here_app/module/common/controllers/main_ctrl.dart';
import 'package:safe_here_app/module/tips/controllers/tips_ctrl.dart';  
import 'package:safe_here_app/routes/app_routes.dart';

class TipsPage extends StatelessWidget {
  const TipsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    MainController mainCtrl = Get.find();
    TipsController tipsCtrl = Get.find();

    tipsCtrl.context = context;

    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Obx(() => LoadingOverlay(
        isLoading: tipsCtrl.isLoading.value,
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
              child: tipsCtrl.header("Campus Resources")
            ),
            Divider(color: AppTheme.greyLight, height: 1, thickness: 0.5), 
  
            // Scrolling Page Area
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: mainCtrl.campusTipsList.length,
                padding: EdgeInsets.only(top:0, bottom: 50),
                itemBuilder: (_, i){
                  var v = mainCtrl.campusTipsList[i]; 
                  var now = DateTime.now();
                  var inSeconds = now.difference(v.createdDt).inSeconds;
                  var inMinutes = now.difference(v.createdDt).inMinutes;
                  var inHours = now.difference(v.createdDt).inHours;
                  var inDays = now.difference(v.createdDt).inDays;
                  var mDays1 = DateTime(now.year, now.month + 1, 0).day;
                  var mDays2 = DateTime(now.year, now.month + 2, 0).day + mDays1; 
                  var mDays3 = DateTime(now.year, now.month + 3, 0).day + mDays2; 
                  var mDays4 = DateTime(now.year, now.month + 4, 0).day + mDays3; 
                  var mDays5 = DateTime(now.year, now.month + 5, 0).day + mDays4; 
                  var mDays6 = DateTime(now.year, now.month + 6, 0).day + mDays5; 
                  var mDays7 = DateTime(now.year, now.month + 7, 0).day + mDays6; 
                  var mDays8 = DateTime(now.year, now.month + 8, 0).day + mDays7; 
                  var mDays9 = DateTime(now.year, now.month + 9, 0).day + mDays8; 
                  var mDays10 = DateTime(now.year, now.month + 10, 0).day + mDays9; 
                  var mDays11 = DateTime(now.year, now.month + 11, 0).day + mDays10; 
                  var mDays12 = DateTime(now.year, now.month + 12, 0).day + mDays11; 
                  var mDays13 = DateTime(now.year+1, now.month+1, 0).day + mDays12;
                  var mDays14 = (mDays13*2);
                  var dateAgo = '';
                  
                  if(inDays>0) {
                    if(inDays>=1 && inDays<mDays1) {
                      dateAgo = inDays.toString() + ' days ago';
                    } else if(inDays>=mDays1 && inDays<mDays2) {
                      dateAgo = 'about 2 months ago';
                    } else if(inDays>=mDays2 && inDays<mDays3) {
                      dateAgo = '2 months ago';
                    } else if(inDays>=mDays3 && inDays<mDays4) {
                      dateAgo = '3 months ago';
                    } else if(inDays>=mDays4 && inDays<mDays5) {
                      dateAgo = '4 months ago';
                    } else if(inDays>=mDays5 && inDays<mDays6) {
                      dateAgo = '5 months ago';
                    } else if(inDays>=mDays6 && inDays<mDays7) {
                      dateAgo = '6 months ago';
                    } else if(inDays>=mDays7 && inDays<mDays8) {
                      dateAgo = '7 months ago';
                    } else if(inDays>=mDays8 && inDays<mDays9) {
                      dateAgo = '8 months ago';
                    } else if(inDays>=mDays9 && inDays<mDays10) {
                      dateAgo = '9 months ago';
                    } else if(inDays>=mDays10 && inDays<mDays11) {
                      dateAgo = '10 months ago';
                    } else if(inDays>=mDays11 && inDays<mDays12) {
                      dateAgo = '11 months ago';
                    } else if(inDays>=mDays12 && inDays<mDays13) {
                      dateAgo = '12 months ago';
                    } else if(mDays13>=mDays13 && inDays<mDays14) {
                      dateAgo = 'about 1 year ago';
                    } else {
                      dateAgo = 'over 1 year ago';
                    }
                  } else if(inHours>0) {
                    dateAgo = inHours.toString() + ' hours ago';
                  } else if(inMinutes>0) {
                    dateAgo = inMinutes.toString() + ' mins ago';
                  } else if(inSeconds>0) {
                    dateAgo = inSeconds.toString() + ' secs ago';
                  }

                  var title = v.title; 
                     
                  return GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      color: AppTheme.white,
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [ 
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      title,
                                      style: AppTheme.dynamicStyle(color:AppTheme.black, size:16.0, weight: FontWeight.w600)
                                    ),
                                    Text(
                                      dateAgo,
                                      style: AppTheme.dynamicStyle(color:AppTheme.black, size:12.0)
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 5),
                              Icon(Icons.arrow_forward, size:32, color: AppTheme.purpleBlur),
                            ],
                          ),
                          SizedBox(height: 15), 
                          Divider(color: AppTheme.whiteSmoke, thickness:1, height:1),
                        ],
                      ),
                    ),
                    onTap: () async { 
                      tipsCtrl.tipsData = v;
                      tipsCtrl.dateAgo.value = dateAgo;
                      Get.toNamed(Routes.TIPS_DETAILS);
                    },
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
