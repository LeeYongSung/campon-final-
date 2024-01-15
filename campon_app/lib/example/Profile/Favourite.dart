// ignore_for_file: file_names

import 'package:campon_app/example/Utils/Colors.dart';
import 'package:campon_app/example/Utils/customwidget%20.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/dark_lightmode.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
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
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: notifire.getbgcolor,
        leading: BackButton(color: notifire.getwhiteblackcolor),
        title: Text(
          "Favourite",
          style: TextStyle(
              color: notifire.getwhiteblackcolor, fontFamily: "Gilroy Bold"),
        ),
      ),
      backgroundColor: notifire.getbgcolor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Favourite Items",
                  style: TextStyle(
                      fontSize: 16,
                      color: notifire.getwhiteblackcolor,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: hotelList2.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) =>
                      //         const hoteldetailpage()));
                    },
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: notifire.getdarkmodecolor),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                hotelList2[index]["title"].toString(),
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "Gilroy Bold",
                                    color: notifire.getwhiteblackcolor),
                              ),
                              // const SizedBox(height: 6),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.006),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.65,
                                child: Text(
                                  hotelList2[index]["address"].toString(),
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: notifire.getgreycolor,
                                      fontFamily: "Gilroy Medium",
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.01),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        hotelList2[index]["price"].toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Darkblue,
                                            fontFamily: "Gilroy Bold"),
                                      ),
                                      Text(
                                        hotelList2[index]["Night"].toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: greyColor,
                                            fontFamily: "Gilroy Medium"),
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
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Row(
                                          children: [
                                            Text(
                                              hotelList2[index]["review"]
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Darkblue,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              hotelList2[index]["reviewCount"]
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: greyColor,
                                                  fontFamily: "Gilroy Medium"),
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
