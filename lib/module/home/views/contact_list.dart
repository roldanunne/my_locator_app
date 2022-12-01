import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:safe_here_app/global/app_theme.dart';
import 'package:safe_here_app/global/gbl_fn.dart';
import 'package:safe_here_app/module/common/controllers/main_ctrl.dart';
import 'package:safe_here_app/module/home/controllers/home_ctrl.dart';
import 'package:safe_here_app/module/home/service/home_service.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    MainController mainCtrl = Get.find();
    HomeController homeCtrl = Get.find();
    HomeService homeService = Get.find();

    homeCtrl.context = context;

    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Obx(() => LoadingOverlay(
        isLoading: homeCtrl.isLoading.value,
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
              child: homeCtrl.headerAddPage("Contact List")
            ),
            Divider(color: AppTheme.greyLight, height: 1, thickness: 0.5), 
  
            // Scrolling Page Area
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: mainCtrl.userContactList.length,
                padding: EdgeInsets.all(20),
                itemBuilder: (_, i){
                  var v = mainCtrl.userContactList[i]; 
                  return Container(
                    color: AppTheme.white,
                    margin: EdgeInsets.only(bottom: 15),
                    child: ElevatedButton(
                      child: Row( 
                        children: [  
                          Icon(Icons.phone, size:28, color: AppTheme.white),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  v.name,
                                  style: AppTheme.dynamicStyle(color:AppTheme.white, size:16.0, weight: FontWeight.w600)
                                ), 
                                Text(
                                  v.contact,
                                  style: AppTheme.dynamicStyle(color:AppTheme.white, size:14.0)
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            child: Icon(Icons.edit_note, size:28, color: AppTheme.piggyPink),
                            onTap: () { 
                              GblFn.bottomSheet(homeCtrl.contactBottomSheet('Edit',v));
                            },
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            child: Icon(Icons.close, size:28, color: AppTheme.red),
                            onTap: () { 
                            },
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.maxFinite, 70),
                        primary: AppTheme.purple,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                        
                      ),
                      onPressed: () async { 
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
