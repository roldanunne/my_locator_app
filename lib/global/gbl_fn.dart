import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:safe_here_app/global/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';

class GblFn {
  GblFn._();
  
  static pushReplacement(BuildContext context, var page) {
    return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));
  }

  static pushScreen(BuildContext context, var page) {
    return Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  static pop(BuildContext context) {
    return Navigator.pop(context);
  }


  static loadingIndicator() {
    return  Padding(
      padding: EdgeInsets.fromLTRB(0,5,0,3),
      child: Center(
        child: Opacity(
          opacity: 0.8,
          child: LinearProgressIndicator(color:AppTheme.primary, minHeight:2),
        ),
      ),
    );
  }

  static showSnackbar(title, message,[var type = 'normal']){
    var bg = Color(0xFFe2e3e5);
    var tc = Color(0xFF41464b);
    if(type == 'success'){
      bg = Color(0xFFd4edda);
      tc = Color(0xFF0f5132);
    } else if(type == 'warning'){
      bg = Color(0xFFfff3cd);
      tc = Color(0xFF664d03);
    } else if(type == 'error'){
      bg = Color(0xFFf8d7da);
      tc = Color(0xFF842029);
    } else if(type == 'info'){
      bg = Color(0xFFcff4fc);
      tc = Color(0xFF055160);
    }
    Get.snackbar(
      title,
      message,
      margin: EdgeInsets.fromLTRB(20, 20, 20, 80 ),
      colorText: tc,
      backgroundColor: bg,
      duration: Duration(seconds: 3),
      isDismissible: true,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  static Future<dynamic> bottomSheet(var bottomsheet) {
    return Get.bottomSheet(
      bottomsheet,
      elevation: 20.0,
      isScrollControlled: true,
      backgroundColor: Color(0xFFf9f9fb),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        )
      ) 
    );        
  }

  static showDialogView({var content}) async {
    return await Get.defaultDialog( 
      radius: 10,
      title: "",
      titlePadding: EdgeInsets.all(0),
      contentPadding: EdgeInsets.fromLTRB(20,0,20,10), 
      barrierDismissible: false,
      content: WillPopScope(
        onWillPop: () async => false,
        child: content
      ) 
    );
  }   

  static showDefaultDialog({String type="", String title="", String btnYesLabel="Yes", String btnNoLabel="No", var content}) async {
    return await Get.defaultDialog( 
      title: '',
      titlePadding: EdgeInsets.all(0),
      contentPadding: EdgeInsets.fromLTRB(20,0,20,20), 
      content: WillPopScope(
        onWillPop: () async => false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            (type=="success")?Icon(Icons.check, size: 90.0, color: AppTheme.purple):Icon(Icons.error, size: 90.0, color: AppTheme.red),
            Text(title, style: AppTheme.dynamicStyle(color: AppTheme.purple, size:20.0, weight:FontWeight.w600)),
            SizedBox(height: 15),
            content,
            SizedBox(height: 15),
            if(btnYesLabel!='') ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(180, 45),
                primary: AppTheme.purple,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
              onPressed: () {
                Get.back(result: true);
              },
              child: Text(btnYesLabel, style: AppTheme.dynamicStyle(color: AppTheme.white, size:18.0)),
            ),
            if(btnNoLabel!='') SizedBox(height: 12),
            if(btnNoLabel!='')
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(180, 45),
                primary: AppTheme.red,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
              onPressed: () {
                Get.back(result: false);
              },
              child: Text(btnNoLabel, style: AppTheme.dynamicStyle(color: AppTheme.white, size:18.0)),
            ),
          ],
        )
      ) 
    );
  }
  
  static bottomNavigationBarItem(activeIcon, icon, label, hasNotif) {
    return BottomNavigationBarItem(
      activeIcon: Icon(activeIcon, size:32, color:AppTheme.purple),
      icon: Icon(icon, size:32, color:AppTheme.purpleBlur),
      label: label,
    ); 
  }

  static bool isValidMobile(String value) {
      String pattern = r'(^\+?966[0-9]{9}$)';
      RegExp regExp = RegExp(pattern);
      if (value.isEmpty || !regExp.hasMatch(value)) {
           false;
      }
      return true;
  }   

  static bool isValidEmail(String value) {
      String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = RegExp(pattern);
      if (value.isEmpty || !regExp.hasMatch(value)) {
        return false;
      }
      return true;
  } 

  static toProperCase(String text) {
    List arrayPieces = [];
    String outPut = '';      
    text = text.toLowerCase().trim();

    text.split(' ').forEach((sepparetedWord) {
      if(sepparetedWord!='') arrayPieces.add(sepparetedWord);
    });

    for (var word in arrayPieces) {
      word = "${word[0].toString().toUpperCase()}${word.toString().substring(1)} ";
      outPut += word;
    }
    return outPut.trim();
  }

  
  static getMimeType(String path) {
    final mimeType = lookupMimeType(path);
    if(mimeType!=null){
      var arr = mimeType.split(RegExp('/'));
      return arr.first;
    }
    return;
  }

  static downloadFile(String link) async {
    final Uri url = Uri.parse(link);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
    GblFn.showSnackbar("Error!", "This file is not available!");
    }
  } 
  
  static bool isDate(String dt) {
    try {
      final date = DateTime.parse(dt);
      final y = date.year.toString().padLeft(4, '0');
      final m = date.month.toString().padLeft(2, '0');
      final d = date.day.toString().padLeft(2, '0');
      final newDt = "$y-$m-$d";
      return dt == newDt;
    } catch (e) {
      return false;
    }
  }
  
  static int dtCalculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day).difference(DateTime(now.year, now.month, now.day)).inDays;
    // Uses
    // Yesterday : calculateDifference(date) == -1
    // Today : calculateDifference(date) == 0
    // Tomorrow : calculateDifference(date) == 1
  }
  
  static delayPage({int sec=3}) async {
    await Future.delayed(Duration(seconds: sec));
  }

  static String getDateTime(String dt){
    print('== $dt');
    dt = dt.replaceAll("06:00:00","14:00");
    print('== $dt');
    return dt;
  }

  static String removeUrl(String str){
    final newString = str.replaceAll(RegExp(r"(http|ftp|https)://([\w_-]+(?:(?:\.[\w_-]+)+))([\w.,@?^=%&:/~+#-]*[\w@?^=%&/~+#-])?"), "");
    return newString;
  }
  
  static Future<String> getFileUrl(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    return "${directory.path}/$fileName";
  }

  static linearPercent(double value) {
    try{
      var percent = 0.0;
      if(value >= 0 && value <= 999){
        percent = 0.1;
      } else if(value >= 1000 && value <= 9999){
        percent = 0.01;
      } else if(value >= 10000 && value <= 99999){
        percent = 0.001;
      } else if(value >= 100000 && value <= 999999){
        percent = 0.0001;
      } else if(value >= 1000000 && value <= 9999999){
        percent = 0.00001;
      } else if(value >= 10000000 && value <= 99999999){
        percent = 0.000001;
      } else if(value >= 100000000 && value <= 999999999){
        percent = 0.000001;
      } else if(value >= 1000000000 && value <= 9999999999){
        percent = 0.0000001;
      } else if(value >= 10000000000 && value <= 99999999999){
        percent = 0.00000001;
      } else if(value >= 100000000000 && value <= 999999999999){
        percent = 0.000000001;
      }
      return (value/100)*percent;
    }catch(e){
      print(e);
    }
  }
  static linearPercentMax(double value) {
    try{
      String max = '0';
      if(value >= 0 && value <= 999){
        max = '1K';
      } else if(value >= 1000 && value <= 9999){
        max = '10K';
      } else if(value >= 10000 && value <= 99999){
        max = '100K';
      } else if(value >= 100000 && value <= 999999){
        max = '1M';
      } else if(value >= 1000000 && value <= 9999999){
        max = '10M';
      } else if(value >= 10000000 && value <= 99999999){
        max = '100M';
      } else if(value >= 100000000 && value <= 999999999){
        max = '1B';
      } else if(value >= 1000000000 && value <= 9999999999){
        max = '10B';
      } else if(value >= 10000000000 && value <= 99999999999){
        max = '100B';
      } else if(value >= 100000000000 && value <= 999999999999){
        max = '1T';
      }
      return max;
    }catch(e){
      print(e);
    }
  }

  //Generate Random alphanumeric
  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static Random _rnd = Random();
  static String getRandomString(int length){
     return String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length)))
    );
  }
  
}
