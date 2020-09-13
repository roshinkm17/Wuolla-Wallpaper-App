import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:wuolla_wallpapers/constants.dart';

class Categories extends StatelessWidget {
  final List<String> keyWords = [
    'Abstract',
    'People',
    'Travel',
    'Patterns',
    'Architecture',
    'Black',
    'Film',
    'Food and Drink',
    'Fashion',
    'Athletics',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: keyWords.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 3),
              child: Chip(
                elevation: 1,
                label: AutoSizeText(
                  keyWords[index],
                  style: TextStyle(color: teritiaryColor),
                  maxLines: 1,
                  minFontSize: 8,
                ),
                backgroundColor: secondaryColor,
              ),
            ),
          );
        },
      ),
    );
  }
}
