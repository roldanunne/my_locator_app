import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:safe_here_app/global/app_theme.dart';
import 'package:safe_here_app/global/gbl_fn.dart';
import 'package:safe_here_app/module/common/controllers/main_ctrl.dart';
import 'package:safe_here_app/module/common/service/api_service.dart';
import 'package:safe_here_app/module/info/controllers/info_ctrl.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    InfoController infoCtrl = Get.find();
    ApiService apiService = Get.find();
    MainController mainCtrl = Get.find();

    final formKey = GlobalKey<FormState>();

    infoCtrl.context = context;  
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Obx(() => LoadingOverlay(
        isLoading: infoCtrl.isLoading.value,
        opacity: 0.5,
        progressIndicator: CircularProgressIndicator(),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Header
              Container(
                color: Colors.white,
                height: 90.0,
                padding: EdgeInsets.fromLTRB(15, 40, 15, 10),
                child: infoCtrl.headerPage("Edit Profile")
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
                        SizedBox(height: 10), 
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
                                style: AppTheme.dynamicStyle(color:AppTheme.purple, size:32.0, weight: FontWeight.w600)
                              ), 
                            ],
                          ),
                        ), 
                        SizedBox(height: 15), 
                        Divider(color: AppTheme.purpleLight, height: 10, thickness: 0.5),
                        SizedBox(height: 10), 
                        TextFormField(
                          controller: infoCtrl.oldpasswordCtrl,
                          decoration: AppTheme.dynamicInputDecoration(
                            label:'Old Password', 
                            textColor: AppTheme.black,
                            suffixIcon: IconButton(
                              onPressed: () {
                                infoCtrl.isObscure.value = !infoCtrl.isObscure.value;
                              },
                              icon: Icon((infoCtrl.isObscure.value)
                                ? Icons.visibility
                                : Icons.visibility_off,
                                size: 16.0
                              ),
                              color: AppTheme.whiteSmoke,
                            ),
                          ),
                          style: AppTheme.dynamicStyle(color: AppTheme.purple, size:16.0),
                          enableSuggestions: false,
                          obscureText: infoCtrl.isObscure.value,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your old password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15),  
                        TextFormField(
                          controller: infoCtrl.passwordCtrl,
                          decoration: AppTheme.dynamicInputDecoration(
                            label:'New Password', 
                            textColor: AppTheme.black,
                            suffixIcon: IconButton(
                              onPressed: () {
                                infoCtrl.isObscure.value = !infoCtrl.isObscure.value;
                              },
                              icon: Icon((infoCtrl.isObscure.value)
                                ? Icons.visibility
                                : Icons.visibility_off,
                                size: 16.0
                              ),
                              color: AppTheme.whiteSmoke,
                            ),
                          ),
                          style: AppTheme.dynamicStyle(color: AppTheme.purple, size:16.0),
                          enableSuggestions: false,
                          obscureText: infoCtrl.isObscure.value,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your new password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15), 
                        TextFormField(
                          controller: infoCtrl.repasswordCtrl,
                          decoration: AppTheme.dynamicInputDecoration(
                            label:'Confirm Password', 
                            textColor: AppTheme.black,
                            suffixIcon: IconButton(
                              onPressed: () {
                                infoCtrl.isObscure.value = !infoCtrl.isObscure.value;
                              },
                              icon: Icon((infoCtrl.isObscure.value)
                                ? Icons.visibility
                                : Icons.visibility_off,
                                size: 16.0
                              ),
                              color: AppTheme.whiteSmoke,
                            ),
                          ),
                          style: AppTheme.dynamicStyle(color: AppTheme.purple, size:16.0),
                          enableSuggestions: false,
                          obscureText: infoCtrl.isObscure.value,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your confirm your password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 35), 
                        // Login
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              ElevatedButton( 
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
                                  if (formKey.currentState!.validate()) {
                                    if(infoCtrl.passwordCtrl.text == infoCtrl.repasswordCtrl.text) {
                                      infoCtrl.submitProfile();
                                    } else {
                                      GblFn.showSnackbar("Error", "Your new password didn't matched. Try again",'error');
                                    }
                                  } else {
                                    GblFn.showSnackbar("Error", "Your email or password is incorrect.",'error');
                                  }
                                },
                              ), 
                              SizedBox(height: 35),
                            ],
                          )
                        )
                      ],
                    ),
                  ),
                ),
              ),  
            ]
          ),  
        ))
      )
    );

  }

}
