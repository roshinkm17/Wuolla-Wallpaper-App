import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:wuolla_wallpapers/constants.dart';
import 'package:wuolla_wallpapers/screens/home_page.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class Categories extends StatefulWidget {
  Categories({this.category});
  final category;
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  void initState() {
    super.initState();
    controller = AutoScrollController(
        viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, MediaQuery.of(context).padding.bottom, 0),
        axis: Axis.horizontal);
    setState(() {
      category = widget.category;
      print("This is the category in the Category widget....$category");
    });
    for (int i = 0; i < selectedChip.length; i++) {
      if (keyWords[i] == category) {
        setState(() {
          selectedChip[i] = true;
          selectedIndex = i;
        });
      } else {
        setState(() {
          selectedChip[i] = false;
        });
      }
    }
    scrollToIndex();
  }

  scrollToIndex() async {
    print("Called scroll to index... with selected index $selectedIndex");
    await controller.scrollToIndex(selectedIndex,
        preferPosition: AutoScrollPosition.middle, duration: Duration(seconds: 1));
  }

  int selectedIndex = 0;
  String category;
  final List<String> keyWords = [
    'Popular',
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

  List<bool> selectedChip = [
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  AutoScrollController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: ListView.builder(
        controller: controller,
        scrollDirection: Axis.horizontal,
        itemCount: keyWords.length,
        itemBuilder: (BuildContext context, int index) {
          return AutoScrollTag(
            controller: controller,
            index: index,
            key: ValueKey(index),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage(
                              category: keyWords[index],
                            )));
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 3),
                child: Chip(
                  elevation: 1,
                  label: AutoSizeText(
                    keyWords[index],
                    style: TextStyle(
                        color: selectedChip[index] == true ? secondaryColor : teritiaryColor),
                    maxLines: 1,
                    minFontSize: 8,
                  ),
                  backgroundColor: selectedChip[index] == true ? primaryColor : secondaryColor,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
