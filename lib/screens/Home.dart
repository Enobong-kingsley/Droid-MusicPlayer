import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tidal_redesign/color_constant.dart';
import 'package:tidal_redesign/database.dart';
import 'package:tidal_redesign/screens/PlaylistScreen.dart';
import 'package:tidal_redesign/screens/MusicPlayer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            ColorConstants.kPrimaryColor.withOpacity(1),
            ColorConstants.kSecondaryColor.withOpacity(0.9),
            ColorConstants.kSecondaryColor.withOpacity(0.8)
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          brightness: Brightness.dark,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Container(
            margin: EdgeInsets.only(left: 20),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://images.pexels.com/photos/2272854/pexels-photo-2272854.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
            ),
          ),
          actions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello! Percy',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Nigeria',
                  style: TextStyle(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: 8, left: 15),
              child: Icon(
                Icons.notifications_active_outlined,
                size: 30,
              ),
            )
          ],
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Welcome',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Browse your favorite music',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(
                        20.0), //color: Colors.grey.shade400
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        isDense: true,
                        hintText: 'Search',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.grey.shade400),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey.shade400,
                        ),
                        suffixIcon: Icon(
                          Icons.mic,
                          size: 20,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Most \nPopular',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                        child: Text(
                          '960 playlist',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(right: 20, top: 5, bottom: 5),
                        child: Text(
                          'see more >',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 300,
                    child: TrackWidget(refresh),
                  ),
                  CircleTrackerWidget(
                    song: newlyReleased,
                    title: "new releases",
                    subtitle: "3456 songs",
                    notifyParent: refresh,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 170),
                    child: CircleTrackerWidget(
                      song: mostPopular,
                      title: "top rated",
                      subtitle: "346 songs",
                      notifyParent: refresh,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: PlayerHome(currentSong),
              ),
            ),
          ],
        ),
      ),
    );
  }

  refresh() {
    setState(() {});
  }
}

Song currentSong = Song(
    name: 'title',
    singer: 'singer',
    image: 'assets/images/playlist_image.jpg',
    duration: 100,
    color: Colors.black);
double currentSlider = 0;

class PlayerHome extends StatefulWidget {
  final Song song;
  PlayerHome(this.song);

  @override
  State<PlayerHome> createState() => _PlayerHomeState();
}

class _PlayerHomeState extends State<PlayerHome> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, _, __) => MusicPlayer(widget.song),
          ),
        );
      },
      child: Container(
        height: 76,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: ColorConstants.kPrimaryColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30))),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Hero(
                      tag: "image",
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage(widget.song.image),
                        radius: 30,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.song.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.song.singer,
                          style: TextStyle(
                            color: Colors.white54,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.pause,
                      color: Colors.white,
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.skip_next_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Text(
            //       Duration(seconds: currentSlider.toInt())
            //           .toString()
            //           .split('.')[0]
            //           .substring(2),
            //       style: TextStyle(color: Colors.white),
            //     ),
            //     Container(
            //       width: MediaQuery.of(context).size.width - 120,
            //       child: SliderTheme(
            //         data: SliderTheme.of(context).copyWith(
            //           thumbShape:
            //               RoundSliderThumbShape(enabledThumbRadius: 4),
            //           trackShape: RectangularSliderTrackShape(),
            //           trackHeight: 4,
            //         ),
            //         child: Slider(
            //           value: currentSlider,
            //           max: widget.song.duration.toDouble(),
            //           min: 0,
            //           inactiveColor: Colors.grey[500],
            //           activeColor: Colors.white,
            //           onChanged: (val) {
            //             setState(() {
            //               currentSlider = val;
            //             });
            //           },
            //         ),
            //       ),
            //     ),
            //     Text(
            //       Duration(seconds: widget.song.duration)
            //           .toString()
            //           .split('.')[0]
            //           .substring(2),
            //       style: TextStyle(color: Colors.white),
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}

class CircleTrackerWidget extends StatelessWidget {
  final String title;
  final List<Song> song;
  final String subtitle;
  final Function() notifyParent;

  CircleTrackerWidget(
      {required this.title,
      required this.song,
      required this.subtitle,
      required this.notifyParent});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10, left: 20),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20, left: 20),
            child: Text(
              subtitle,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ),
          Container(
            height: 130,
            child: ListView.builder(
              itemCount: song.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: (() {
                    currentSong = song[index];
                    currentSlider = 0;
                    notifyParent();
                  }),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(song[index].image),
                          radius: 40,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          song[index].name,
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          song[index].singer,
                          style: TextStyle(color: Colors.white54),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class TrackWidget extends StatelessWidget {
  final Function() notifyParent;
  TrackWidget(this.notifyParent);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: mostPopular.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: (() {
            currentSong = mostPopular[index];
            currentSlider = 0;
            notifyParent();
          }),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: mostPopular[index].color,
                        blurRadius: 1,
                        spreadRadius: 0.3),
                  ],
                  image: DecorationImage(
                      image: AssetImage(
                        mostPopular[index].image,
                      ),
                      fit: BoxFit.cover),
                ),
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.53,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white.withOpacity(0.5)),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            mostPopular[index].name,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            mostPopular[index].singer,
                            style: TextStyle(
                                color: Colors.white54,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            const Icon(
                              Icons.play_circle,
                              size: 32,
                              color: ColorConstants.kPrimaryColor,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class _CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const _CustomAppBar({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Icon(Icons.grid_view_rounded),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 20),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://images.pexels.com/photos/2272854/pexels-photo-2272854.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}
