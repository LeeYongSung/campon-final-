// ignore_for_file: non_constant_identifier_names, sized_box_for_whitespace, camel_case_types

import 'package:campon_app/camp/Calander.dart';
import 'package:campon_app/example/Login&ExtraDesign/homepage.dart';
import 'package:campon_app/example/Profile/MyCupon.dart';
import 'package:campon_app/example/Utils/Colors.dart';
import 'package:campon_app/example/Utils/customwidget%20.dart';
import 'package:campon_app/example/Utils/dark_lightmode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Reservate extends StatefulWidget {
  const Reservate({super.key});

  @override
  State<Reservate> createState() => _ReservateState();
}

class _ReservateState extends State<Reservate> {
  int _counter = 0;
  int _counter1 = 0;
  int _counter2 = 0;

  bool isChecked = false;
  bool isChecked1 = false;
  @override
  void initState() {
    getdarkmodepreviousstate();
    super.initState();
  }

  int selectedValue = 1;

  late ColorNotifire notifire;
  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.getbgcolor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(75),
          child: CustomAppbar(
              centertext: "CampOn",
              ActionIcon: Icons.more_vert,
              bgcolor: notifire.getbgcolor,
              actioniconcolor: notifire.getwhiteblackcolor,
              leadingiconcolor: notifire.getwhiteblackcolor,
              titlecolor: notifire.getwhiteblackcolor)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
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
                        color: notifire.getdarkmodecolor,
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
                        Text(
                          "캠핑장명",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Gilroy Bold",
                              color: notifire.getwhiteblackcolor),
                        ),
                        // const SizedBox(height: 6),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.006),
                        Text(
                          "캠핑상품명",
                          style: TextStyle(
                              fontSize: 13,
                              color: notifire.getgreycolor,
                              fontFamily: "Gilroy Medium"),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Divider(),
              Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                      border: Border.symmetric(horizontal:BorderSide (
                        color: notifire.getgreycolor, // 외곽선 색상
                        width: 1.0,) // 외곽선 두께
                      ),
                    ),
                      child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                            children:[
                              Text(
                                "체크인",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: notifire.getwhiteblackcolor,
                                  fontFamily: "Gilroy Bold"),
                              ),
                              const SizedBox(height: 10,),
                              Text(
                                "2024-01-01",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: notifire.getwhiteblackcolor,
                                  fontFamily: "Gilroy Bold"),
                              ),
                            ]
                            ),
                              Text(
                                "1박 2일",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: notifire.getwhiteblackcolor,
                                  fontFamily: "Gilroy Bold"),
                              ),
                            Column(
                            children:[
                              Text(
                                "체크아웃",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: notifire.getwhiteblackcolor,
                                  fontFamily: "Gilroy Bold"),
                              ),
                              const SizedBox(height: 10,),
                              Text(
                                "2024-01-02",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: notifire.getwhiteblackcolor,
                                  fontFamily: "Gilroy Bold"),
                              ),
                            ]
                            ),       
                        ],)
                        ),
              selectdetail(
                image: "assets/images/calendar.png",
                text: "날짜를 선택해주세요.",
                icon: Icons.keyboard_arrow_down,
                onclick: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Calander(),
                  ));}
              ),
              const SizedBox(height: 10),
              Divider(),
              Room(
                text: "숙박 인원",
                onclick1: () {
                  if(_counter1 > 0)
                    setState(() {
                      _counter1--;
                    });
                  },
                middeltext: "$_counter1",
                onclick2: () {
                  setState(() {
                    _counter1++;
                  });
                }),
              const SizedBox(height: 10),
              Divider(),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("예약자명 : ",
                  style: TextStyle(fontSize: 15),),
                  Text("연락처 : ",
                  style: TextStyle(fontSize: 15),)
                ],
              ),
              Divider(),
              SizedBox(height: 10),
              Text("결제 방법", style: TextStyle(fontSize: 15,),textAlign: TextAlign.center),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio(
                    value: 1,
                    groupValue: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value as int;
                      });
                    },
                  ),
                  Text('카드'),

                  Radio(
                    value: 2,
                    groupValue: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value as int;
                      });
                    },
                  ),
                  Text('무통장입금'),]),
                  Divider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("결제 금액",
                          style: TextStyle(
                              fontFamily: "Gilroy Bold",
                              color: notifire.getwhiteblackcolor)),
                      Text("30000000원",
                          style: TextStyle(
                              fontFamily: "Gilroy Bold",
                              color: notifire.getwhiteblackcolor)),
                    ],
                  ),
                  const SizedBox(height: 40),
                  InkWell(
                    onTap: (){},
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          color: Color.fromARGB(255, 254, 217, 131)),
                      child: Center(
                        child: Text("결제하기",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Gilroy Bold")),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget selectdetail({image, text, icon, onclick}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        InkWell(
          onTap: onclick,
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: notifire.getdarkmodecolor),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        image,
                        height: 25,
                        color: notifire.getdarkbluecolor,
                      ),
                      const SizedBox(width: 15),
                      Text(
                        text,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Gilroy Medium",
                            color: notifire.getwhiteblackcolor),
                      ),
                    ],
                  ),
                  Icon(icon, color: notifire.getgreycolor)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }


  Room({text, onclick1, onclick2, middeltext}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text,
                style: TextStyle(
                    fontSize: 16,
                    color: notifire.getwhiteblackcolor,
                    fontFamily: "Gilroy Bold")),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  InkWell(
                    onTap: onclick1,
                    child: CircleAvatar(
                      backgroundColor: notifire.getblackgreycolor,
                      radius: 12,
                      child: Icon(Icons.remove,
                          color: notifire.getdarkwhitecolor, size: 20),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    middeltext,
                    style: TextStyle(color: notifire.getwhiteblackcolor),
                  ),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: onclick2,
                    child: CircleAvatar(
                      backgroundColor: notifire.getdarkbluecolor,
                      radius: 12,
                      child: Icon(Icons.add,
                          color: notifire.getdarkwhitecolor, size: 20),
                    ),
                  ),
                ],
              ),
            )
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
