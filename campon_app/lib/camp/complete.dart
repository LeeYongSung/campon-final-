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

class Complete extends StatefulWidget {
  const Complete({super.key});

  @override
  State<Complete> createState() => _CompleteState();
}

class _CompleteState extends State<Complete> {
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

              const SizedBox(height: 10),
              Divider(),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("예약번호 :",
                          style: TextStyle(fontSize: 15,
                              fontFamily: "Gilroy Bold",)),
                      Text("21",
                          style: TextStyle(fontSize: 15,
                              fontFamily: "Gilroy Bold",)),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("예약자명 :",
                          style: TextStyle(fontSize: 15,
                              fontFamily: "Gilroy Bold",)),
                      Text("홍길동",
                          style: TextStyle(fontSize: 15,
                              fontFamily: "Gilroy Bold",)),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("숙박일수 :",
                          style: TextStyle(fontSize: 15,
                              fontFamily: "Gilroy Bold",)),
                      Text("2",
                          style: TextStyle(fontSize: 15,
                              fontFamily: "Gilroy Bold",)),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("숙박기간 :",
                          style: TextStyle(fontSize: 15,
                              fontFamily: "Gilroy Bold",)),
                      Text("2024-01-01 ~ 2024-01-02",
                          style: TextStyle(fontSize: 15,
                              fontFamily: "Gilroy Bold",)),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("결제방법 :",
                          style: TextStyle(fontSize: 15,
                              fontFamily: "Gilroy Bold",)),
                      Text("무통장입금",
                          style: TextStyle(fontSize: 15,
                              fontFamily: "Gilroy Bold",)),
                    ],
                  ),
                  SizedBox(height: 5,)
                ],
              ),
              Divider(),
              SizedBox(height: 15,),
              Text("통장번호가 출력될거에여", textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                ElevatedButton(
                      onPressed: (){},
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow), // 배경색 설정
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0), // 모서리 radius 조절
                            ),
                          ),
                        ), 
                      child: 
                        Text(
                        "홈으로",
                        style: TextStyle(
                          fontSize: 15,
                          color: notifire.getwhiteblackcolor,
                          fontFamily: "Gilroy Bold"),
                    ),),
                    ElevatedButton(
                      onPressed: (){},
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // 배경색 설정
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0), // 모서리 radius 조절
                            ),
                          ),
                        ), 
                      child: 
                        Text(
                        "예약조회",
                        style: TextStyle(
                          fontSize: 15,
                          color: notifire.getwhiteblackcolor,
                          fontFamily: "Gilroy Bold"),
                    ),)
              ],)

            
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
