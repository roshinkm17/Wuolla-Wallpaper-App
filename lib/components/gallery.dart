import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:wuolla_wallpapers/components/image_card.dart';
import 'package:wuolla_wallpapers/utilities/network_helper.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Gallery extends StatefulWidget {
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  void initState() {
    super.initState();
    checkCache();
  }

  checkCache() async {
    String fileName = 'CacheData.json';
    var cacheDir = await getTemporaryDirectory();
    if (await File(cacheDir.path + '/' + fileName).exists()) {
      //Load the data from cache
      print("Loading from cache....");
      var jsonData = File(cacheDir.path + '/' + fileName).readAsStringSync();
      var data = json.decode(jsonData);
      setState(() {
        desc = data;
      });
      print(data[0]['alt_description']);
    } else {
      //Load the data from API call response
      var response = await network.getDataFromUrl();
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
        print(jsonDecode(response)[0]['alt_description']);
        setState(() {
          desc = jsonDecode(response);
        });
      }
    }
  }

  List desc = [];
  NetworkHelper network = NetworkHelper();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 200) / 2;
    final double itemWidth = size.width / 2;
    return Expanded(
      child: GridView.builder(
        itemCount: desc.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: (itemWidth / itemHeight),
        ),
        itemBuilder: (BuildContext context, int index) {
          return ImageCard(
            imagePreviewUrl: desc[index]['urls']['small'],
            fullImageUrl: desc[index]['urls']['full'],
          );
        },
      ),
    );
  }
}
