import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wuolla_wallpapers/constants.dart';

class SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        onChanged: (value) {},
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 20),
          fillColor: secondaryColor,
          hintText: "Search Nature, Travel, People",
          hintStyle: TextStyle(color: teritiaryColor.withAlpha(70)),
          suffixIcon: Icon(
            Icons.search,
            color: teritiaryColor,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(40),
          ),
          filled: true,
        ),
      ),
    );
  }
}
