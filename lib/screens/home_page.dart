import 'package:flutter/material.dart';
import 'package:login_register_app/values/app_colors.dart';
import 'package:page_transition/page_transition.dart';

import '../json/songs_json.dart';
import '../utils/kcolors.dart';
import 'album_page.dart';
import 'music_detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activeMenu1 = 0;
  int activeMenu2 = 0;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: KColors.black,
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  AppBar getAppBar() {
    return AppBar(
      backgroundColor: KColors.black,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Explorer",
              style: TextStyle(
                  fontSize: 20,
                  color: KColors.white,
                  fontWeight: FontWeight.bold),
            ),
            Icon(
              Icons.list,
              color: KColors.white,
            )
          ],
        ),
      ),
    );
  }

  Widget _tabBar() {
    return DefaultTabController(
      length: song_type_1.length,
      child: Scaffold(
        backgroundColor: KColors.black,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverAppBar(
                title: Text('Home'),
                pinned: true,
                floating: true,
                bottom: TabBar(
                  tabAlignment: TabAlignment.start,
                  dividerColor: KColors.transparent,
                  indicatorColor: KColors.primary,
                  isScrollable: true,
                  tabs: List.generate(song_type_1.length, (index) {
                    return Tab(child: Text(song_type_1[index]));
                  }),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: List.generate(albums.length - 5, (index) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(
                    children: List.generate(albums.length - 5, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    alignment: Alignment.bottomCenter,
                                    child: MusicDetailPage(
                                      title: songs_single[index]['title']
                                      as String,
                                      color: songs_single[index]['color']
                                      as Color,
                                      description: songs_single[index]
                                      ['description'] as String,
                                      img: songs_single[index]['img']
                                      as String,
                                      songUrl: songs_single[index]['song_url']
                                      as String,
                                    ),
                                    type: PageTransitionType.scale));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 180,
                                height: 180,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(songs_single[index]
                                        ['img'] as String),
                                        fit: BoxFit.cover),
                                    color: KColors.primary,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                songs_single[index]['title'] as String,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: KColors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: 180,
                                child: Text(
                                  songs_single[index]['description']
                                  as String,
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: KColors.grey,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: AppColors.defaultGradient)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, top: 20),
                    child: Row(
                        children: List.generate(song_type_1.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 25),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              activeMenu1 = index;
                            });
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                song_type_1[index] as String,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: activeMenu1 == index
                                        ? KColors.primary
                                        : KColors.grey,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              activeMenu1 == index
                                  ? Container(
                                      width: 10,
                                      height: 3,
                                      decoration: BoxDecoration(
                                          color: KColors.primary,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                      );
                    })),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: List.generate(albums.length - 5, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      alignment: Alignment.bottomCenter,
                                      child: MusicDetailPage(
                                        title: songs_single[index]['title']
                                            as String,
                                        color: songs_single[index]['color']
                                            as Color,
                                        description: songs_single[index]
                                            ['description'] as String,
                                        img: songs_single[index]['img']
                                            as String,
                                        songUrl: songs_single[index]['song_url']
                                            as String,
                                      ),
                                      type: PageTransitionType.scale));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 180,
                                  height: 180,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(songs_single[index]
                                              ['img'] as String),
                                          fit: BoxFit.cover),
                                      color: KColors.primary,
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  songs_single[index]['title'] as String,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: KColors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: 180,
                                  child: Text(
                                    songs_single[index]['description']
                                        as String,
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: KColors.grey,
                                        fontWeight: FontWeight.w600),
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
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, top: 20),
                    child: Row(
                        children: List.generate(song_type_2.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 25),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              activeMenu2 = index;
                            });
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                song_type_2[index] as String,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: activeMenu2 == index
                                        ? KColors.primary
                                        : KColors.grey,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              activeMenu2 == index
                                  ? Container(
                                      width: 10,
                                      height: 3,
                                      decoration: BoxDecoration(
                                          color: KColors.primary,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                      );
                    })),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: List.generate(albums.length - 5, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      alignment: Alignment.bottomCenter,
                                      child: AlbumPage(
                                        song: albums[index + 5],
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
                                          image: AssetImage(albums[index + 5]
                                              ['img'] as String),
                                          fit: BoxFit.cover),
                                      color: KColors.primary,
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  albums[index + 5]['title'] as String,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: KColors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: 180,
                                  child: Text(
                                    albums[index + 5]['description'] as String,
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: KColors.grey,
                                        fontWeight: FontWeight.w600),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
