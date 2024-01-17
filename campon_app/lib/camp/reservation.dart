// ignore_for_file: file_names

// ignore: unused_import
import 'package:campon_app/example/Profile/Favourite.dart';
import 'package:campon_app/example/Utils/customwidget%20.dart';
import 'package:campon_app/example/Utils/dark_lightmode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Reservation extends StatefulWidget {
  const Reservation({super.key});

  @override
  State<Reservation> createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
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
          "CampOn",
          style: TextStyle(
              color: notifire.getwhiteblackcolor, fontFamily: "Gilroy Bold"),
        ),
      ),
      backgroundColor: notifire.getbgcolor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("캠핑장 예약 현황",
                  style: TextStyle(
                      fontSize: 16,
                      color: notifire.getwhiteblackcolor,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              SizedBox(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: notifire.getdarkmodecolor),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: notifire.getdarkmodecolor,
                            ),
                            child: ExpansionTile(
                              tilePadding: EdgeInsets.zero,
                              iconColor: notifire.getwhiteblackcolor,
                              collapsedIconColor: notifire.getwhiteblackcolor,
                              backgroundColor: notifire.getdarkmodecolor,
                              title: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          "assets/images/Rimuru.png",
                                          height: 75,
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "캠핑장명",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: notifire.getwhiteblackcolor,
                                                fontFamily: "Gilroy Bold",
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              "캠핑상품명",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: notifire.getgreycolor,
                                              ),
                                            ),
                                            Text(
                                              "예약번호",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: notifire.getgreycolor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("예약자 정보", style: TextStyle(fontWeight:FontWeight.bold)),
                                        SizedBox(height: 10,),
                                        Text("예약번호"),
                                        Text("예약자명"),
                                        Text("예약인원"),
                                        Text("숙박일수"),
                                        Text("숙박기간"),
                                        Text("캠핑장연락처"),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Icon(Icons.delete),
                                        SizedBox(height: 10,),
                                        Text("21"),
                                        Text("홍길동"),
                                        Text("2명"),
                                        Text("2일"),
                                        Text("2024-01-01 ~ 2024-01-02"),
                                        Text("010-1010-1010"),
                                      ],
                                    ),
                                  ]),
                                ),
                              ],
                              
                            ),
                          ),
                        ),

                      ),
                    );
                  },
                ),
              ),
              
              const SizedBox(height: 10),
              Text("대여상품 대여 현황",
                  style: TextStyle(
                      fontSize: 16,
                      color: notifire.getwhiteblackcolor,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              SizedBox(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: notifire.getdarkmodecolor),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          child: 
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  children:[Image.asset(
                                    "assets/images/Rimuru.png",
                                    height: 75,
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("대여상품명",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color:
                                                  notifire.getwhiteblackcolor,
                                              fontFamily: "Gilroy Bold")),
                                      const SizedBox(height: 6),
                                      Text("상품 기본 정보",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: notifire.getgreycolor)),
                                      Text("개수 / 가격",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: notifire.getgreycolor)),
                                    ],
                                  ),]),
                                  Container(
                                    height: 40,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: notifire.getlightblackcolor.withAlpha(0)),
                                    child: const Center(
                                      child: Icon(Icons.delete)
                                    ),
                                  ),
                                ],
                              ),                           
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Container(
                      width: 150,
                    child:ElevatedButton(
                      onPressed: (){},
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.orange), // 배경색 설정
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
                    ),)),
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
