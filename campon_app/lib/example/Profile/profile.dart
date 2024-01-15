// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:campon_app/example/CreatAccount/login.dart';
import 'package:campon_app/example/Profile/Favourite.dart';
import 'package:campon_app/example/Profile/MyCupon.dart';
import 'package:campon_app/example/Profile/Settings.dart';
import 'package:campon_app/example/Profile/TransactionHistory.dart';
import 'package:campon_app/example/Utils/dark_lightmode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/customwidget .dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  void initState() {
    getdarkmodepreviousstate();
    super.initState();
  }

  late ColorNotifire notifire;
  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return SafeArea(
      child: Scaffold(
          backgroundColor: notifire.getbgcolor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Profile",
                        style: TextStyle(
                            fontSize: 18,
                            color: notifire.getwhiteblackcolor,
                            fontFamily: "Gilroy Bold"),
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Settings()));
                          },
                          child: CircleAvatar(
                              backgroundColor: notifire.getdarkmodecolor,
                              child: Image.asset(
                                "assets/images/setting.png",
                                height: 25,
                                color: notifire.getwhiteblackcolor,
                              ))),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundColor: notifire.getwhiteblackcolor,
                          backgroundImage:
                              const AssetImage("assets/images/person.jpg"),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "John kennedy",
                          style: TextStyle(
                              fontSize: 16,
                              color: notifire.getwhiteblackcolor,
                              fontFamily: "Gilroy Bold"),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Purwokerto, Indonesia",
                          style: TextStyle(
                              fontSize: 16,
                              color: notifire.getgreycolor,
                              fontFamily: "Gilroy Medium"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: notifire.getdarkmodecolor),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Transaction(text1: "26", text2: "Transaction"),
                          Transaction(text1: "12", text2: "Review"),
                          Transaction(text1: "4", text2: "Bookings"),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Option",
                        style: TextStyle(
                            fontSize: 18,
                            color: notifire.getwhiteblackcolor,
                            fontFamily: "Gilroy Bold"),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      AccountSetting(
                          image: "assets/images/heart.png",
                          text: "My Favourite",
                          icon: Icons.keyboard_arrow_right,
                          onclick: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Favourite()));
                          },
                          boxcolor: notifire.getdarkmodecolor,
                          iconcolor: notifire.getwhiteblackcolor,
                          ImageColor: notifire.getwhiteblackcolor,
                          TextColor: notifire.getwhiteblackcolor),
                      AccountSetting(
                          image: "assets/images/clock.png",
                          text: "Transaction",
                          icon: Icons.keyboard_arrow_right,
                          onclick: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const TransactionHistory()));
                          },
                          boxcolor: notifire.getdarkmodecolor,
                          iconcolor: notifire.getwhiteblackcolor,
                          ImageColor: notifire.getwhiteblackcolor,
                          TextColor: notifire.getwhiteblackcolor),
                      AccountSetting(
                          image: "assets/images/discount.png",
                          text: "My Cupon",
                          icon: Icons.keyboard_arrow_right,
                          onclick: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const MyCupon()));
                          },
                          boxcolor: notifire.getdarkmodecolor,
                          iconcolor: notifire.getwhiteblackcolor,
                          ImageColor: notifire.getwhiteblackcolor,
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
                          ImageColor: notifire.getredcolor,
                          TextColor: notifire.getredcolor),
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }

  Transaction({text1, text2}) {
    return Column(
      children: [
        Text(
          text1,
          style: TextStyle(
              fontSize: 16,
              color: notifire.getdarkbluecolor,
              fontFamily: "Gilroy Bold"),
        ),
        const SizedBox(height: 8),
        Text(
          text2,
          style: TextStyle(
              fontSize: 15,
              color: notifire.getgreycolor,
              fontFamily: "Gilroy Medium"),
        ),
      ],
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
