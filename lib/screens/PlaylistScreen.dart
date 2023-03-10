import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:tidal_redesign/controllers/player_controller.dart';
import 'package:tidal_redesign/database.dart';
import 'package:tidal_redesign/color_constant.dart';
import 'package:tidal_redesign/screens/Home.dart';
import 'package:tidal_redesign/screens/musicPlayer.dart';
import 'package:flutter/src/widgets/framework.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key});

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
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const _CustomAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                _PlaylistInformation(),
                SizedBox(
                  height: 30,
                ),
                _PlayOrShuffleSwitch(),
                _PlaylistSongs(currentSong),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PlaylistSongs extends StatefulWidget {
  // _PlaylistSongs({
  //   Key? key,
  // }) : super(key: key);
  final Song song;
  _PlaylistSongs(this.song);

  @override
  State<_PlaylistSongs> createState() => _PlaylistSongsState();
}

class _PlaylistSongsState extends State<_PlaylistSongs> {
  var controller = Get.put(PlayerController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SongModel>>(
      future: controller.audioQuery.querySongs(
          ignoreCase: true,
          orderType: OrderType.ASC_OR_SMALLER,
          sortType: null,
          uriType: UriType.EXTERNAL),
      builder: (BuildContext context, snapshot) {
        if (snapshot.data == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.data!.isEmpty) {
          print(snapshot.data);
          return Center(
            child: Text(
              "No Song Found",
              style: TextStyle(fontSize: 40),
            ),
          );
        } else {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Obx(
                () => ListTile(
                  leading: QueryArtworkWidget(
                    id: snapshot.data![index].id,
                    type: ArtworkType.AUDIO,
                    nullArtworkWidget: const Icon(
                      Icons.music_note,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  //  Text(
                  //   '${index + 1}',
                  //   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  //       fontWeight: FontWeight.bold, color: Colors.white),
                  // ),
                  title: Text(
                    snapshot.data![index].displayNameWOExt,
                    // mostPopular[index].name,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  subtitle: Text(
                    "${snapshot.data![index].artist}",
                    // '${mostPopular[index].singer} ~ 02:45',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: controller.playIndex.value == index &&
                          controller.isPlaying.value
                      ? SizedBox(
                          height: 50,
                          width: 50,
                          child: Blob(
                            color: ColorConstants.kPrimaryColor,
                          ),
                        )
                      // Icon(
                      //     Icons.play_circle,
                      //     color: Colors.white,
                      //     size: 26,
                      //   )
                      : null,
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, _, __) =>
                            MusicPlayer(widget.song),
                      ),
                    );
                    // Get.to(() => MusicPlayer(song));
                    controller.playSong(snapshot.data![index].uri, index);
                  },
                ),
              );
            },
          );
        }
      },
    );
  }
}

class Blob extends StatelessWidget {
  final double rotation;
  final double scale;
  final Color color;

  const Blob({required this.color, this.rotation = 0, this.scale = 1})
      : assert(color != null);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: Transform.rotate(
        angle: rotation,
        child: Container(
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(50),
                  bottomLeft: Radius.circular(42),
                  bottomRight: Radius.circular(37))),
        ),
      ),
    );
  }
}

class _PlayOrShuffleSwitch extends StatefulWidget {
  const _PlayOrShuffleSwitch({
    Key? key,
  }) : super(key: key);

  @override
  State<_PlayOrShuffleSwitch> createState() => _PlayOrShuffleSwitchState();
}

class _PlayOrShuffleSwitchState extends State<_PlayOrShuffleSwitch> {
  bool isPlay = true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (() {
        setState(() {
          isPlay = !isPlay;
        });
      }),
      child: Container(
        height: 50,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              left: isPlay ? 0 : width * 0.45,
              child: Container(
                height: 50,
                width: width * 0.45,
                decoration: BoxDecoration(
                  color: ColorConstants.kPrimaryColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Play',
                          style: TextStyle(
                              color: isPlay ? Colors.white : Colors.deepPurple,
                              fontSize: 17),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.play_circle,
                        color: isPlay ? Colors.white : Colors.deepPurple,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Shuffle',
                          style: TextStyle(
                              color: isPlay ? Colors.deepPurple : Colors.white,
                              fontSize: 17),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.shuffle,
                        color: isPlay ? Colors.deepPurple : Colors.white,
                      )
                    ],
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

class _PlaylistInformation extends StatelessWidget {
  const _PlaylistInformation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Image.asset(
            'assets/images/playlist_image.jpg',
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.height * 0.3,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          'Recently played',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
        )
      ],
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
      leading: Icon(Icons.arrow_back_ios),
      title: Center(
        child: Text(
          'Playlist',
          style:
              TextStyle(fontFamily: 'san', fontSize: 18, color: Colors.white),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.more_vert),
        ),
        // Container(
        //   margin: EdgeInsets.only(right: 20),
        //   child: CircleAvatar(
        //     backgroundImage: NetworkImage(
        //         'https://images.pexels.com/photos/2272854/pexels-photo-2272854.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
        //   ),
        // )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}
