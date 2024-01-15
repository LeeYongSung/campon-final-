// ignore_for_file: camel_case_types

import 'package:campon_app/example/Login&ExtraDesign/NearbyallHotel.dart';
import 'package:campon_app/example/Login&ExtraDesign/ShowallHotel.dart';
import 'package:campon_app/example/Login&ExtraDesign/homepage.dart';
import 'package:campon_app/example/Utils/Colors.dart';
import 'package:campon_app/example/Utils/customwidget%20.dart';
import 'package:campon_app/example/Utils/dark_lightmode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'hoteldetail.dart';
import 'notification.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  //  String dropdownvalue1 = "0";
  // var mexitems = ["0", "1", "2", "3", "4", "5"];
  @override
  void initState() {
    getdarkmodepreviousstate();
    super.initState();
  }

  late ColorNotifire notifire;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        backgroundColor: notifire.getbgcolor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: 190,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: notifire.getdarkmodecolor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          "assets/images/location.png",
                          height: 24,
                          color: Darkblue,
                        ),
                        Text(
                          "Surat Gujrat,India",
                          style: TextStyle(
                              color: notifire.getwhiteblackcolor,
                              fontFamily: "Gilroy Medium"),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Darkblue,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const notification()));
                      },
                      child: CircleAvatar(
                          backgroundColor: notifire.getdarkmodecolor,
                          child: Image.asset(
                            "assets/images/notification.png",
                            height: 25,
                            color: notifire.getwhiteblackcolor,
                          )))
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      Text(
                        "Hello, yagnik! 👋",
                        style: TextStyle(
                            color: notifire.getgreycolor,
                            fontSize: 15,
                            fontFamily: "Gilroy Medium"),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.012),
                      Text(
                        "Let’s find best hotel",
                        style: TextStyle(
                            fontSize: 20,
                            color: notifire.getwhiteblackcolor,
                            fontFamily: "Gilroy Bold"),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: notifire.getdarkmodecolor),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: TextField(
                              onTap: () {
                                setState(() {
                                  selectedIndex = 1;
                                });

                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const homepage()));
                              },
                              readOnly: true,
                              decoration: InputDecoration(
                                hintText: 'Search hotel',
                                hintStyle: TextStyle(
                                    color: notifire.getgreycolor,
                                    fontFamily: "Gilroy Medium"),
                                prefixIcon: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Image.asset("assets/images/search.png",
                                      height: 25, color: notifire.getgreycolor),
                                ),
                                suffixIcon: Icon(
                                  Icons.filter_list,
                                  color: notifire.getgreycolor,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          )),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Recomended Hotel",
                            style: TextStyle(
                                fontFamily: "Gilroy Bold",
                                color: notifire.getwhiteblackcolor),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ShowallHotel(),
                              ));
                            },
                            child: Text(
                              "See All",
                              style: TextStyle(
                                  color: notifire.getdarkbluecolor,
                                  fontFamily: "Gilroy Medium"),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.018),
                      // const SizedBox(height: 10),
                      SizedBox(
                          height: height / 3.1,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: hotelList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const hoteldetailpage()));
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  width: 280,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: notifire.getdarkmodecolor),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          children: [
                                            // ignore: sized_box_for_whitespace
                                            Container(
                                              height: 118,
                                              width: double.infinity,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Image.asset(
                                                  hotelList[index]["img"]
                                                      .toString(),
                                                  height: 120,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                    height: 30,
                                                    width: 70,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        color: lightBlack),
                                                    child: Center(
                                                      child: Text(
                                                        hotelList[index]
                                                                ["price"]
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: WhiteColor,
                                                            fontFamily:
                                                                "Gilroy Bold"),
                                                      ),
                                                    )),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02),
                                        Text(
                                          hotelList[index]["title"].toString(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: "Gilroy Bold",
                                              color:
                                                  notifire.getwhiteblackcolor),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01),
                                        Text(
                                          hotelList[index]["address"]
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: notifire.getgreycolor,
                                              fontFamily: "Gilroy Medium",
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.001),
                                        Divider(color: greyColor),
                                        // SizedBox(
                                        //     height: MediaQuery.of(context)
                                        //             .size
                                        //             .height *
                                        //         0.01),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            hotelsystem(
                                                image: "assets/images/Bed.png",
                                                text: "2 Beds",
                                                radi: 3),
                                            hotelsystem(
                                                image: "assets/images/wifi.png",
                                                text: "Wifi",
                                                radi: 3),
                                            hotelsystem(
                                                image: "assets/images/gym.png",
                                                text: "Gym",
                                                radi: 0),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Nearby Hotels",
                            style: TextStyle(
                                fontFamily: "Gilroy Bold",
                                color: notifire.getwhiteblackcolor),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const NearbyallHotel()));
                            },
                            child: Text(
                              "See All",
                              style: TextStyle(
                                color: notifire.getdarkbluecolor,
                                fontFamily: "Gilroy Medium",
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: hotelList2.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const hoteldetailpage()));
                            },
                            child: Container(
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: notifire.getdarkmodecolor,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 12),
                                    height: 75,
                                    width: 75,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(
                                        hotelList2[index]["img"].toString(),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        hotelList2[index]["title"].toString(),
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: notifire.getwhiteblackcolor,
                                            fontFamily: "Gilroy Bold"),
                                      ),
                                      // const SizedBox(height: 6),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.006),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.65,
                                        child: Text(
                                          hotelList2[index]["address"]
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: notifire.getgreycolor,
                                              fontFamily: "Gilroy Medium",
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01),
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                hotelList2[index]["price"]
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: notifire
                                                        .getdarkbluecolor,
                                                    fontFamily: "Gilroy Bold"),
                                              ),
                                              Text(
                                                hotelList2[index]["Night"]
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color:
                                                        notifire.getgreycolor,
                                                    fontFamily:
                                                        "Gilroy Medium"),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const SizedBox(width: 12),
                                              Image.asset(
                                                "assets/images/star.png",
                                                height: 20,
                                              ),
                                              const SizedBox(width: 2),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      hotelList2[index]
                                                              ["review"]
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: notifire
                                                              .getdarkbluecolor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      hotelList2[index]
                                                              ["reviewCount"]
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: notifire
                                                              .getgreycolor,
                                                          fontFamily:
                                                              "Gilroy Medium"),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  hotelsystem({String? image, text, double? radi}) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          image!,
          height: 25,
          color: notifire.getdarkbluecolor,
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(
              color: notifire.getgreycolor, fontFamily: "Gilroy Medium"),
        ),
        const SizedBox(width: 11),
        CircleAvatar(
          radius: radi,
          backgroundColor: notifire.getgreycolor,
        )
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
