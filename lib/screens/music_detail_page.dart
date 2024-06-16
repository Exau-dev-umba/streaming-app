import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../utils/kcolors.dart';

class MusicDetailPage extends StatefulWidget {
  final String? title;
  final String? description;
  final Color? color;
  final String? img;
  final String? songUrl;

  const MusicDetailPage(
      { Key? key,
       this.title,
       this.description,
       this.color,
       this.img,
       this.songUrl})
      : super(key: key);
  @override
  _MusicDetailPageState createState() => _MusicDetailPageState();
}

class _MusicDetailPageState extends State<MusicDetailPage> {
  double _currentSliderValue = 20;

  // audio player here
  //late AudioPlayer advancedPlayer;
  late AudioCache audioCache;
  bool isPlaying = true;
  bool isFavorie = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.black,
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  AppBar getAppBar() {
    return AppBar(
      backgroundColor: KColors.black,
      leading: Icon(Icons.arrow_back, color: KColors.white,),
      elevation: 0,
      actions: [
        Row(
          children: [
            IconButton(
                icon: Icon(
                  isFavorie?
                  Icons.favorite_border:
                  Icons.favorite,
                  color: KColors.white,
                ),
                onPressed: (){
                  if (isFavorie) {
                    setState(() {
                      isFavorie = false;
                    });
                  } else {
                    setState(() {
                      isFavorie = true;
                    });
                  }
                }),
            IconButton(
                icon: Icon(
                  Icons.more_vert,
                  color: KColors.white,
                ),
                onPressed: null),
          ],
        )
      ],
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                child: Container(
                  width: size.width - 100,
                  height: size.width - 100,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: widget.color!,
                        blurRadius: 50,
                        spreadRadius: 5,
                        offset: Offset(-10, 40))
                  ], borderRadius: BorderRadius.circular(20)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                child: Container(
                  width: size.width - 60,
                  height: size.width - 60,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(widget.img??""), fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(20)),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
              width: size.width - 80,
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.create_new_folder_rounded,
                    color: KColors.white,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        widget.title??"",
                        style: TextStyle(
                            fontSize: 18,
                            color: KColors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: 150,
                        child: Text(
                          widget.description??"",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15, color: KColors.white.withOpacity(0.5)),
                        ),
                      )
                    ],
                  ),
                  Icon(
                    Icons.more_vert,
                    color: KColors.white,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Slider(
              activeColor: KColors.primary,
              value: _currentSliderValue,
              min: 0,
              max: 200,
              onChanged: (value) {
                setState(() {
                  _currentSliderValue = value;
                });
                // seekSound();
              }),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "1:50",
                  style: TextStyle(color: KColors.white.withOpacity(0.5)),
                ),
                Text(
                  "4:68",
                  style: TextStyle(color: KColors.white.withOpacity(0.5)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.shuffle,
                      color: KColors.white.withOpacity(0.8),
                      size: 25,
                    ),
                    onPressed: null),
                IconButton(
                    icon: Icon(
                      Icons.skip_previous,
                      color: KColors.white.withOpacity(0.8),
                      size: 25,
                    ),
                    onPressed: null),
                IconButton(
                    iconSize: 50,
                    icon: Container(
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, color: KColors.primary),
                      child: Center(
                        child: Icon(
                          isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          size: 28,
                          color: KColors.white,
                        ),
                      ),
                    ),
                    onPressed: () async{
                      if (isPlaying) {
                        setState(() {
                          isPlaying = false;
                        });
                      } else {
                        // playSound(widget.songUrl);
                        setState(() {
                          isPlaying = true;
                        });
                      }
                    }),
                IconButton(
                    icon: Icon(
                      Icons.skip_next,
                      color: KColors.white.withOpacity(0.8),
                      size: 25,
                    ),
                    onPressed: null),
                IconButton(
                    icon: Icon(
                      Icons.repeat_sharp,
                      color: KColors.white.withOpacity(0.8),
                      size: 25,
                    ),
                    onPressed: null)
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.tv,
                color: KColors.primary,
                size: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Text(
                  "Chromecast is ready",
                  style: TextStyle(color: KColors.primary),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
