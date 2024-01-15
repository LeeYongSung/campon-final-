// ignore_for_file: file_names

import 'package:campon_app/example/Login&ExtraDesign/hoteldetail.dart';
import 'package:campon_app/example/Utils/Colors.dart';
import 'package:campon_app/example/Utils/customwidget%20.dart';
import 'package:campon_app/example/Utils/dark_lightmode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowallHotel extends StatefulWidget {
  const ShowallHotel({super.key});

  @override
  State<ShowallHotel> createState() => _ShowallHotelState();
}

class _ShowallHotelState extends State<ShowallHotel> {
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
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(75),
          child: CustomAppbar(
              centertext: "Recomended for you",
              ActionIcon: null,
              bgcolor: notifire.getbgcolor,
              actioniconcolor: notifire.getwhiteblackcolor,
              leadingiconcolor: notifire.getwhiteblackcolor,
              titlecolor: notifire.getwhiteblackcolor)),
      backgroundColor: notifire.getbgcolor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
        child: SizedBox(
            child: ListView.builder(
          itemCount: hotelList.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const hoteldetailpage()));
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                width: 280,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: notifire.getdarkmodecolor),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          // ignore: sized_box_for_whitespace
                          Container(
                            height: 118,
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                hotelList[index]["img"].toString(),
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  height: 30,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: lightBlack),
                                  child: Center(
                                    child: Text(
                                      hotelList[index]["price"].toString(),
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: notifire.getdarkwhitecolor,
                                          fontFamily: "Gilroy Bold"),
                                    ),
                                  )),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Text(
                        hotelList[index]["title"].toString(),
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: "Gilroy Bold",
                            color: notifire.getwhiteblackcolor),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      Text(
                        hotelList[index]["address"].toString(),
                        style: TextStyle(
                            fontSize: 12,
                            color: notifire.getgreycolor,
                            fontFamily: "Gilroy Medium",
                            overflow: TextOverflow.ellipsis),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.001),
                      Divider(color: notifire.getgreycolor),
                      // SizedBox(
                      //     height: MediaQuery.of(context)
                      //             .size
                      //             .height *
                      //         0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          hotelsystem(
                              image: "assets/images/Bed.png",
                              text: "2 Beds",
                              radi: 4),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02),
                          hotelsystem(
                              image: "assets/images/wifi.png",
                              text: "Wifi",
                              radi: 4),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02),
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
      ),
    );
  }

  hotelsystem({String? image, text, double? radi}) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: 6),
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
        const SizedBox(width: 16),
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
