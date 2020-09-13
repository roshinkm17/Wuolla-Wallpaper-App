import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wuolla_wallpapers/components/categories.dart';
import 'package:wuolla_wallpapers/components/gallery.dart';
import 'package:wuolla_wallpapers/components/search_field.dart';
import 'package:wuolla_wallpapers/constants.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 40, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AutoSizeText(
                "Wallpapers",
                style: TextStyle(fontSize: 26, color: primaryColor, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              SearchField(),
              SizedBox(
                height: 20,
              ),
              Categories(),
              SizedBox(height: 20),
              Gallery(),
            ],
          ),
        ),
      ),
    );
  }
}
