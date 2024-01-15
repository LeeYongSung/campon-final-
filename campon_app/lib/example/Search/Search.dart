// ignore_for_file: file_names, library_private_types_in_public_api, prefer_const_constructors_in_immutables, non_constant_identifier_names

import 'package:campon_app/example/Profile/NotificationSetting.dart';
import 'package:campon_app/example/Search/HotelSearchlist.dart';
import 'package:campon_app/example/Utils/Colors.dart';
import 'package:campon_app/example/Utils/customwidget%20.dart';
import 'package:campon_app/example/Utils/dark_lightmode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Search extends StatefulWidget {
  Search({super.key});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var datai = ['a', 'b', 'c'];

  TextEditingController editingController = TextEditingController();
  bool Clearall = false;
  bool notification = false;
  final duplicateItems = List<String>.generate(10, (i) => "Data $i");
  // final duplicateItems = List<String>datai=datai();
  var data = <String>[];

  @override
  void initState() {
    getdarkmodepreviousstate();

    data.addAll(duplicateItems);
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = <String>[];
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      List<String> dummyListData = <String>[];
      // ignore: avoid_function_literals_in_foreach_calls
      dummySearchList.forEach((item) {
        if (item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        data.clear();
        data.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        data.clear();
        data.addAll(duplicateItems);
      });
    }
  }

  late ColorNotifire notifire;

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.getbgcolor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Search",
                  style: TextStyle(
                      fontSize: 18,
                      color: notifire.getwhiteblackcolor,
                      fontFamily: "Gilroy Bold"),
                ),
                InkWell(
                  onTap: () {},
                  child: Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const NotificationSetting()));
                          setState(() {
                            notification = !notification;
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: notifire.getdarkmodecolor,
                          child: Image.asset(
                            "assets/images/notification.png",
                            height: 25,
                            color: notifire.getwhiteblackcolor,
                          ),
                        ),
                      ),
                      Positioned(
                          right: 3,
                          child: !notification
                              ? CircleAvatar(
                                  radius: 4,
                                  backgroundColor: notifire.getredcolor,
                                )
                              : const SizedBox())
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
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
                    readOnly: true,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const HotelSearchlist()));
                    },
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
                      suffixIcon:
                          Icon(Icons.filter_list, color: notifire.getgreycolor),
                      border: InputBorder.none,
                    ),
                  ),
                )),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Recent Searches",
                          style: TextStyle(
                              fontSize: 16,
                              color: notifire.getgreycolor,
                              fontFamily: "Gilroy Medium"),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              Clearall = !Clearall;
                            });
                          },
                          child: Text(
                            "Clear All",
                            style: TextStyle(
                                fontSize: 15,
                                color: notifire.getredcolor,
                                fontFamily: "Gilroy Medium"),
                          ),
                        ),
                      ],
                    ),
                    !Clearall
                        ? ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.032),
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/clock.png",
                                        color: notifire.getgreycolor,
                                        height: 25,
                                      ),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Semarang",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: "Gilroy Bold",
                                                color: notifire
                                                    .getwhiteblackcolor),
                                          ),
                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.0070),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.80,
                                            child: Text(
                                                "Dominic Hotel, Luxury Royale Hotel, Hotel Santika",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: "Gilroy Medium",
                                                    color:
                                                        notifire.getgreycolor),
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              );
                            },
                          )
                        : const SizedBox(),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Recently Viewed",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "Gilroy Bold",
                              color: notifire.getwhiteblackcolor),
                        ),
                        Text(
                          "See All",
                          style: TextStyle(
                              fontSize: 15,
                              color: notifire.getdarkbluecolor,
                              fontFamily: "Gilroy Medium"),
                        ),
                      ],
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025),
                    SizedBox(
                        height: 240,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: hotelList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) => hoteldetailpage()));
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
                                            Container(
                                              height: 118,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
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
                                                                " Gilroy Bold"),
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
                                              color:
                                                  notifire.getwhiteblackcolor,
                                              fontFamily: "Gilroy Bold"),
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
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.0036),
                                        Divider(color: greyColor),
                                        // SizedBox(
                                        //     height: MediaQuery.of(context)
                                        //             .size
                                        //             .height *
                                        //         0.04),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            hotelsystem(
                                                image: "assets/images/Bed.png",
                                                text: "2 Beds",
                                                radi: 4),
                                            hotelsystem(
                                                image: "assets/images/wifi.png",
                                                text: "Wifi",
                                                radi: 4),
                                            hotelsystem(
                                                image: "assets/images/gym.png",
                                                text: "Gym",
                                                radi: 0),
                                          ],
                                        )
                                      ]),
                                ),
                              ),
                            );
                          },
                        )),
                  ],
                ),
              ),
            )
          ],
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
          height: 22,
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
