// import 'package:campon_app/example/hoteldetailage.dart';
// ignore_for_file: unused_field, library_private_types_in_public_api, camel_case_types

import 'package:campon_app/example/Profile/profile.dart';
import 'package:campon_app/example/Search/Search.dart';
import 'package:campon_app/example/Utils/Colors.dart';
import 'package:campon_app/example/Utils/dark_lightmode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
import '../Massage/massage.dart';

int selectedIndex = 0;

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  late int _lastTimeBackButtonWasTapped;
  static const exitTimeInMillis = 2000;

  final _pageOption = [
    const home(),
    Search(),
    const massage(),
    const profile(),
  ];
  @override
  void initState() {
    getdarkmodepreviousstate();
    super.initState();
  }

  late ColorNotifire notifire;

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return
        // WillPopScope(
        // // onWillPop: _handleWillPop,
        // child:
        Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: notifire.getwhiteblackcolor,
        backgroundColor: notifire.getbgcolor,
        elevation: 0,
        selectedLabelStyle: const TextStyle(
            fontFamily: 'Gilroy Bold', fontWeight: FontWeight.bold),
        fixedColor: notifire.getwhiteblackcolor,
        unselectedLabelStyle: const TextStyle(fontFamily: 'Gilroy Medium'),
        currentIndex: selectedIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
              icon: Image.asset("assets/images/homeicon.png",
                  color: selectedIndex == 0 ? Darkblue : greyColor,
                  height: MediaQuery.of(context).size.height / 35),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Image.asset("assets/images/search.png",
                  color: selectedIndex == 1 ? Darkblue : greyColor,
                  height: MediaQuery.of(context).size.height / 35),
              label: 'Search'),
          BottomNavigationBarItem(
              icon: Image.asset("assets/images/message.png",
                  color: selectedIndex == 2 ? Darkblue : greyColor,
                  height: MediaQuery.of(context).size.height / 35),
              label: 'Message'),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/profile.png",
                color: selectedIndex == 3 ? Darkblue : greyColor,
                height: MediaQuery.of(context).size.height / 35),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {});
          selectedIndex = index;
        },
      ),
      body: _pageOption[selectedIndex],
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
