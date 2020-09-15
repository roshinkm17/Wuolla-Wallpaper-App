import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:wuolla_wallpapers/constants.dart';

class PreviewPage extends StatefulWidget {
  PreviewPage({this.imageUrl});
  final String imageUrl;
  @override
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  void initState() {
    super.initState();
    imageUrl = widget.imageUrl;
  }

  String imageUrl;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        progressIndicator: CircularProgressIndicator(),
        child: Stack(
          children: [
            Image.network(
              imageUrl,
              height: double.maxFinite,
              width: double.maxFinite,
              fit: BoxFit.cover,
              loadingBuilder:
                  (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                        : null,
                  ),
                );
              },
            ),
            SafeArea(
              child: Container(
                margin: EdgeInsets.only(left: 20, top: 20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.4),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: BackButton(
                  color: Colors.white,
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.bottomStart,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.6),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.heart,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.download,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(
                        FontAwesomeIcons.paintRoller,
                        size: 20,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                title: Text("Set as"),
                                content: Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                        width: double.infinity,
                                        child: FlatButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          onPressed: () {},
                                          color: teritiaryColor,
                                          child: Text(
                                            "Homescreen",
                                            style: TextStyle(fontSize: 20, color: secondaryColor),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        child: FlatButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          onPressed: () {},
                                          color: teritiaryColor,
                                          child: Text(
                                            "LockScreen",
                                            style: TextStyle(fontSize: 20, color: secondaryColor),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        child: FlatButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          onPressed: () {},
                                          color: teritiaryColor,
                                          child: Text(
                                            "Both",
                                            style: TextStyle(fontSize: 20, color: secondaryColor),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                    ),
                  ],
                ),
                height: 75,
                width: double.maxFinite,
              ),
            )
          ],
        ),
      ),
    );
  }
}

//GestureDetector(
//onTap: () {
//Dialog();
//showDialog(
//context: context,
//child: Scaffold(
//backgroundColor: Colors.transparent,
//body: Center(
//child: Container(
//decoration: BoxDecoration(
//color: Colors.white,
//borderRadius: BorderRadius.circular(10),
//),
//child: Column(
//children: [
//Text('Set as'),
//SizedBox(
//height: 35,
//),
//Container(
//decoration: BoxDecoration(
//color: Colors.greenAccent,
//borderRadius: BorderRadius.circular(10),
//),
//padding: EdgeInsets.all(10),
//alignment: Alignment.center,
//width: 170,
//child: Text('Homescreen'),
//),
//SizedBox(
//height: 20,
//),
//Container(
//decoration: BoxDecoration(
//color: Colors.greenAccent,
//borderRadius: BorderRadius.circular(10),
//),
//alignment: Alignment.center,
//width: 170,
//padding: EdgeInsets.all(10),
//child: Text('Lockscreen'),
//),
//SizedBox(
//height: 20,
//),
//Container(
//decoration: BoxDecoration(
//color: Colors.greenAccent,
//borderRadius: BorderRadius.circular(10),
//),
//alignment: Alignment.center,
//padding: EdgeInsets.all(10),
//width: 170,
//child: Text('Both'),
//),
//],
//),
//height: 225,
//width: 200,
//),
//),
//));
//},
//child: Icon(
//FontAwesomeIcons.paintRoller,
//color: Colors.white,
//size: 20,
//),
//),
