import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wuolla_wallpapers/components/image_card.dart';
import 'package:wuolla_wallpapers/constants.dart';
import 'package:wuolla_wallpapers/utilities/network_helper.dart';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Gallery extends StatefulWidget {
  Gallery({this.queryTerm});
  final String queryTerm;
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
      print("The value of isLoading is $isLoading....");
      queryTerm = widget.queryTerm == null ? 'wallpaper' : widget.queryTerm;
      fileName = 'CacheData_$queryTerm$cachePageNumber.json';
    });
    print('This is the query term in gallery widget $queryTerm......');
    print('This is the cache page name....$fileName');
    if (queryTerm == 'wallpaper') {
      checkCache();
    } else {
      getCategoryImages();
    }
    _controller.addListener(() async {
      if (_controller.position.atEdge) {
        if (_controller.position.pixels != 0) {
          print("Reached the bottom of the page Bottom....");
          //cache the next 30 images
          setState(() {
            page++;
            cachePageNumber++;
            fileName = 'CacheData_$queryTerm$cachePageNumber.json';
          });
          var response = await network.getDataFromUrl(page, queryTerm);
          if (response == 404) {
            print("Some error....");
          } else {
            setState(() {});
            print("Got next page $page...");
            print("Adding to new cache file $fileName");
            var cacheDir = await getTemporaryDirectory();
            File file = new File(cacheDir.path + '/' + fileName);
            file.writeAsString(
              response,
              flush: true,
              mode: FileMode.write,
            );
            print("Caching done...");
            setState(() {
              imageDataList['results'].addAll(jsonDecode(response)['results']);
            });
          }
        }
      }
    });
  }

  void getCategoryImages() async {
    var cacheDir = await getTemporaryDirectory();
    if (await File(cacheDir.path + '/' + fileName).exists()) {
      //Load the data from cache
      imageDataList['results'] = [];
      print("Loading from cache....");
      while (true) {
        if (await File(cacheDir.path + '/' + fileName).exists()) {
          print("Loading from cache page............from $fileName");
          var jsonData = await File(cacheDir.path + '/' + fileName).readAsString();
          setState(() {
            imageDataList['results'].addAll(jsonDecode(jsonData)['results']);
            cachePageNumber++;
            fileName = 'CacheData_$queryTerm$cachePageNumber.json';
          });
        } else {
          break;
        }
      }
    } else {
      var response = await network.getDataFromUrl(page, queryTerm);
      if (response == 404) {
        print("Some Error.....");
      } else {
        print("Got API response.....");
        print("Creating its cache....in cacheFile $fileName");
        var tempDir = await getTemporaryDirectory();
        File file = new File(tempDir.path + '/' + fileName);
        file.writeAsString(
          response,
          flush: true,
          mode: FileMode.write,
        );
        print("Data cached...");
        setState(() {
          imageDataList = jsonDecode(response);
        });
      }
    }
    setState(() {
      isLoading = false;
    });
    print("The value of isLoading is $isLoading....");
  }

  checkCache() async {
    try{
      var cacheDir = await getTemporaryDirectory();
      if (await File(cacheDir.path + '/' + fileName).exists()) {
        //Load the data from cache
        imageDataList['results'] = [];
        print("Loading from cache....");
        while (true) {
          if (await File(cacheDir.path + '/' + fileName).exists()) {
            print("Loading from cache page............from $fileName");
            var jsonData = await File(cacheDir.path + '/' + fileName).readAsString();
            setState(() {
              imageDataList['results'].addAll(jsonDecode(jsonData)['results']);
              cachePageNumber++;
              fileName = 'CacheData_$queryTerm$cachePageNumber.json';
            });
          } else {
            break;
          }
        }
      } else {
        //Load the data from API call response
        var response = await network.getDataFromUrl(page, queryTerm);
        if (response == 404) {
          print("Some Error.....");
        } else {
          print("Got API response.....");
          print("Creating its cache....");
          var tempDir = await getTemporaryDirectory();
          File file = new File(tempDir.path + '/' + fileName);
          file.writeAsString(
            response,
            flush: true,
            mode: FileMode.write,
          );
          print("Data cached...");
          setState(() {
            imageDataList = jsonDecode(response);
          });
        }
      }
      setState(() {
        isLoading = false;
      });
    }catch(e){
      print(e);
    }
  }

  bool isLoading = false;
  String queryTerm;
  int cachePageNumber = 0;
  String fileName;
  int page = 1;
  Map imageDataList = {};
  NetworkHelper network = NetworkHelper();
  var _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 200) / 2;
    final double itemWidth = size.width / 2;
    return Expanded(
      child: Stack(
        children: <Widget>[
          isLoading == false
              ? GridView.builder(
                  controller: _controller,
                  itemCount: imageDataList['results'] == null ? 0 : imageDataList['results'].length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: (itemWidth / itemHeight),
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return ImageCard(
                      imagePreviewUrl: imageDataList['results'][index]['urls']['small'],
                      regularImageUrl: imageDataList['results'][index]['urls']['regular'],
                      fullImageUrl: imageDataList['results'][index]['urls']['full'],
                    );
                  },
                )
              : Center(
                  child: SpinKitCubeGrid(
                    color: primaryColor,
                    size: 50,
                  ),
                ),
        ],
      ),
    );
  }
}
