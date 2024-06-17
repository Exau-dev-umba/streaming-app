
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../utils/kcolors.dart';

class MusicDetailPage extends StatefulWidget {
  final String? title;
  final String? description;
  final Color? color;
  final String? img;
  final String? songUrl;

  const MusicDetailPage(
      {Key? key,
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
  final player = AudioPlayer();

  String formaDuration(Duration d){
    final minutes = d.inMinutes.remainder(60);
    final secondes = d.inSeconds.remainder(60);
    return "${minutes.toString().padLeft(2, '0')}: ${secondes.toString().padLeft(2, '0')}";
  }
  void handlePlayPause(){
    if (player.playing){
      player.pause();
    }else{
      player.play();
    }
  }

  void handleSeek(double value){
    player.seek(Duration(seconds: value.toInt()));
  }

  Duration position = Duration.zero;
  Duration duration = Duration.zero;

  @override
  void initState() {
    super.initState();
    player.setAsset(widget.songUrl!);

    player.positionStream.listen((p) {

      setState(() {
        position = p;
      });

    });

    player.durationStream.listen((d) {
      setState(() {
        duration = d!;
      });
    });

    player.playerStateStream.listen((state) {
      if(state.processingState == ProcessingState.completed){
        setState(() {
          position = Duration.zero;
        });
        player.pause();
        player.seek(position);
      }
    });
  }

  // audio player here
  //late AudioPlayer advancedPlayer;
  //late AudioCache audioCache;
  bool isPlaying = true;
  bool isFavorie = true;

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

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
      leading: IconButton(
        onPressed: (){
          Navigator.pop(context);
        },
          icon: Icon(
        Icons.arrow_back,
        color: KColors.white,
      )),
      elevation: 0,
      actions: [
        Row(
          children: [
            IconButton(
                icon: Icon(
                  isFavorie ? Icons.favorite_border : Icons.favorite,
                  color: KColors.white,
                ),
                onPressed: () {
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
                          image: AssetImage(widget.img ?? ""),
                          fit: BoxFit.cover),
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
                        widget.title ?? "",
                        style: TextStyle(
                            fontSize: 18,
                            color: KColors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: 150,
                        child: Text(
                          widget.description ?? "",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              color: KColors.white.withOpacity(0.5)),
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
              value: position.inSeconds.toDouble(),
              min: 0.0,
              max: duration.inSeconds.toDouble(),
              onChanged: handleSeek
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${formaDuration(position)}",
                  style: TextStyle(color: KColors.white.withOpacity(0.5)),
                ),
                Text(
                  "${formaDuration(duration)}",
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
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: KColors.primary),
                      child: Center(
                        child: Icon(
                          player.playing ? Icons.pause : Icons.play_arrow,
                          size: 28,
                          color: KColors.white,
                        ),
                      ),
                    ),
                    onPressed: handlePlayPause
                ),
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
