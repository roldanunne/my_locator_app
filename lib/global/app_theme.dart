// ignore_for_file: prefer_const_constructors, constant_identifier_names
import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color primary = Color(0xFF1F8AE3);
  static const Color background = Color(0xFFECEEF0);
  static const Color white = Color(0xFFFFFFFF);
  static const Color whiteSmoke = Color(0xFFDDE5ED);
  static const Color whiteBlur = Color(0xffdde5ed);
  static const Color whiteOff = Color(0xFFBDBDBD);
  static const Color whiteGrey = Color(0xFFE8E8E8);
  static const Color grey = Color(0xFF4F4D4D);
  static const Color greyDark = Color(0xFF454F65);
  static const Color greyLight = Color(0xFF707070);
  static const Color greyOff = Color(0xFFBFBFBF);
  static const Color greySmoke = Color(0xFFF7F7FA);
  static const Color blue = Color(0xff506de2);
  static const Color blueLight = Color(0xff69D6FF);
  static const Color blueLink = Color(0xff506de2);
  static const Color blueOff = Color(0xffebf5fd);
  static const Color blueSmoke = Color(0xffD6EDFF);
  static const Color blueHaze = Color(0xff99CACB);
  static const Color green = Color(0xFF2DE5B5);
  static const Color red = Color(0xFFF5594F);
  static const Color black = Color(0xFF1A1A1A);
  static const Color blackLight = Color(0x0A1D252D);
  static const Color purple = Color(0xff268ac4);
  static const Color purpleBlur = Color(0xff00afef);
  static const Color purpleLight = Color(0xff71d9ff);
  static const Color pink = Color(0xffF06295);
  static const Color yellow = Color(0xffFECA45);
  static const Color unselectedBarColor = Color(0xff838383);
  static const Color cyan = Color(0xff99CACB);
  static const Color piggyPink = Color(0xffFBDBE8 );
  static const Color volcano = Color(0xffEFDECD);
  static const Color volcanoHaze = Color(0xffe9b077);
  static const Color greyBlue = Color(0xFF454F65);
   

  static dynamicStyle({var color, double size=16.0, var weight=FontWeight.normal, var decoration}) {
    return TextStyle(
      color: color,
      fontFamily: 'SpaceGrotesk',
      fontSize: size,
      fontWeight: weight,
      decoration: decoration,
    );
  }

  static dynamicBoxDecoration({var bgColor=blackLight}) {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: bgColor,
          blurRadius: 34,
          offset:  Offset(0, 2),
        ),
      ]
    );
  }
  
  static containerBoxDecoration({var bgColor=white, var borderColor=whiteSmoke, var borderRadius=8.0} ) {
    return BoxDecoration(
      boxShadow: const [
        BoxShadow(
          color: blackLight,
          blurRadius: 34,
          offset:  Offset(0, 2),
        ),
      ],
      color: bgColor,
      borderRadius: BorderRadius.circular(borderRadius.toDouble()),
      border: Border.all(color: borderColor, style: BorderStyle.solid, width: 1.0),
    );
  }
  
  static underlineBoxDecoration({var color=grey} ) {
    return BoxDecoration(
      border: Border(
          bottom: BorderSide(width: 1.1, color: color),
      ),
    );
  }
  
  static noUnderlineDecoration({var hintText=''}) {
    return InputDecoration(
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      hintText: hintText
    );
  }

  static underlineContainer({color=black, width=1.05}) {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: color,
            width: width,
          ),
        ),
      ),
    );
  }

  static dynamicInputDecoration({var textColor=black, String label='', String hint='', double hintSize=14, var hintColor=black, var suffixIcon, var prefixIcon, var contentPadding,}) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: textColor, 
        fontFamily: 'SpaceGrotesk',
        fontSize: 16
      ),
      hintText: hint,
      hintStyle: TextStyle(
        fontFamily: 'SpaceGrotesk',
        color: hintColor, 
        fontSize: hintSize
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: textColor, 
          width: 1
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: textColor, 
          width: 1
        ),
      ),
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      contentPadding: (contentPadding!=null)?contentPadding:EdgeInsets.fromLTRB(12, 8, 12, 8),
    );
  } 

  static circleContainer({var bgColor=greyLight, var padding=8.0, var child}) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle
      ),
      child: child
    );
  }

  static bottomSheetButtonStyle({primary=white, padding=8.0, double radius=8.0}) {
    return ElevatedButton.styleFrom(
      elevation: 1,
      padding: EdgeInsets.all(padding.toDouble()),
      primary: white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius)
      ),
    );
  }
  
  static avatarProfile({String url='', double height=32.0, double width=32.0}) {
     return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: AppTheme.whiteSmoke,
        shape: BoxShape.circle,
      ),
      child: ExtendedImage.network(
        url,
        fit: BoxFit.fill,
        cache: true, 
        shape: BoxShape.circle,
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
    ); 
  }
  
  static imageContainer({String url='', double height=80.0, double width=80.0, bool isLocal=false, bgColor=AppTheme.whiteSmoke}) {
     return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(1.0),
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.rectangle,
        // borderRadius: BorderRadius.all(Radius.circular(3.0)),
      ),
      child: isLocal
        ? ExtendedImage.file(
          File(url),
          fit: BoxFit.fill,
          shape: BoxShape.rectangle,
          // borderRadius: BorderRadius.all(Radius.circular(3.0)),
        )
        : ExtendedImage.network(
          url,
          fit: BoxFit.fill,
          cache: true, 
          shape: BoxShape.rectangle,
          // borderRadius: BorderRadius.all(Radius.circular(3.0)),
          loadStateChanged: (ExtendedImageState state) {
            switch (state.extendedImageLoadState) {
              case LoadState.failed:
                return GestureDetector(
                  child: Image.asset(
                    "assets/images/no-photo.png",
                    fit: BoxFit.fill,
                  ),
                  onTap: () {
                    state.reLoadImage();
                  },
                );
              case LoadState.loading:
                // Handle this case.
                break;
              case LoadState.completed:
                // Handle this case.
                break;
            }
            return null;
          },
        ),
    ); 
  }
   
}
