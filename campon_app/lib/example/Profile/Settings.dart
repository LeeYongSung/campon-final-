// ignore_for_file: file_names

import 'package:campon_app/example/CreatAccount/login.dart';
import 'package:campon_app/example/Profile/Language.dart';
import 'package:campon_app/example/Profile/MyProfile.dart';
import 'package:campon_app/example/Profile/NotificationSetting.dart';
import 'package:campon_app/example/Utils/Colors.dart';
import 'package:campon_app/example/Utils/dark_lightmode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/customwidget .dart';

class Settings extends StatefulWidget {
  const Settings({super.key});
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    getdarkmodepreviousstate();
    super.initState();
  }

  bool switchValue = false;
  late ColorNotifire notifire;

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: notifire.getbgcolor,
        leading: BackButton(color: notifire.getwhiteblackcolor),
        title: Text(
          "Settings",
          style: TextStyle(color: notifire.getwhiteblackcolor),
        ),
      ),
      backgroundColor: notifire.getbgcolor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Account Settings",
                  style: TextStyle(
                      fontSize: 16,
                      color: notifire.getwhiteblackcolor,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              AccountSetting(
                image: "assets/images/profile.png",
                text: "My Profile",
                icon: Icons.keyboard_arrow_right,
                onclick: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MyProfile()));
                },
                boxcolor: notifire.getdarkmodecolor,
                ImageColor: notifire.getwhiteblackcolor,
                iconcolor: notifire.getwhiteblackcolor,
                TextColor: notifire.getwhiteblackcolor,
              ),
              AccountSetting(
                image: "assets/images/notification.png",
                text: "Notifications",
                icon: Icons.keyboard_arrow_right,
                onclick: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const NotificationSetting()));
                },
                boxcolor: notifire.getdarkmodecolor,
                ImageColor: notifire.getwhiteblackcolor,
                iconcolor: notifire.getwhiteblackcolor,
                TextColor: notifire.getwhiteblackcolor,
              ),
              AccountSetting(
                  image: "assets/images/Payments.png",
                  text: "Payments and Payouts",
                  icon: Icons.keyboard_arrow_right,
                  onclick: () {
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (context) => Favourite()));
                  },
                  boxcolor: notifire.getdarkmodecolor,
                  ImageColor: notifire.getwhiteblackcolor,
                  iconcolor: notifire.getwhiteblackcolor,
                  TextColor: notifire.getwhiteblackcolor),
              const SizedBox(height: 10),
              Text("Preferences",
                  style: TextStyle(
                      fontSize: 16,
                      color: notifire.getwhiteblackcolor,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              AccountSetting(
                  image: "assets/images/Langauge.png",
                  text: "Language",
                  icon: Icons.keyboard_arrow_right,
                  onclick: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Language()));
                  },
                  boxcolor: notifire.getdarkmodecolor,
                  iconcolor: notifire.getwhiteblackcolor,
                  ImageColor: notifire.getwhiteblackcolor,
                  TextColor: notifire.getwhiteblackcolor),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: notifire.getdarkmodecolor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05),
                          Image.asset(
                            "assets/images/moon.png",
                            height: 30,
                            color: notifire.getwhiteblackcolor,
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.065),
                          Text("Dark Mode",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: notifire.getwhiteblackcolor,
                                  fontFamily: "Gilroy Bold")),
                        ],
                      ),
                      // ignore: sized_box_for_whitespace
                      Container(
                        height: 43.0,
                        width: 60.0,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CupertinoSwitch(
                              thumbColor: notifire.getdarkwhitecolor,
                              trackColor: notifire.getbuttoncolor,
                              activeColor: notifire.getdarkbluecolor,
                              value: switchValue,
                              onChanged: (value) async {
                                setState(() {
                                  switchValue = value;
                                });
                                final prefs =
                                    await SharedPreferences.getInstance();
                                setState(() {
                                  notifire.setIsDark = value;
                                  prefs.setBool("setIsDark", value);
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              AccountSetting(
                  image: "assets/images/lock.png",
                  text: "Privacy Settings",
                  icon: Icons.keyboard_arrow_right,
                  onclick: () {
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (context) => Favourite()));
                  },
                  boxcolor: notifire.getdarkmodecolor,
                  ImageColor: notifire.getwhiteblackcolor,
                  iconcolor: notifire.getwhiteblackcolor,
                  TextColor: notifire.getwhiteblackcolor),
              AccountSetting(
                  image: "assets/images/logout.png",
                  text: "Log Out",
                  icon: null,
                  onclick: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const loginscreen()));
                  },
                  boxcolor: notifire.getdarkmodecolor,
                  iconcolor: notifire.getwhiteblackcolor,
                  ImageColor: RedColor,
                  TextColor: RedColor),
            ],
          ),
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
