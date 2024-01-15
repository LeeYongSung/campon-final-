// ignore_for_file: file_names

import 'package:campon_app/example/Profile/NotificationSetting.dart';
import 'package:campon_app/example/Utils/dark_lightmode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowMassage extends StatefulWidget {
  const ShowMassage({super.key});

  @override
  State<ShowMassage> createState() => _ShowMassageState();
}

class _ShowMassageState extends State<ShowMassage> {
  @override
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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Massage",
                  style: TextStyle(
                      fontSize: 18,
                      color: notifire.getwhiteblackcolor,
                      fontFamily: "Gilroy Bold"),
                ),
                InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const NotificationSetting()));
                    },
                    child: CircleAvatar(
                        radius: 22,
                        backgroundColor: notifire.getdarkmodecolor,
                        child: Image.asset(
                          "assets/images/setting.png",
                          height: 25,
                          color: notifire.getwhiteblackcolor,
                        )))
              ],
            ),
            const SizedBox(height: 20),
            Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      50,
                    ),
                    color: notifire.getdarkmodecolor),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search hotel',
                      hintStyle: TextStyle(
                          color: notifire.getgreycolor,
                          fontFamily: "Gilroy Medium"),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Image.asset(
                          "assets/images/search.png",
                          height: 25,
                          color: notifire.getgreycolor,
                        ),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                )),
            const SizedBox(height: 60),
            Image.asset(
              'assets/images/BookingSuccessfull.png',
              height: 200,
            ),
            const SizedBox(height: 20),
            Text(
              "No Messages Here",
              style: TextStyle(
                  fontSize: 18,
                  color: notifire.getwhiteblackcolor,
                  fontFamily: "Gilroy Bold"),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Text(
              "Let’s start messaging with others or with seller",
              style: TextStyle(
                  fontSize: 14,
                  color: notifire.getgreycolor,
                  fontFamily: "Gilroy Medium"),
            ),
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
