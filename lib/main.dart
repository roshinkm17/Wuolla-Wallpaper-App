import 'package:flutter/material.dart';
import 'package:wuolla_wallpapers/screens/home_page.dart';
import 'package:wuolla_wallpapers/utilities/portarit_locker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget with PortraitModeMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
