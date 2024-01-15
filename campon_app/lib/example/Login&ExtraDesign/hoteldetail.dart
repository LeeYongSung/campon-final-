// ignore_for_file: prefer_final_fields, camel_case_types, sized_box_for_whitespace, avoid_print, avoid_unnecessary_containers

import 'package:campon_app/example/Login&ExtraDesign/chackout.dart';
import 'package:campon_app/example/Login&ExtraDesign/review.dart';
import 'package:campon_app/example/Utils/Colors.dart';
import 'package:campon_app/example/Utils/customwidget%20.dart';
import 'package:campon_app/example/Utils/dark_lightmode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class hoteldetailpage extends StatefulWidget {
  const hoteldetailpage({super.key});

  @override
  State<hoteldetailpage> createState() => _hoteldetailpageState();
}

class _hoteldetailpageState extends State<hoteldetailpage> {
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;
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
      bottomNavigationBar: Container(
        color: notifire.getdarkmodecolor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 70,
                child: CircleAvatar(
                  radius: 30,
                  // ignore: sort_child_properties_last
                  child: Image.asset(
                    "assets/images/Chat.png",
                    height: 35,
                    color: notifire.getwhitebluecolor,
                  ),
                  backgroundColor: notifire.getbgcolor,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (context) => const chackout()))
                      .then((value) => print('ok Navigat'));
                },
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width / 1.4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50), color: Darkblue),
                  child: Center(
                    child: Text(
                      "Book Now",
                      style: TextStyle(
                          color: WhiteColor,
                          fontSize: 18,
                          fontFamily: "Gilroy Bold"),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      backgroundColor: notifire.getbgcolor,
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          elevation: 0,
          backgroundColor: notifire.getbgcolor,
          leading: Padding(
            padding: const EdgeInsets.only(top: 8, left: 12),
            child: CircleAvatar(
              backgroundColor: notifire.getlightblackcolor,
              child: BackButton(
                color: notifire.getdarkwhitecolor,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: notifire.getlightblackcolor,
                    child: Image.asset(
                      "assets/images/share.png",
                      color: notifire.getdarkwhitecolor,
                      height: 30,
                    ),
                  ),
                  const SizedBox(width: 20),
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: notifire.getlightblackcolor,
                    child: Image.asset(
                      "assets/images/heart.png",
                      color: notifire.getdarkwhitecolor,
                      height: 25,
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),
          ],
          pinned: _pinned,
          snap: _snap,
          floating: _floating,
          expandedHeight: 250,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              "assets/images/SagamoreResort.jpg",
              height: 300,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
        ),
        SliverToBoxAdapter(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Stack(children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Diamond Heart Hotel",
                      style: TextStyle(
                          fontSize: 18,
                          color: notifire.getwhiteblackcolor,
                          fontFamily: "Gilroy Bold"),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              "assets/images/Maplocation.png",
                              height: 20,
                              color: notifire.getdarkbluecolor,
                            ),
                            Text(
                              "Purwokerto, Karang Lewas",
                              style: TextStyle(
                                  color: notifire.getgreycolor,
                                  fontSize: 14,
                                  fontFamily: "Gilroy Medium"),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset("assets/images/star.png", height: 18),
                            Text(
                              "4.2",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: notifire.getdarkbluecolor,
                                  fontFamily: "Gilroy Bold"),
                            ),
                            Text(
                              "(84 Reviews)",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: notifire.getgreycolor,
                                  fontFamily: "Gilroy Medium"),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),
                    Row(
                      children: [
                        Text(
                          "\$46 ",
                          style: TextStyle(
                              fontSize: 16,
                              color: notifire.getdarkbluecolor,
                              fontFamily: "Gilroy Bold"),
                        ),
                        Text(
                          "Per Night",
                          style: TextStyle(
                              fontFamily: "Gilroy Medium",
                              fontSize: 14,
                              color: notifire.getwhiteblackcolor),
                        ),
                      ],
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015),
                    ReadMoreText(
                      "Diamond Heart Hotel is high rated hotels in Middle Java Purwokerto with 120+ reviews and have high attitude service.",
                      trimLines: 2,
                      trimMode: TrimMode.Line,
                      style: TextStyle(
                          color: notifire.getgreycolor,
                          fontFamily: "Gilroy Medium"),
                      trimCollapsedText: 'Show more',
                      trimExpandedText: 'Show less',
                      lessStyle: TextStyle(color: notifire.getdarkbluecolor),
                      moreStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: notifire.getdarkbluecolor),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Image.asset("assets/images/wifi.png",
                                height: 30, color: notifire.getwhiteblackcolor),
                            Text(
                              "Wifi",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: notifire.getgreycolor,
                                  fontFamily: "Gilroy Medium"),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              "assets/images/shower.png",
                              height: 30,
                              color: notifire.getwhiteblackcolor,
                            ),
                            Text(
                              "shower",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: notifire.getgreycolor,
                                  fontFamily: "Gilroy Medium"),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              "assets/images/breakfast.png",
                              height: 30,
                              color: notifire.getwhiteblackcolor,
                            ),
                            Text(
                              "Breakfast",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: notifire.getgreycolor,
                                  fontFamily: "Gilroy Medium"),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              "assets/images/gym.png",
                              height: 30,
                              color: notifire.getwhiteblackcolor,
                            ),
                            Text(
                              "Gym",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: notifire.getgreycolor,
                                  fontFamily: "Gilroy Medium"),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Location",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "Gilroy Bold",
                              color: notifire.getwhiteblackcolor),
                        ),
                        Text(
                          "View Detail",
                          style: TextStyle(
                              fontSize: 15,
                              color: notifire.getdarkbluecolor,
                              fontFamily: "Gilroy Medium"),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Card(
                      color: notifire.getdarkmodecolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset("assets/images/googlemap.png"),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01),
                            Row(
                              children: [
                                Image.asset("assets/images/Maplocation.png",
                                    height: 20),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.01),
                                Text(
                                  "Haight "
                                  "Streetm Purwokerto, Karang Lewas",
                                  style: TextStyle(
                                      color: notifire.getgreycolor,
                                      fontFamily: "Gilroy Medium"),
                                )
                              ],
                            ),
                            const SizedBox(height: 6),
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Text(
                                "View Details",
                                style: TextStyle(
                                    color: notifire.getdarkbluecolor,
                                    fontFamily: "Gilroy Medium"),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Reviews",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "Gilroy Bold",
                              color: notifire.getwhiteblackcolor),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const review(),
                            ));
                          },
                          child: Text(
                            "See All",
                            style: TextStyle(
                                fontSize: 15,
                                color: notifire.getdarkbluecolor,
                                fontFamily: "Gilroy Medium"),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.035),
                    Container(
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
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
                                    backgroundImage: AssetImage(
                                        hotelList4[index]["img"].toString()),
                                    radius: 25,
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8),
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.54,
                                              child: Text(
                                                hotelList4[index]["title"]
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: notifire
                                                        .getwhiteblackcolor,
                                                    fontFamily: "Gilroy Bold"),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.10),
                                          Image.asset("assets/images/star.png",
                                              height: 20),
                                          InkWell(
                                              onTap: () {
                                                Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                        builder: (context) =>
                                                            const review()))
                                                    .then((value) =>
                                                        print('ok Navigat'));
                                              },
                                              child: Text(
                                                  hotelList4[index]["review"]
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontFamily: "Gilroy Bold",
                                                      color: notifire
                                                          .getwhiteblackcolor)))
                                        ],
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.007),
                                      SizedBox(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.70,
                                        child: Text(
                                          hotelList4[index]["massage"]
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: notifire.getgreycolor,
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
                                color: notifire.getgreycolor,
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ]),
            )
          ],
        )),
      ]),
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
