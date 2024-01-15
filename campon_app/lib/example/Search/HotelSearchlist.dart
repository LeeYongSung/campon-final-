// ignore_for_file: file_names, prefer_final_fields, unused_field, non_constant_identifier_names, sized_box_for_whitespace

import 'package:campon_app/example/Utils/Colors.dart';
import 'package:campon_app/example/Utils/customwidget%20.dart';
import 'package:campon_app/example/Utils/dark_lightmode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HotelSearchlist extends StatefulWidget {
  const HotelSearchlist({super.key});

  @override
  State<HotelSearchlist> createState() => _HotelSearchlistState();
}

class _HotelSearchlistState extends State<HotelSearchlist> {
  bool _enable = false;
  bool switchValue = false;
  String dropdownvalue = "0";
  var items = ["0", "1", "2", "3", "4"];
  String dropdownvalue1 = "0";
  var mexitems = ["0", "1", "2", "3", "4", "5"];
  bool isChecked = false;
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  bool isChecked4 = false;
  bool isChecked5 = false;
  bool isChecked6 = false;
  bool isChecked7 = false;
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
          child: AppBar(
            backgroundColor: notifire.getbgcolor,
            actions: [
              Padding(
                  padding: const EdgeInsets.only(top: 30, right: 18),
                  child: InkWell(
                    onTap: bottomsheet,
                    child: Image.asset(
                      "assets/images/Filter.png",
                      height: 50,
                      color: notifire.getwhiteblackcolor,
                    ),
                  ))
            ],
            elevation: 0,
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text(
                "Search",
                style: TextStyle(
                    color: notifire.getwhiteblackcolor,
                    fontFamily: "Gilroy Bold",
                    fontSize: 20),
              ),
            ),
            leading: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: BackButton(
                  color: notifire.getwhiteblackcolor,
                )),
          )),
      backgroundColor: notifire.getbgcolor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      50,
                    ),
                    color: notifire.getdarkmodecolor),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search hotel',
                      hintStyle: TextStyle(color: notifire.getgreycolor),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "assets/images/search.png",
                          height: 50,
                          color: notifire.getgreycolor,
                        ),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                            onTap: Shortby,
                            child: Icon(
                              Icons.filter_list,
                              color: notifire.getgreycolor,
                            )),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                )),
            const SizedBox(height: 15),
            Text(
              "Popular Hotels",
              style: TextStyle(
                  fontSize: 16,
                  color: notifire.getwhiteblackcolor,
                  fontFamily: "Gilroy Bold"),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: SizedBox(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: hotelList2.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: notifire.getdarkmodecolor),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 140,
                                    width: double.infinity,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12)),
                                      child: Image.asset(
                                        hotelList2[index]["img"].toString(),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 30,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: lightBlack),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Image.asset(
                                                "assets/images/star.png",
                                                height: 17),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 4),
                                              child: Text(
                                                hotelList2[index]["review"]
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: WhiteColor,
                                                    fontFamily: "Gilroy Bold"),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          hotelList2[index]["title"].toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              color:
                                                  notifire.getwhiteblackcolor,
                                              fontFamily: "Gilroy Bold"),
                                        ),
                                        Text(
                                          hotelList3[index]["price"].toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: notifire.getdarkbluecolor,
                                              fontFamily: "Gilroy Bold"),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              "assets/images/location.png",
                                              height: 20,
                                              color: notifire.getdarkbluecolor,
                                            ),
                                            const SizedBox(width: 10),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.60,
                                              child: Text(
                                                hotelList2[index]["address"]
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color:
                                                        notifire.getgreycolor,
                                                    fontFamily: "Gilroy Medium",
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Per Night",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: notifire.getgreycolor,
                                                  fontFamily: "Gilroy Medium"),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Divider(color: greyColor),
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
                                            radi: 3),
                                        hotelsystem(
                                            image: "assets/images/Frame.png",
                                            text: "Breakfast",
                                            radi: 0),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // HotelService() {
  //   return;
  // }

  bottomsheet() {
    return showModalBottomSheet(
        backgroundColor: notifire.getbgcolor,
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.93,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Filter",
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: "Gilroy Bold",
                                color: notifire.getwhiteblackcolor),
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(
                                Icons.close,
                                color: notifire.getwhiteblackcolor,
                              ))
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      Text(
                        "Guests",
                        style: TextStyle(
                            fontSize: 16,
                            color: notifire.getwhiteblackcolor,
                            fontFamily: "Gilroy Bold"),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: notifire.getdarkmodecolor),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Guest detail",
                            hintStyle: TextStyle(
                              color: notifire.getgreycolor,
                              fontFamily: "Gilroy Medium",
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(6),
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: Darkblue,
                              ),
                            ),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xffE2E4EA),
                                ),
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Divider(color: notifire.getgreycolor),
                      const SizedBox(height: 4),
                      Text(
                        "Price Range",
                        style: TextStyle(
                            fontSize: 16,
                            color: notifire.getwhiteblackcolor,
                            fontFamily: "Gilroy Bold"),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width / 2.2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: notifire.getdarkmodecolor),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Min",
                                hintStyle: TextStyle(
                                    fontFamily: "Gilroy Medium",
                                    color: notifire.getgreycolor),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      elevation: 0,
                                      value: dropdownvalue1,
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: notifire.getdarkbluecolor,
                                      ),
                                      items: items.map((String items) {
                                        return DropdownMenuItem(
                                            value: items,
                                            child: Text(items.toString()));
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownvalue1 = newValue!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xffE2E4EA),
                                    ),
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width / 2.2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: notifire.getdarkmodecolor),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Max",
                                hintStyle: TextStyle(
                                    fontFamily: "Gilroy Medium",
                                    color: notifire.getgreycolor),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      elevation: 0,
                                      value: dropdownvalue,
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: notifire.getdarkbluecolor,
                                      ),
                                      items: mexitems.map((String mexitems) {
                                        return DropdownMenuItem(
                                            value: mexitems,
                                            child: Text(
                                              mexitems.toString(),
                                            ));
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownvalue = newValue!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xffE2E4EA),
                                    ),
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Divider(color: notifire.getgreycolor),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Instant Book",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: notifire.getwhiteblackcolor,
                                    fontFamily: "Gilroy Bold"),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "Book without waiting for the host to respond",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: greyColor,
                                    fontFamily: "Gilroy Medium"),
                              ),
                            ],
                          ),
                          Container(
                            height: 42.0,
                            width: 60.0,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CupertinoSwitch(
                                  value: switchValue,
                                  thumbColor: notifire.getdarkwhitecolor,
                                  trackColor: notifire.getbuttoncolor,
                                  activeColor: notifire.getdarkbluecolor,
                                  onChanged: (value) {
                                    setState(() {
                                      switchValue = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Divider(color: notifire.getgreycolor),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      Text(
                        "Facilities",
                        style: TextStyle(
                            fontSize: 16,
                            color: notifire.getwhiteblackcolor,
                            fontFamily: "Gilroy Bold"),
                      ),
                      const SizedBox(height: 6),
                      Facilitiesinsidehotel(
                        text: "Free Wifi",
                        ChackValue: isChecked,
                        OnChange: (value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                      Facilitiesinsidehotel(
                        text: "Swimming Pool",
                        ChackValue: isChecked1,
                        OnChange: (value1) {
                          setState(() {
                            isChecked1 = value1!;
                          });
                        },
                      ),
                      Facilitiesinsidehotel(
                        text: "Tv",
                        ChackValue: isChecked2,
                        OnChange: (value2) {
                          setState(() {
                            isChecked2 = value2!;
                          });
                        },
                      ),
                      Facilitiesinsidehotel(
                        text: "Laundry",
                        ChackValue: isChecked3,
                        OnChange: (value3) {
                          setState(() {
                            isChecked3 = value3!;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      Divider(color: notifire.getgreycolor),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      Text(
                        "Ratings",
                        style: TextStyle(
                            fontSize: 16,
                            color: notifire.getwhiteblackcolor,
                            fontFamily: "Gilroy Bold"),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Ratings(RetingText: "5"),
                          Ratings(RetingText: "4"),
                          Ratings(RetingText: "3"),
                          Ratings(RetingText: "2"),
                          Ratings(RetingText: "1"),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04),
                      AppButton(buttontext: "Show 8 Results", onclick: () {})
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  Facilitiesinsidehotel(
      {Function(bool?)? OnChange, bool? ChackValue, String? text}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text!,
          style: TextStyle(
              fontSize: 15, color: greyColor, fontFamily: "Gilroy Medium"),
        ),
        const SizedBox(width: 25),
        SizedBox(
          height: 35,
          width: 35,
          child: Theme(
            data: ThemeData(unselectedWidgetColor: notifire.getwhiteblackcolor),
            child: Checkbox(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: notifire.getwhiteblackcolor)),
                value: ChackValue,
                onChanged: OnChange),
          ),
        ),
      ],
    );
  }

  Ratings({String? RetingText}) {
    return Container(
      height: 35,
      width: 55,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: notifire.getdarkmodecolor),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset("assets/images/star.png", height: 15),
            Text(
              RetingText!,
              style: TextStyle(
                fontSize: 14,
                color: notifire.getwhiteblackcolor,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }

  Shortby() {
    return showModalBottomSheet(
        // isScrollControlled: true,
        backgroundColor: notifire.getbgcolor,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.30,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sort By",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Gilroy Bold",
                              color: notifire.getwhiteblackcolor),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.close,
                              color: notifire.getwhiteblackcolor,
                            ))
                      ],
                    ),
                    const SizedBox(height: 10),
                    Facilitiesinsidehotel(
                      text: "Free Wifi",
                      ChackValue: isChecked4,
                      OnChange: (value4) {
                        setState(() {
                          isChecked4 = value4!;
                        });
                      },
                    ),
                    Facilitiesinsidehotel(
                      text: "Swimming Pool",
                      ChackValue: isChecked5,
                      OnChange: (value5) {
                        setState(() {
                          isChecked5 = value5!;
                        });
                      },
                    ),
                    Facilitiesinsidehotel(
                      text: "Tv",
                      ChackValue: isChecked6,
                      OnChange: (value6) {
                        setState(() {
                          isChecked6 = value6!;
                        });
                      },
                    ),
                    Facilitiesinsidehotel(
                      text: "Laundry",
                      ChackValue: isChecked7,
                      OnChange: (value7) {
                        setState(() {
                          isChecked7 = value7!;
                        });
                      },
                    ),
                  ],
                ),
              ),
            );
          });
        });
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
        const SizedBox(width: 3),
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
