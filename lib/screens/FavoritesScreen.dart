import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tidal_redesign/color_constant.dart';
import 'package:tidal_redesign/CurveClipper.dart';
import 'package:tidal_redesign/database.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tidal_redesign/glassmorphism.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.kSecondaryColor,
        body: Container(
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
            body: Column(
              children: [
                const _FavoritePlayer(),
                const Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20, top: 10),
                  child: _PlayOrShuffleSwitch(),
                ),
                SizedBox(
                  height: 310,
                  child: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: const [
                            _PlaylistSongs(),
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FavoritePlayer extends StatelessWidget {
  const _FavoritePlayer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          child: Image.asset(
            'assets/images/favorites_image.png',
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
            top: 155,
            left: 280,
            child: Card(
              elevation: 50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35.0),
              ),
              child: ClipOval(
                child: Material(
                  color: Colors.deepPurple.shade50, // button color
                  child: InkWell(
                    splashColor: ColorConstants.kPrimaryColor, // inkwell color
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: ColorConstants.kPrimaryColor,
                        size: 50,
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
              ),
            )),
      ],
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
                          'Favorites',
                          style: TextStyle(
                              color: isPlay ? Colors.white : Colors.deepPurple,
                              fontSize: 17),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.favorite,
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
                          'Downloads',
                          style: TextStyle(
                              color: isPlay ? Colors.deepPurple : Colors.white,
                              fontSize: 17),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.download,
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

class _PlaylistSongs extends StatelessWidget {
  const _PlaylistSongs({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: mostPopular.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text(
              '${index + 1}',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            title: Text(
              mostPopular[index].name,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            subtitle: Text(
              '${mostPopular[index].singer} ~ 02:45',
              style: TextStyle(color: Colors.white),
            ),
            trailing: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          );
        });
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
      title: Center(
        child: Text(
          'Favorites',
          style:
              TextStyle(fontFamily: 'san', fontSize: 18, color: Colors.white),
        ),
      ),
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
