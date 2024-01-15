// ignore_for_file: camel_case_types, use_key_in_widget_constructors, annotate_overrides, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'package:campon_app/example/CreatAccount/login.dart';
import 'package:campon_app/example/Utils/Colors.dart';
import 'package:campon_app/example/Utils/dark_lightmode.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:campon_app/example/IntroScreen/onbording.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../CreatAccount/creatscreen.dart';

class onbording extends StatefulWidget {
  const onbording({super.key});

  @override
  State<onbording> createState() => _onbordingState();
}

class _onbordingState extends State<onbording> {
  @override
  void initState() {
    getdarkmodepreviousstate();
    super.initState();

    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const BoardingPage()));
      },
    );
  }

  late ColorNotifire notifire;

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.getbgcolor,
      body: Center(
          child: Image.asset("assets/images/applogo.png",
              height: 170, width: 200)),
    );
  }

  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifire.setIsDark = false;
    } else {
      notifire.setIsDark = previusstate;
    }
  }
}

class BoardingPage extends StatefulWidget {
  const BoardingPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BoardingScreenState createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingPage> {
  // creating all the widget before making our home screeen

  void initState() {
    getdarkmodepreviousstate();
    super.initState();

    _currentPage = 0;

    slides = [
      Slide("assets/images/onbording11.png", "Hotel booking with GoHotel ",
          "Best accommodation at best prices"),
      Slide("assets/images/onbording12.png", " Best trip experience",
          "Get the best deals on Hotels - every day!"),
      Slide("assets/images/onbording13.png", "Just Signup on GoHotel",
          "Largest & Most Trusted Hotel App"),
    ];
    _pageController = PageController(initialPage: _currentPage);
    super.initState();
  }

  int _currentPage = 0;
  List<Slide> slides = [];
  PageController _pageController = PageController();

  // the list which contain the build slides
  List<Widget> _buildSlides() {
    return slides.map(_buildSlide).toList();
  }

  late ColorNotifire notifire;

  Widget _buildSlide(Slide slide) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.getbgcolor,
      body: Column(
        children: <Widget>[
          SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.04), //upar thi jagiya mukeli che
          // ignore: sized_box_for_whitespace
          Container(
            height: MediaQuery.of(context).size.height / 1.9, //imagee size
            width: MediaQuery.of(context).size.width,
            child: Image.asset(slide.image),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(),
            child: Text(
              slide.heading,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: "Gilroy Bold",
                  color: notifire.getwhiteblackcolor), //heding Text
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Padding(
            padding: const EdgeInsets.symmetric(),
            child: Text(
              slide.subtext,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                  color: notifire.getgreycolor,
                  fontFamily: "Gilroy Medium"), //subtext
            ),
          ),
        ],
      ),
    );
  }

  // handling the on page changed
  void _handlingOnPageChanged(int page) {
    setState(() => _currentPage = page);
  }

  // building page indicator
  Widget _buildDots({
    int? index,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < slides.length; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // borderRadius: const BorderRadius.all(
              //   Radius.circular(50),
              // ),
              // color: Color(0xFF000000),
              color: _currentPage == i ? Darkblue : greyColor,
            ),
            margin: const EdgeInsets.only(right: 8),
            curve: Curves.easeIn,
            width: _currentPage == i ? 12 : 8,
            height: _currentPage == i ? 12 : 8,
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      body: Stack(
        children: <Widget>[
          PageView(
            controller: _pageController,
            onPageChanged: _handlingOnPageChanged,
            physics: const BouncingScrollPhysics(),
            children: _buildSlides(),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: <Widget>[
                _buildDots(index: _currentPage),
                SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.06, //indicator set screen
                ),
                _currentPage == 2
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const loginpage()));
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Darkblue,
                                  borderRadius: BorderRadius.circular(50)),
                              height: 50,
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  "Get Started",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: WhiteColor,
                                      fontFamily: "Gilroy Bold"),
                                ),
                              )),
                        ))
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: GestureDetector(
                          onTap: () {
                            _pageController.nextPage(
                                duration: const Duration(microseconds: 300),
                                curve: Curves.easeIn);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Darkblue,
                                  borderRadius: BorderRadius.circular(50)),
                              height: 50,
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  "Continue",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: WhiteColor,
                                      fontFamily: "Gilroy Bold"),
                                ),
                              )),
                        )),
                SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.012, //indicator set screen
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const loginpage()));
                    },
                    child: Text(
                      "Skip",
                      style: TextStyle(
                          fontSize: 18,
                          color: Darkblue,
                          fontFamily: "Gilroy Bold"),
                    )),
                const SizedBox(height: 20)
              ],
            ),
          )
        ],
      ),
    );
  }

  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifire.setIsDark = false;
    } else {
      notifire.setIsDark = previusstate;
    }
  }
}

class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  void initState() {
    getdarkmodepreviousstate();
    super.initState();
  }

  late ColorNotifire notifire;
  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.getbgcolor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 6.5),
            Center(
              child: Image.asset(
                "assets/images/applogo.png",
                height: 180,
                width: 230,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Text(
              "Welcome to GoHotel",
              style: TextStyle(
                  fontSize: 25,
                  fontFamily: "Gilroy Bold",
                  color: notifire.getwhiteblackcolor),
            ),
            const SizedBox(height: 10),
            Text(
                "If you are new here please create your accountfirst before book the hotel.",
                style: TextStyle(
                    fontSize: 14,
                    color: notifire.getgreycolor,
                    fontFamily: "Gilroy Medium"),
                textAlign: TextAlign.center),
            SizedBox(height: MediaQuery.of(context).size.height / 4.5),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const creatscreen()));
              },
              // ignore: sort_child_properties_last
              child: Text(
                'Create Account',
                style: TextStyle(
                    color: WhiteColor, fontSize: 16, fontFamily: "Gilroy Bold"),
              ),
              style: OutlinedButton.styleFrom(
                  backgroundColor: Darkblue,
                  fixedSize: const Size(400, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const loginscreen()));
                },
                child: Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 18, color: Darkblue, fontFamily: "Gilroy Bold"),
                ))
          ],
        ),
      ),
    );
  }

  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifire.setIsDark = false;
    } else {
      notifire.setIsDark = previusstate;
    }
  }
}

class Slide {
  String image;
  String heading;
  String subtext;

  Slide(this.image, this.heading, this.subtext);
}
