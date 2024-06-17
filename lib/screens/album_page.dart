import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';

import '../json/songs_json.dart';
import '../utils/kcolors.dart';
import 'music_detail_page.dart';

class AlbumPage extends StatefulWidget {
  final dynamic song;

  const AlbumPage({Key? key, this.song}) : super(key: key);

  @override
  _AlbumPageState createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.black,
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    List<dynamic> songAlbums = widget.song['songs'] as List<dynamic>;
    List updatedSongs = [
      widget.song,
      ...albums.where((song) => song['title'] != widget.song['title'])
    ];
    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: size.width,
                height: 220,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(widget.song['img'] as String),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.song['title'] as String,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: KColors.white)),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: KColors.grey,
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 12, right: 12, top: 8, bottom: 8),
                            child: Text(
                              "Téléchargé",
                              style: TextStyle(color: KColors.white),
                            ),
                          ),
                        ),
                        // int.parse(widget.song['song_count'] as String, radix: 2) == 1?
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 14),
                            child: IconButton(
                              icon: Icon(
                                Icons.play_circle,
                                color: widget.song['color'] as Color,
                                size: 30,
                              ), onPressed: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      alignment: Alignment.bottomCenter,
                                      child: MusicDetailPage(
                                        title: widget.song['title'] as String,
                                        color: widget.song['color'] as Color,
                                        description:
                                        widget.song['description'] as String,
                                        img: widget.song['img'] as String,
                                        songUrl:
                                        widget.song['song_url'] as String,
                                      ),
                                      type: PageTransitionType.scale));
                            },
                            ))
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(
                    children: List.generate(albums.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    alignment: Alignment.bottomCenter,
                                    child: MusicDetailPage(
                                      title: updatedSongs[index]['title'] as String,
                                      color: updatedSongs[index]['color'] as Color,
                                      description:
                                      updatedSongs[index]['description'] as String,
                                      img: updatedSongs[index]['img'] as String,
                                      songUrl:
                                      updatedSongs[index]['song_url'] as String,
                                    ),
                                    type: PageTransitionType.scale));
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 180,
                                height: 180,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            updatedSongs[index]['img'] as String),
                                        fit: BoxFit.cover),
                                    color: KColors.primary,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                updatedSongs[index]['title'] as String,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: KColors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: size.width - 210,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      albums[index]['song_count'] as String,
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: KColors.grey,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      updatedSongs[index]['date'] as String,
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: KColors.grey,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                  children: List.generate(songAlbums.length, (index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 30, right: 30, bottom: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              alignment: Alignment.bottomCenter,
                              child: MusicDetailPage(
                                title: songAlbums[index]['title'] as String,
                                color: songAlbums[index]['color'] as Color,
                                description:
                                songAlbums[index]['description'] as String,
                                img: songAlbums[index]['img'] as String,
                                songUrl: songAlbums[index]['song_url'] as String,
                              ),
                              type: PageTransitionType.scale));
                    },
                    child: Row(
                      children: [
                        Container(
                          width: (size.width - 60) * 0.77,
                          child: Text(
                            "${index + 1}  " + songAlbums[index]['title'],
                            style: TextStyle(color: KColors.white),
                          ),
                        ),
                        Container(
                          width: (size.width - 60) * 0.23,
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                songAlbums[index]['duration'] as String,
                                style: TextStyle(
                                    color: KColors.grey, fontSize: 14),
                              ),
                              Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: KColors.grey.withOpacity(0.8),
                                ),
                                child: Center(
                                    child: Icon(
                                  Icons.play_arrow,
                                  color: KColors.white,
                                  size: 16,
                                )),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }))
            ],
          ),
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: KColors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                IconButton(
                    icon: Icon(
                      Icons.more_vert,
                      color: KColors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}
