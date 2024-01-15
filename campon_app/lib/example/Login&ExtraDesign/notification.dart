// ignore_for_file: camel_case_types, unnecessary_import, unused_import

import 'package:campon_app/example/Profile/NotificationSetting.dart';
import 'package:campon_app/example/Profile/Settings.dart';
import 'package:campon_app/example/Utils/Colors.dart';
import 'package:campon_app/example/Utils/customwidget%20.dart';
import 'package:campon_app/example/Utils/dark_lightmode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class notification extends StatefulWidget {
  const notification({super.key});

  @override
  State<notification> createState() => _notificationState();
}

class _notificationState extends State<notification> {
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
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Recent",
                        style: TextStyle(
                            fontSize: 16,
                            color: notifire.getwhiteblackcolor,
                            fontFamily: "Gilroy Bold"),
                      ),
                      // CircleAvatar(
                      //   radius: 10,
                      //   backgroundColor: RedColor,
                      //   child: Text(
                      //     "4",
                      //     style: TextStyle(fontSize: 13),
                      //   ),
                      // )
                    ],
                  ),
                  InkWell(
                      onTap: () {},
                      child: Text(
                        "Mark All Read",
                        style: TextStyle(
                            color: notifire.getdarkbluecolor,
                            fontFamily: "Gilroy Medium"),
                      ))
                ],
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: WhiteColor,
                            backgroundImage:
                                AssetImage(hotelList4[index]["img"].toString()),
                            radius: 25,
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.61,
                                      child: Text(
                                        hotelList5[index]["title"].toString(),
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Gilroy Bold",
                                          color: notifire.getwhiteblackcolor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //     width: MediaQuery.of(context).size.width *
                                  //         0.1),
                                  Text(
                                      hotelList5[index]["massagetime"]
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: notifire.getgreycolor,
                                          fontFamily: "Gilroy Medium"))
                                ],
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.007),
                              SizedBox(
                                height: 40,
                                width: MediaQuery.of(context).size.width * 0.70,
                                child: Text(
                                  hotelList5[index]["subtitle"].toString(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: greyColor,
                                      fontFamily: "Gilroy Medium"),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        color: greyColor,
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        leading: BackButton(
          color: notifire.getwhiteblackcolor,
        ),
        actions: [
          Container(
              margin: const EdgeInsets.only(right: 8),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const NotificationSetting()));
                    },
                    child: CircleAvatar(
                        backgroundColor: notifire.getdarkmodecolor,
                        child: Image.asset(
                          "assets/images/setting.png",
                          height: 25,
                          color: notifire.getwhiteblackcolor,
                        )),
                  )))
        ],
        elevation: 0,
        backgroundColor: notifire.getbgcolor,
        title: Text(
          "Notification",
          style: TextStyle(
              fontSize: 20,
              color: notifire.getwhiteblackcolor,
              fontFamily: "Gilroy Bold"),
        ),
        centerTitle: true,
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
