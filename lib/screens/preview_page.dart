import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PreviewPage extends StatefulWidget {
  @override
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.transparent,
      //   fixedColor: Colors.black,
      //   items: [
      //     BottomNavigationBarItem(icon: Icon(Icons.add), title: Text('asd')),
      //     BottomNavigationBarItem(icon: Icon(Icons.launch), title: Text('asd'))
      //   ],
      // ),
      body: Stack(
        children: [
          Image.network(
            'https://images.pexels.com/photos/1366919/pexels-photo-1366919.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
            height: double.maxFinite,
            width: double.maxFinite,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: BackButton(),
          ),
          Align(
            alignment: AlignmentDirectional.bottomStart,
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.7),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FaIcon(
                    FontAwesomeIcons.heart,
                    color: Colors.white,
                    size: 30,
                  ),
                  FaIcon(
                    FontAwesomeIcons.heart,
                    color: Colors.white,
                    size: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Dialog();
                      showDialog(
                          context: context,
                          child: Scaffold(
                            backgroundColor: Colors.transparent,
                            body: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Text('Set as'),
                                    SizedBox(
                                      height: 35,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.greenAccent,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      width: 170,
                                      child: Text('Homescreen'),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.greenAccent,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      alignment: Alignment.center,
                                      width: 170,
                                      padding: EdgeInsets.all(10),
                                      child: Text('Lockscreen'),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.greenAccent,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(10),
                                      width: 170,
                                      child: Text('Both'),
                                    ),
                                  ],
                                ),
                                height: 225,
                                width: 200,
                              ),
                            ),
                          ));
                    },
                    child: Icon(
                      Icons.format_paint,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
              height: 75,
              width: double.maxFinite,
            ),
          )
        ],
      ),
    );
  }
}
