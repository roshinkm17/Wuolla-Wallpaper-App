import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wuolla_wallpapers/constants.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class PreviewPage extends StatefulWidget {
  PreviewPage({this.previewImageUrl, this.downloadImageUrl});
  final String previewImageUrl;
  final String downloadImageUrl;
  @override
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  void initState() {
    super.initState();
    previewImageUrl = widget.previewImageUrl;
    downloadImageUrl = widget.downloadImageUrl;
  }

  Future<String> downloadImage(imageUrl) async {
    var image = await ImageDownloader.downloadImage(imageUrl);
    print("Image Downloaded!");
    String path = await ImageDownloader.findPath(image);
    setState(() {
      isLoading = false;
    });
    return path;
  }

  void setWallpaper(path, typeNumber) async {
    try {
      setState(() {
        isLoading = true;
      });
      final String result = await platform.invokeMethod(
          "helloFromNativeCode", {"path": path, "typeNumber": typeNumber});
      setState(() {
        isLoading = false;
      });
      print(result);
    } catch (e) {
      print(e);
    }
  }

  static const platform = const MethodChannel("flutter.native/helper");
  String previewImageUrl, downloadImageUrl;
  bool isLoading = false;
  Stream<String> progressString;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        progressIndicator: CircularProgressIndicator(
        ),
        child: Stack(
          children: [
            Image.network(
              previewImageUrl,
              height: double.maxFinite,
              width: double.maxFinite,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes
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
                      onPressed: () {
                        setState(() {
                          isLoading = true;
                        });
                        downloadImage(downloadImageUrl);
                        // return CircularProgressIndicator(value: 0,);
                      },
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
                            builder: (context) {
                              return StatefulBuilder(
                                  builder: (context, setState) {
                                    return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  title: Text("Set as"),
                                  actions: <Widget>[
                                    FlatButton(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10,horizontal: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                      ),
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                        String path = await downloadImage(
                                            downloadImageUrl);
                                        setWallpaper(path, 1);
                                      },
                                      color: teritiaryColor,
                                      child: Text(
                                        "Homescreen",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: secondaryColor),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    FlatButton(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                      ),
                                      onPressed: () async {
                                        String path = await downloadImage(
                                            downloadImageUrl);
                                        setWallpaper(path, 2);
                                        setState(() {
                                          isLoading = true;
                                        });
                                      },
                                      color: teritiaryColor,
                                      child: Text(
                                        "Lockscreen",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: secondaryColor),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    FlatButton(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                      ),
                                      onPressed: () async {
                                        String path = await downloadImage(
                                            downloadImageUrl);
                                        setWallpaper(path, 0);
                                        setState(() {
                                          isLoading = true;
                                        });
                                      },
                                      color: teritiaryColor,
                                      child: Text(
                                        "Both",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: secondaryColor),
                                      ),
                                    ),
                                    ],
                                  );
                              });
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
