import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: unused_import
import 'package:image_cropper/image_cropper.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:safe_here_app/global/app_theme.dart';
import 'package:safe_here_app/global/gbl_fn.dart';
import 'package:safe_here_app/module/home/controllers/home_ctrl.dart';
import 'package:safe_here_app/module/home/service/home_service.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    HomeService homeService = Get.find();
    HomeController homeCtrl = Get.find();
    homeCtrl.context = context;

    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Obx(() => LoadingOverlay(
        isLoading: homeService.isLoading.value,
        opacity: 0.5,
        progressIndicator: CircularProgressIndicator(),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              // Header
              Container(
                // color: AppTheme.white,
                height: 90.0,
                padding: EdgeInsets.fromLTRB(15, 40, 15, 10),
                child: homeCtrl.headerPage("Report")
              ),
              Divider(color: AppTheme.greyLight, height:1, thickness:0.3),

              // Scrolling Page Area
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 15),
                        
                        // Subject  
                        TextFormField(
                          controller: homeService.subjectCtrl,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            hintText: 'Subject',
                            hintStyle: AppTheme.dynamicStyle(color: AppTheme.whiteOff, size:16.0),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppTheme.whiteBlur,
                                width: 1,
                              ),
                            ),
                          ),
                          style: AppTheme.dynamicStyle(color: AppTheme.black, size:16.0), 
                        ),
                        SizedBox(height: 20),
                        
                        // Details  
                        TextFormField(
                          controller: homeService.detailsCtrl,
                          keyboardType: TextInputType.multiline,
                          minLines: 4,
                          maxLines: null,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            hintText: 'Enter details of the incident here',
                            hintStyle: AppTheme.dynamicStyle(color: AppTheme.whiteOff, size:14.0),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppTheme.whiteBlur,
                                width: 1,
                              ),
                            ),
                          ),
                          style: AppTheme.dynamicStyle(color: AppTheme.black, size:18.0), 
                        ),
                        SizedBox(height: 20),

                        if (homeService.fileList.isNotEmpty)
                        ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(bottom: 10),
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: homeService.fileList.length,
                          itemBuilder: (context, i) {
                            var filename = homeService.fileList[0].path.split('/').last;
                            return Container(
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: AppTheme.purpleLight,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.all(10),
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.file(File(homeService.fileList[i].path),
                                    fit: BoxFit.fill,
                                    width: 60.0
                                  ),
                                ),
                                title: Text(
                                  filename,
                                  style: AppTheme.dynamicStyle(color: AppTheme.purple, size:14.0)
                                ),
                                trailing: ElevatedButton(
                                  child: Icon(Icons.close, color: AppTheme.purple),
                                  style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    padding: EdgeInsets.all(8),
                                    primary: AppTheme.white, 
                                  ),
                                  onPressed: () {
                                    homeService.fileList.removeAt(i);
                                  },
                                ),
                              )
                            );
                          }
                        ),
                        SizedBox(height: 10),
                        
                        Container(
                          color: AppTheme.white,
                          margin: EdgeInsets.only(bottom: 15),
                          child: ElevatedButton(
                            child: Row( 
                              children: [  
                                Icon(Icons.drive_folder_upload, size: 32, color: AppTheme.white),
                                SizedBox(width: 25),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Select Photos",
                                        style: AppTheme.dynamicStyle(color:AppTheme.purple, size:18.0)
                                      ), 
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.maxFinite, 60),
                              primary: AppTheme.purpleLight,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                            ),
                            onPressed: () async { 
                              GblFn.bottomSheet(homeCtrl.cameraBottomSheet());
                            },
                          ),  
                        ),
                        SizedBox(height: 25),

                        Align(
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton( 
                            child: Text(
                              "Submit",
                              style: AppTheme.dynamicStyle(color: AppTheme.white, size:18.0, weight:FontWeight.w700)
                            ),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.maxFinite, 50),
                              primary: AppTheme.purple,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                            ),
                            onPressed: () async {
                              if(homeService.subjectCtrl.text.isEmpty) { 
                                GblFn.showSnackbar("Oops", "Please add subject of this incident report!",'error');
                              } else if(homeService.detailsCtrl.text.isEmpty) { 
                                GblFn.showSnackbar("Oops", "Please add details of this incident report!",'error');
                              } else {
                                homeService.isLoading.value = true;
                                homeService.submitEmergency(3);
                              }
                            },
                          )
                        ), 
                        SizedBox(height: 25),

                      ],
                    ),
                  ),
                ),
              ),
              
            ]
          ),
        )
      ))
    );

  }

}
