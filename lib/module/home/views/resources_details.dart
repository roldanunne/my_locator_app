import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:safe_here_app/global/app_theme.dart';
import 'package:safe_here_app/module/common/controllers/main_ctrl.dart';
import 'package:safe_here_app/module/home/controllers/home_ctrl.dart';

class ResourcesDetailsPage extends StatelessWidget {
  const ResourcesDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    HomeController homeCtrl = Get.find();

    homeCtrl.context = context;  

    double sizeH = (MediaQuery.of(context).size.height-150);

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
              child: homeCtrl.headerPage("Campus Map")
            ),
            Divider(color: AppTheme.greyLight, height: 1, thickness: 0.5), 
                 
            // Scrolling Page Area
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  color: AppTheme.white,
                  margin: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[   
                      SizedBox(height: 20), 
                      Text(
                        homeCtrl.resourcesData.title,
                        style: AppTheme.dynamicStyle(color:AppTheme.black, size:18.0, weight: FontWeight.w600)
                      ), 
                      SizedBox(height: 20), 
                      InteractiveViewer(
                        boundaryMargin: const EdgeInsets.all(20.0),
                        minScale: 0.1,
                        maxScale: 1.6,
                        child: SizedBox(
                          height: sizeH,
                          child: HtmlWidget(
                            homeCtrl.resourcesData.procedure1,
                          )
                        ),
                      ),
                    ],
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
