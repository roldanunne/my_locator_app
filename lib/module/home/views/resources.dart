import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:safe_here_app/global/app_theme.dart';
import 'package:safe_here_app/module/common/controllers/main_ctrl.dart';
import 'package:safe_here_app/module/home/controllers/home_ctrl.dart';
import 'package:safe_here_app/module/home/service/home_service.dart';
import 'package:safe_here_app/routes/app_routes.dart';

class ResourcesPage extends StatelessWidget {
  const ResourcesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    MainController mainCtrl = Get.find();
    HomeController homeCtrl = Get.find();
    HomeService homeService = Get.find();

    homeCtrl.context = context;

    double imgWH = (MediaQuery.of(context).size.width-40)/2;

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
              child: homeCtrl.headerPage("Campus Map")
            ),
            Divider(color: AppTheme.greyLight, height: 1, thickness: 0.5), 
  
            // Scrolling Page Area
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[ 
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          for (int i = 0; i < mainCtrl.campusResourcesList.length; i++) 
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            child: Container(
                            width:imgWH, 
                            padding: EdgeInsets.all(10),
                              decoration: AppTheme.containerBoxDecoration(bgColor: AppTheme.whiteGrey, borderColor: AppTheme.whiteOff, borderRadius:3.0),
                              child: Column(
                                children: <Widget>[ 
                                  Text(
                                    mainCtrl.campusResourcesList[i].title,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: AppTheme.dynamicStyle(color:AppTheme.purple, size:14.0, weight: FontWeight.w600)
                                  ),
                                  HtmlWidget(
                                    mainCtrl.campusResourcesList[i].procedure1,
                                  ),
                                ]
                              )
                            ), 
                            onTap: () async {   
                             homeCtrl.resourcesData = mainCtrl.campusResourcesList[i];
                             Get.toNamed(Routes.HOME_RESOURCES_DETAILS);
                            },
                          )
                        ]
                      )
                    ]
                  )
                )
              )
            )
          ]
        )
      ))
    );

  }

}
