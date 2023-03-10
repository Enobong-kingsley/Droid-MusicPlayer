import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tidal_redesign/database.dart';
import 'package:tidal_redesign/screens/Home.dart';
import 'package:lottie/lottie.dart';

class MusicPlayer extends StatefulWidget {
  final Song song;
  const MusicPlayer(this.song);

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

double currentSlider = 0;

class _MusicPlayerState extends State<MusicPlayer> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: 'image',
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(widget.song.image), fit: BoxFit.cover),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello! Percy",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Nigeria",
                    style: TextStyle(fontSize: 10),
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
          body: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 50, left: 20, right: 20),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 14,
                      spreadRadius: 16,
                      color: Colors.black.withOpacity(0.2))
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: Container(
                    height: 700,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        width: 1.5,
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(
                        //   height: 300,
                        //   width: 500,
                        //   child: Lottie.network(
                        //       'https://assets6.lottiefiles.com/private_files/lf30_fzgzqgfe.json'),
                        // ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.red, shape: BoxShape.circle),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.music_note,
                                size: 48,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 20, right: 20, top: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                widget.song.name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 40,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            widget.song.singer,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 2),
                                trackShape: RectangularSliderTrackShape(),
                                trackHeight: 6),
                            child: Slider(
                                value: currentSlider,
                                max: widget.song.duration.toDouble(),
                                min: 0,
                                inactiveColor: Colors.white70,
                                activeColor: Colors.red,
                                onChanged: (val) {
                                  currentSlider = val;
                                  setState(() {});
                                }),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Duration(
                                  seconds: currentSlider.toInt(),
                                ).toString().split('.')[0].substring(2),
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                Duration(
                                  seconds: widget.song.duration.toInt(),
                                ).toString().split('.')[0].substring(2),
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.skip_previous_outlined,
                              color: Colors.white,
                              size: 40,
                            ),
                            Icon(
                              Icons.pause,
                              color: Colors.white,
                              size: 50,
                            ),
                            Icon(
                              Icons.skip_next_outlined,
                              color: Colors.white,
                              size: 40,
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.replay_outlined,
                                  color: Colors.white,
                                  size: 40,
                                ),
                                Icon(
                                  Icons.shuffle,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ]),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
