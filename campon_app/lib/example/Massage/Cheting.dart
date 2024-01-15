// ignore_for_file: file_names, non_constant_identifier_names

import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:campon_app/example/Utils/Colors.dart';
import 'package:campon_app/example/Utils/dark_lightmode.dart';
// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Chating extends StatefulWidget {
  const Chating({super.key});

  @override
  State<Chating> createState() => _ChatingState();
}

class _ChatingState extends State<Chating> {
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
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          // ignore: sized_box_for_whitespace
          Container(
            height: 70,
            child: ListTile(
              contentPadding: const EdgeInsets.only(left: 0, right: 10),
              visualDensity: VisualDensity.standard,
              leading: Padding(
                padding: const EdgeInsets.only(left: 12, top: 6),
                child: CircleAvatar(
                    backgroundColor: notifire.getdarkmodecolor,
                    child: BackButton(color: notifire.getwhiteblackcolor)),
              ),
              title: Column(
                children: [
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Positioned(
                            child: Image.asset(
                              "assets/images/CircleAvatarimage.png",
                              height: 50,
                              width: 60,
                            ),
                          ),
                          Positioned(
                              left: 41,
                              top: 0,
                              child: CircleAvatar(
                                backgroundColor: WhiteColor,
                                radius: 8,
                                child: const CircleAvatar(
                                  backgroundColor: Colors.green,
                                  radius: 6,
                                ),
                              ))
                        ],
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text("Kim Hayo",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: notifire.getwhiteblackcolor,
                                  fontFamily: "Gilroy Bold")),
                          const SizedBox(height: 4),
                          Text("Online",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: notifire.getgreycolor,
                                  fontFamily: "Gilroy Medium")),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              trailing: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: CircleAvatar(
                  backgroundColor: notifire.getdarkmodecolor,
                  child: Icon(
                    Icons.more_vert,
                    color: notifire.getwhiteblackcolor,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
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
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: WhiteColor,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                  "assets/images/Confidiantehotel.png"),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hyatt Washington Hotel",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "Gilroy Bold",
                                    color: notifire.getwhiteblackcolor),
                              ),
                              // const SizedBox(height: 6),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.006),
                              Text(
                                "Purwokerto, Gleaming",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: notifire.getgreycolor,
                                    fontFamily: "Gilroy Medium"),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.01),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "\$38 /",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: notifire.getdarkbluecolor,
                                            fontFamily: "Gilroy Bold"),
                                      ),
                                      Text(
                                        " Night",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: notifire.getgreycolor,
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
                                              "4.2",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color:
                                                      notifire.getdarkbluecolor,
                                                  fontWeight: FontWeight.bold),
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
                    Massagelist(
                        SenderText:
                            "Hi, is there any room left? I’ll make noorder if room is available",
                        timetext2: "8:14 Am",
                        timetext: "8:12 Am",
                        timetext3: "8:16 Am",
                        ReciveText:
                            "Hello Marine, Yes the room is available,so you can make an order.",
                        ReciveText2: "Thank You! 😁",
                        SenderText2: "Thanks for your information"),
                    // SizedBox(
                    //   child: ListView.builder(
                    //     physics: NeverScrollableScrollPhysics(),
                    //     shrinkWrap: true,
                    //     padding: EdgeInsets.zero,
                    //     itemCount: 5,
                    //     itemBuilder: (BuildContext context, int index) {
                    //       return Padding(
                    //         padding: const EdgeInsets.symmetric(vertical: 6),
                    //         child:
                    //       );
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Write a reply",
                hintStyle: TextStyle(
                    fontFamily: "Gilroy Medium", color: notifire.getgreycolor),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: CustomPopupMenu(
                    arrowSize: 15,
                    arrowColor: const Color(0XFF151B33),
                    // ignore: sort_child_properties_last
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/images/pin.png",
                        height: 25,
                        color: notifire.getgreycolor,
                      ),
                    ),
                    menuBuilder: () => ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        width: 50,
                        color: const Color(0XFF151B33),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Image.asset("assets/images/gallery.png",
                                    height: 30),
                              ),
                              Divider(
                                color: greyColor,
                                endIndent: 12,
                                indent: 12,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Image.asset("assets/images/location.png",
                                    height: 30),
                              ),
                              Divider(
                                color: greyColor,
                                endIndent: 12,
                                indent: 12,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Image.asset("assets/images/document.png",
                                    height: 30),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    pressType: PressType.singleClick,
                  ),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Icon(
                    Icons.send,
                    color: Darkblue,
                  ),
                ),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: notifire.getgreywhite,
                    ),
                    borderRadius: BorderRadius.circular(50)),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          )
        ],
      ),
    );
  }

  Massagelist(
      {SenderText,
      ReciveText,
      ReciveText2,
      SenderText2,
      timetext,
      timetext2,
      timetext3}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    color: notifire.getdarkbluecolor),
                width: MediaQuery.of(context).size.width * 0.70,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Column(
                    children: [
                      Text(
                        SenderText,
                        style: TextStyle(
                            fontSize: 14,
                            color: notifire.getdarkwhitecolor,
                            fontFamily: "Gilroy Medium"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              timetext,
              style: TextStyle(
                  color: notifire.getgreycolor,
                  fontSize: 15,
                  fontFamily: "Gilroy Medium"),
            )
          ],
        ),
        const SizedBox(height: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    color: notifire.getdarkmodecolor),
                width: MediaQuery.of(context).size.width * 0.70,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Text(
                    ReciveText,
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Gilroy Medium",
                        color: notifire.getwhiteblackcolor),
                  ),
                ),
              ),
            ),
            // SizedBox(height: 4),
            // Text("8:14 Am", style: TextStyle(color: greyColor, fontSize: 15))
          ],
        ),
        const SizedBox(height: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    color: notifire.getdarkmodecolor),
                width: MediaQuery.of(context).size.width * 0.70,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Text(
                    ReciveText2,
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Gilroy Medium",
                        color: notifire.getwhiteblackcolor),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(timetext2,
                style: TextStyle(
                    color: notifire.getgreycolor,
                    fontSize: 15,
                    fontFamily: "Gilroy Medium")),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        color: notifire.getdarkbluecolor),
                    width: MediaQuery.of(context).size.width * 0.70,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: Column(
                        children: [
                          Text(
                            SenderText,
                            style: TextStyle(
                                fontSize: 14,
                                color: notifire.getdarkwhitecolor,
                                fontFamily: "Gilroy Medium"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  timetext3,
                  style: TextStyle(
                      color: notifire.getgreycolor,
                      fontSize: 15,
                      fontFamily: "Gilroy Medium"),
                )
              ],
            ),
          ],
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
