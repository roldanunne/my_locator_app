import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:safe_here_app/global/app_theme.dart';
import 'package:safe_here_app/module/tips/controllers/tips_ctrl.dart';

class TipsDetailsPage extends StatelessWidget {
  const TipsDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

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
              child: tipsCtrl.headerPage("Campus Resources")
            ),
            Divider(color: AppTheme.greyLight, height: 1, thickness: 0.5), 
                 
            // Scrolling Page Area
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  color: AppTheme.white,
                  margin: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[   
                      Text(
                        tipsCtrl.tipsData.title,
                        style: AppTheme.dynamicStyle(color:AppTheme.black, size:18.0, weight: FontWeight.w600)
                      ),
                      Text(
                        tipsCtrl.dateAgo.value,
                        style: AppTheme.dynamicStyle(color:AppTheme.greyLight, size:12.0)
                      ),
                      SizedBox(height: 20), 
                      HtmlWidget(
                        tipsCtrl.tipsData.procedure1,
                      ),
                      SizedBox(height: 20), 
                      HtmlWidget(
                        tipsCtrl.tipsData.procedure2,
                      ),
                      SizedBox(height: 20), 
                      HtmlWidget(
                        tipsCtrl.tipsData.procedure3,
                      ),
                      SizedBox(height: 15), 
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
