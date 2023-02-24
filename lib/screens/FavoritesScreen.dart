import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tidal_redesign/color_constant.dart';
import 'package:tidal_redesign/CurveClipper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tidal_redesign/glassmorphism.dart';

class FavoriteScreen extends StatelessWidget {
  //final Function() notifyParent;
  //const FavoriteScreen({super.key});
  //FavoriteScreen(this.notifyParent);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.kSecondaryColor,
        // appBar: AppBar(),

        body: Stack(
          children: [
            Container(
              height: 400,
              child: CustomPaint(
                painter: AppbarPainter(),
                size: const Size(double.infinity, double.infinity),
              ),
            ),
            Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      _appBarContent(),
                      SizedBox(
                        height: 130,
                      ),
                      _chipWidget(),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 220),
                  child: _carousel_slide(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _appBarContent() {
    return Stack(
      children: [
        Container(
          height: 300,
          width: double.infinity,
          //margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0, left: 8),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage:
                          AssetImage('assets/images/person_profile.png'),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Hi! Percy 😊",
                          style: TextStyle(
                              fontSize: 21,
                              fontFamily: 'Outfit',
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          "Let's explore all media",
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Times New Roman',
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                          textAlign: TextAlign.left,
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorConstants.kTransparentWhite,
                          ),
                          child: const Icon(
                            Icons.notifications,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                        const Positioned(
                          left: 22.0,
                          child: CircleAvatar(
                            radius: 4,
                            backgroundColor: Colors.red,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 52,
                  child: TextField(
                    onChanged: (value) => null,
                    decoration: const InputDecoration(
                      fillColor: ColorConstants.kTransparentWhite,
                      filled: true,
                      //labelText: 'Search',
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      hintText: 'Search song, movie, etc..',
                      hintStyle:
                          TextStyle(color: ColorConstants.kSecondaryColor),
                      suffixIcon: Icon(
                        Icons.mic,
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Text(
                      'Recently Played',
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Times New Roman',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    Spacer(),
                    Text(
                      'See More >',
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Times New Roman',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _carousel_slide() {
    return ListView(
      children: [
        CarouselSlider(
          items: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: AssetImage('assets/images/carousel2.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 115, left: 5, right: 5),
                  child: Glassmorphism(
                    blur: 15,
                    opacity: 0.5,
                    radius: 10,
                    child: Container(
                      height: 62,
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const <Widget>[
                              Text(
                                "In Every Way",
                                style: TextStyle(
                                    fontSize: 16,
                                    // fontFamily: 'Times New Roman',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "Mind fresh piano",
                                style: TextStyle(
                                    fontSize: 12,
                                    //fontFamily: 'Times New Roman',
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white),
                                textAlign: TextAlign.left,
                              )
                            ],
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  height: 38,
                                  width: 38,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.white,
                                  ),
                                  child: const Icon(
                                    Icons.play_arrow,
                                    size: 12,
                                    color: ColorConstants.kPrimaryColor,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: AssetImage('assets/images/carousel3.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 115, left: 5, right: 5),
                  child: Glassmorphism(
                    blur: 15,
                    opacity: 0.5,
                    radius: 10,
                    child: Container(
                      height: 62,
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const <Widget>[
                              Text(
                                "In Every Way",
                                style: TextStyle(
                                    fontSize: 16,
                                    // fontFamily: 'Times New Roman',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "Mind fresh piano",
                                style: TextStyle(
                                    fontSize: 12,
                                    //fontFamily: 'Times New Roman',
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white),
                                textAlign: TextAlign.left,
                              )
                            ],
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  height: 38,
                                  width: 38,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.white,
                                  ),
                                  child: const Icon(
                                    Icons.play_arrow,
                                    size: 12,
                                    color: ColorConstants.kPrimaryColor,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: AssetImage('assets/images/carousel4.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 115, left: 5, right: 5),
                  child: Glassmorphism(
                    blur: 15,
                    opacity: 0.5,
                    radius: 10,
                    child: Container(
                      height: 62,
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const <Widget>[
                              Text(
                                "In Every Way",
                                style: TextStyle(
                                    fontSize: 16,
                                    // fontFamily: 'Times New Roman',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "Mind fresh piano",
                                style: TextStyle(
                                    fontSize: 12,
                                    //fontFamily: 'Times New Roman',
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white),
                                textAlign: TextAlign.left,
                              )
                            ],
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  height: 38,
                                  width: 38,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.white,
                                  ),
                                  child: const Icon(
                                    Icons.play_arrow,
                                    size: 12,
                                    color: ColorConstants.kPrimaryColor,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: AssetImage('assets/images/carousel2.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 115, left: 5, right: 5),
                  child: Glassmorphism(
                    blur: 15,
                    opacity: 0.5,
                    radius: 10,
                    child: Container(
                      height: 62,
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const <Widget>[
                              Text(
                                "In Every Way",
                                style: TextStyle(
                                    fontSize: 16,
                                    // fontFamily: 'Times New Roman',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "Mind fresh piano",
                                style: TextStyle(
                                    fontSize: 12,
                                    //fontFamily: 'Times New Roman',
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white),
                                textAlign: TextAlign.left,
                              )
                            ],
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  height: 38,
                                  width: 38,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.white,
                                  ),
                                  child: const Icon(
                                    Icons.play_arrow,
                                    size: 12,
                                    color: ColorConstants.kPrimaryColor,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: AssetImage('assets/images/carousel3.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 115, left: 5, right: 5),
                  child: Glassmorphism(
                    blur: 15,
                    opacity: 0.5,
                    radius: 10,
                    child: Container(
                      height: 62,
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const <Widget>[
                              Text(
                                "In Every Way",
                                style: TextStyle(
                                    fontSize: 16,
                                    // fontFamily: 'Times New Roman',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "Mind fresh piano",
                                style: TextStyle(
                                    fontSize: 12,
                                    //fontFamily: 'Times New Roman',
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white),
                                textAlign: TextAlign.left,
                              )
                            ],
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  height: 38,
                                  width: 38,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.white,
                                  ),
                                  child: const Icon(
                                    Icons.play_arrow,
                                    size: 12,
                                    color: ColorConstants.kPrimaryColor,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
          options: CarouselOptions(
            height: 180.0,
            //enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.easeInCirc,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            viewportFraction: 0.8,
          ),
        ),
      ],
    );
  }

  Widget _chipWidget() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: const <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(
              height: 36,
              width: 92,
              child: Chip(
                label: Text(
                  'Music',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                backgroundColor: ColorConstants.kPrimaryColor,
                avatar: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/profile.jpg'),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(
              height: 36,
              width: 92,
              child: Chip(
                label: Text(
                  'Music',
                  style: TextStyle(
                      color: ColorConstants.kPrimaryColor, fontSize: 12),
                ),
                elevation: 20,
                backgroundColor: Colors.white,
                avatar: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/profile.jpg'),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(
              height: 36,
              width: 92,
              child: Chip(
                label: Text(
                  'Music',
                  style: TextStyle(
                      color: ColorConstants.kPrimaryColor, fontSize: 12),
                ),
                elevation: 20,
                backgroundColor: Colors.white,
                avatar: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/profile.jpg'),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(
              height: 36,
              width: 92,
              child: Chip(
                label: Text(
                  'Music',
                  style: TextStyle(
                      color: ColorConstants.kPrimaryColor, fontSize: 12),
                ),
                elevation: 20,
                backgroundColor: Colors.white,
                avatar: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/profile.jpg'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppbarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;
    Paint paint = Paint();
    Path path = Path();
    paint.shader = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromARGB(255, 145, 81, 190),
        Color.fromARGB(255, 233, 196, 187)
      ],
    ).createShader(rect);
    path.lineTo(0, size.height - size.height / 5);
    path.conicTo(size.width / 2.0, size.height, size.width,
        size.height - size.height / 5, 1.5);
    path.lineTo(size.width, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
