import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:safe_here_app/global/app_theme.dart';
import 'package:safe_here_app/module/common/controllers/main_ctrl.dart';
import 'package:safe_here_app/module/common/service/api_service.dart';
import 'package:safe_here_app/module/info/controllers/info_ctrl.dart';
import 'package:safe_here_app/routes/app_routes.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    InfoController infoCtrl = Get.find();
    ApiService apiService = Get.find();
    MainController mainCtrl = Get.find();

    infoCtrl.context = context;

    tabList1(){
      return SingleChildScrollView(
        child: Container(
          color: AppTheme.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10),  
              Row( 
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    child: Icon(Icons.manage_accounts, size:32, color: AppTheme.purple),
                    onTap: () {
                      Get.toNamed(Routes.PROFILE_DETAILS);
                    },
                  ),
                  SizedBox(width: 15),
                ]
              ),
              Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 100.0,
                      width: 100.0,
                      padding: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: AppTheme.purpleBlur,
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        padding: EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          color: AppTheme.purpleLight,
                          shape: BoxShape.circle,
                        ),
                        child:  Center(
                          child: Icon(Icons.person, size:90, color: AppTheme.white)
                        ),
                      ),
                    ),
                    SizedBox(height: 10), 
                    Text(
                      apiService.userModel.fname+' '+apiService.userModel.lname,
                      style: AppTheme.dynamicStyle(color:AppTheme.purple, size:40.0, weight: FontWeight.w600)
                    ), 
                  ],
                ),
              ), 
              SizedBox(height: 15), 
              Divider(color: AppTheme.purpleLight, height: 10, thickness: 0.5), 
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "User ID",
                      style: AppTheme.dynamicStyle(color:AppTheme.purpleBlur, size:12.0)
                    ),
                    Text(
                      apiService.userModel.idNo,
                      style: AppTheme.dynamicStyle(color:AppTheme.purple, size:16.0, weight: FontWeight.w600)
                    ), 
                  ],
                ),
              ),
              Divider(color: AppTheme.purpleLight, height: 10, thickness: 0.5), 
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Email",
                      style: AppTheme.dynamicStyle(color:AppTheme.purpleBlur, size:12.0)
                    ),
                    Text(
                      apiService.userModel.email,
                      style: AppTheme.dynamicStyle(color:AppTheme.purple, size:16.0, weight: FontWeight.w600)
                    ), 
                  ],
                ),
              ),
              Divider(color: AppTheme.purpleLight, height: 10, thickness: 0.5), 
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Mobile",
                      style: AppTheme.dynamicStyle(color:AppTheme.purpleBlur, size:12.0)
                    ),
                    Text(
                      apiService.userModel.mobile,
                      style: AppTheme.dynamicStyle(color:AppTheme.purple, size:16.0, weight: FontWeight.w600)
                    ), 
                  ],
                ),
              ),
              Divider(color: AppTheme.purpleLight, height: 10, thickness: 0.5), 
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Gender",
                      style: AppTheme.dynamicStyle(color:AppTheme.purpleBlur, size:12.0)
                    ),
                    Text(
                      apiService.userModel.gender,
                      style: AppTheme.dynamicStyle(color:AppTheme.purple, size:16.0, weight: FontWeight.w600)
                    ), 
                  ],
                ),
              ), 
              Divider(color: AppTheme.purpleLight, height: 10, thickness: 0.5), 
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Date of Birth",
                      style: AppTheme.dynamicStyle(color:AppTheme.purpleBlur, size:12.0)
                    ),
                    Text(
                      formatDate(apiService.userModel.dob, [M, ' ',d, ', ', yyyy]),
                      style: AppTheme.dynamicStyle(color:AppTheme.purple, size:16.0, weight: FontWeight.w600)
                    ), 
                  ],
                ),
              ),
              Divider(color: AppTheme.purpleLight, height: 10, thickness: 0.5), 
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Address",
                      style: AppTheme.dynamicStyle(color:AppTheme.purpleBlur, size:12.0)
                    ),
                    Text(
                      apiService.userModel.address,
                      style: AppTheme.dynamicStyle(color:AppTheme.purple, size:16.0, weight: FontWeight.w600)
                    ), 
                  ],
                ),
              ), 
              Divider(color: AppTheme.purpleLight, height: 10, thickness: 0.5), 
              SizedBox(height: 15),

              GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 15, 5, 15),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Log Out",
                        style: AppTheme.dynamicStyle(color:AppTheme.red, size:16.0, weight: FontWeight.w600)
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.logout, size:28, color: AppTheme.red),
                    ],
                  ),

                ),
                onTap: () {  
                  infoCtrl.storage.erase(); 
                  Get.offAllNamed(Routes.LOGIN);
                },
              ),
              SizedBox(height: 15),
            ], 
          ), 
        ), 
      );
    }
    
    tabList2(){
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Column(
            children: <Widget>[
              HtmlWidget(
                mainCtrl.campusData.about1
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Obx(() => LoadingOverlay(
        isLoading: infoCtrl.isLoading.value,
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
              child: infoCtrl.header("Info")
            ),
            Divider(color: AppTheme.greyLight, height: 1, thickness: 0.5), 
            TabBar(
              controller: infoCtrl.tabController,
              labelColor: AppTheme.white,
              indicator: BoxDecoration(
                color: AppTheme.purple,
              ),
              unselectedLabelColor: AppTheme.purple,
              tabs: [
                Tab(
                  child: Text(
                    "Profile",
                    style: AppTheme.dynamicStyle(size:18.0, weight:FontWeight.w700)
                  )
                ),
                Tab(
                  child: Text(
                    "About",
                    style: AppTheme.dynamicStyle(size:18.0, weight:FontWeight.w700)
                  )
                ),
              ],
            ),
            Divider(color: AppTheme.greyLight, height: 1, thickness: 0.5), 

            // Tab List
            Expanded(
              child: TabBarView(
                controller: infoCtrl.tabController,
                children: [
                  tabList1(),
                  tabList2()
                ],
              ),
            ),
                       
          ]
        ))
      )
    );

  }

}
