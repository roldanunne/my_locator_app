import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:safe_here_app/global/app_theme.dart';
import 'package:safe_here_app/module/login/controllers/login_ctrl.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    LoginController loginCtrl = Get.find();

    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Obx(() => LoadingOverlay(
        isLoading: loginCtrl.isLoading.value,
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
              child: loginCtrl.headerPage("Terms & Condition")
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
                      SizedBox(height: 20), 
                      HtmlWidget(
                        loginCtrl.mainCtrl.campusData.agreement,
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
