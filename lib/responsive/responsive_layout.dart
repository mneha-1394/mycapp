import 'package:flutter/material.dart';
import 'package:test_app/responsive/mobile_screen_layout.dart';
import 'package:test_app/responsive/web_screen_layout.dart';
import 'package:test_app/utils/dimension.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const ResponsiveLayout({super.key, required this.webScreenLayout, required this.mobileScreenLayout});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder:(context, constraints){
      if(constraints.maxWidth> webScreenSize){
         return const WebScreenLayout();
      }
      return const MobileScreenLayout();
    });
  }
}