import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../json/songs_json.dart';
import '../utils/kcolors.dart';
import 'album_page.dart';

class AllAlbum extends StatefulWidget {

  const AllAlbum({super.key});

  @override
  State<AllAlbum> createState() => _AllAlbumState();
}

class _AllAlbumState extends State<AllAlbum> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.black,
      appBar: _appBar(AppBar().preferredSize.height),
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
              "Albums",
              style: TextStyle(
                  fontSize: 20,
                  color: KColors.white,
                  fontWeight: FontWeight.bold),
            ),
            Icon(
              Icons.more_vert,
              color: KColors.white,
            )
          ],
        ),
      ),
    );
  }

  PreferredSize _appBar(double height) => PreferredSize(
    preferredSize:  Size(MediaQuery.of(context).size.width, height+80 ),
    child: Stack(
      children: <Widget>[
        Container(     // Background
          child: Center(
            child: Text("Albums", style: TextStyle(fontSize: 25.0,
                fontWeight: FontWeight.w600,
                color: KColors.white),),),
          color:KColors.primary,
          height: height+75,
          width: MediaQuery.of(context).size.width,
        ),

        Container(),   // Required some widget in between to float AppBar

        Positioned(    // To take AppBar Size only
          top: 100.0,
          left: 10.0,
          right: 10.0,
          child: AppBar(
            backgroundColor: KColors.white,
            leading: Icon(Icons.search, color: KColors.primary,),
            primary: false,
            title: TextField(
                decoration: InputDecoration(
                    hintText: "Recherche",
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: KColors.grey))),
          ),
        )

      ],
    ),
  );


  Widget getBody() {
    //List<dynamic> songAlbums = widget.song['songs'] as List<dynamic>;
    return SingleChildScrollView(
      child: Column(
          children: List.generate(
            albums.length,
                (index) {
              return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            alignment: Alignment.bottomCenter,
                            child: AlbumPage(
                              song: albums[index],
                            ),
                            type: PageTransitionType.scale));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    color: KColors.transparent,
                    // Define how the card's content should be clipped
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    // Define the child widget of the card
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Add padding around the row widget
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Add an image widget to display an image
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(albums[index]['img'] as String),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              // Add some spacing between the image and the text
                              Container(width: 20),
                              // Add an expanded widget to take up the remaining horizontal space
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // Add some spacing between the top of the card and the title
                                    Container(height: 5),
                                    // Add a title widget
                                    Text(
                                      "Album ${albums[index]['date'] as String}",
                                      style: TextStyle(
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                    // Add some spacing between the title and the subtitle
                                    Container(height: 5),
                                    // Add a subtitle widget
                                    Text(
                                      albums[index]['title'] as String,
                                      style: TextStyle(
                                        color: KColors.grey,
                                      ),
                                    ),
                                    // Add some spacing between the subtitle and the text
                                    Container(height: 10),
                                    // Add a text widget to display some text
                                    Text(
                                      albums[index]['description'] as String,
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )),
    );
  }
}
