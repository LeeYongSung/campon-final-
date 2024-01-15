// ignore_for_file: camel_case_types, avoid_print

import 'package:campon_app/example/Utils/Colors.dart';
import 'package:campon_app/example/Utils/customwidget%20.dart';
import 'package:campon_app/example/Utils/dark_lightmode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class review extends StatefulWidget {
  const review({super.key});

  @override
  State<review> createState() => _reviewState();
}

class _reviewState extends State<review> {
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
              centertext: "Reviews",
              ActionIcon: Icons.more_vert,
              bgcolor: bgcolor)),
      backgroundColor: bgcolor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: WhiteColor,
                ),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      height: 75,
                      width: 75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: WhiteColor,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child:
                            Image.asset("assets/images/Confidiantehotel.png"),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Diamond Heart Hotel",
                          style: TextStyle(
                              fontSize: 15, fontFamily: "Gilroy Bold"),
                        ),
                        // const SizedBox(height: 6),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.006),
                        Text(
                          "Purwokerto, Karang Lewas",
                          style: TextStyle(
                              fontSize: 13,
                              color: greyColor,
                              fontFamily: "Gilroy Medium"),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Row(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "\$46 /",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Darkblue,
                                      fontFamily: "Gilroy Bold"),
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  "Night",
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
                                        "4.6",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Darkblue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "(142 Reviews)",
                                        style: TextStyle(
                                            fontSize: 14, color: greyColor),
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
              ListView.builder(
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
                                          0.55,
                                      child: Text(
                                        hotelList4[index]["title"].toString(),
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontFamily: "Gilroy Bold"),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.10),
                                  Image.asset("assets/images/star.png",
                                      height: 20),
                                  InkWell(
                                      onTap: () {
                                        print('ok Navigat');
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const review()));
                                      },
                                      child: Text(
                                          hotelList4[index]["review"]
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)))
                                ],
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.007),
                              SizedBox(
                                height: 40,
                                width: MediaQuery.of(context).size.width * 0.70,
                                child: Text(
                                  hotelList4[index]["massage"].toString(),
                                  style:
                                      TextStyle(fontSize: 14, color: greyColor),
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
