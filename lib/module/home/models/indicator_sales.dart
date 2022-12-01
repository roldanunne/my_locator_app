import 'package:flutter/material.dart';
import 'package:safe_here_app/global/app_theme.dart';

class IndicatorDashboard extends StatelessWidget {
  final Color color;
  final String text;
  final String desc;
  final bool isSquare;
  final int type;
  final double size;
  final Color textColor;

  const IndicatorDashboard({
    Key? key,
    required this.color,
    required this.text,
    required this.desc,
    this.isSquare = false,
    this.type = 1,
    this.size = 16,
    this.textColor = const Color(0xff505050),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return type==1 ? 
    Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        SizedBox(width: 10),
        Row(
          children: <Widget>[
            Text(
              text,
              style: AppTheme.dynamicStyle(color:textColor, size:24.0) 
            ),
            SizedBox(width: 5),
            Text(
              desc,
              style: AppTheme.dynamicStyle(color:textColor, size:14.0) 
            ),
          ],
        )
      ],
    )
    : type==2 ?
    Column(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        SizedBox(height: 10),
        Text(
          text,
          style: AppTheme.dynamicStyle(color:textColor, size:30.0) 
        ),
        SizedBox(height: 5),
        Text(
          desc,
          style: AppTheme.dynamicStyle(color:textColor, size:20.0) 
        ),
      ],
    )
    : 
    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top:5.0),
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              text,
              style: AppTheme.dynamicStyle(color:textColor, size:24.0) 
            ),
            SizedBox(width: 5),
            Text(
              desc,
              style: AppTheme.dynamicStyle(color:textColor, size:12.0) 
            ),
          ],
        )
      ],
    )
    ;
  }
}