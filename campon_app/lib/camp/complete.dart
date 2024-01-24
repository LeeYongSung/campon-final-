// ignore_for_file: non_constant_identifier_names, sized_box_for_whitespace, camel_case_types

import 'dart:convert';

import 'package:campon_app/camp/Calander.dart';
import 'package:campon_app/camp/camp_home_screen.dart';
import 'package:campon_app/camp/reservation.dart';
import 'package:campon_app/common/footer_screen.dart';
import 'package:campon_app/example/Login&ExtraDesign/homepage.dart';
import 'package:campon_app/example/Profile/MyCupon.dart';
import 'package:campon_app/example/Utils/Colors.dart';
import 'package:campon_app/example/Utils/customwidget%20.dart';
import 'package:campon_app/example/Utils/dark_lightmode.dart';
import 'package:campon_app/models/camp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Complete extends StatefulWidget {
  const Complete({super.key});

  @override
  State<Complete> createState() => _CompleteState();
}

class _CompleteState extends State<Complete> {

  Camp reserve = Camp(); 

  bool isChecked = false;
  bool isChecked1 = false;
  @override
  void initState() {
    getdarkmodepreviousstate();
    super.initState();
    getReserve().then((data){
      setState((){
        reserve = data;
      });
    });
  }

  Future<Camp> getReserve() async{
    var url = 'http://10.0.2.2:8081/api/camp/complete';
    var response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      var utf8Decoded = utf8.decode(response.bodyBytes);
      Map<String, dynamic> jsonData = json.decode(utf8Decoded);

      
      
      Camp camp = Camp(
        cpiUrl: jsonData['cpiUrl'],
      campName: jsonData['campName'],
      cpdtName: jsonData['cpdtName'],
      reservationNo: jsonData['reservationNo'],
      userName: jsonData['userName'],
      reservationDate: jsonData['reservationDate'],
      reservationStart: DateTime.parse(jsonData['reservationStart']),
      reservationEnd: DateTime.parse(jsonData['reservationEnd']),
      campPaymentType: jsonData['campPaymentType'],
      );

      return camp;
    }else{
      print("서버 문제");
      return Camp();
    }
  }

  int selectedValue = 1;

  late ColorNotifire notifire;
  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.getbgcolor,
      appBar: AppBar(
        // leading: Text(""),
        backgroundColor: notifire.getbgcolor,
        title: Image.asset(
                        "assets/images/logo2.png",
                        width: 110,
                        height: 60,
              ),
        centerTitle: true,
      ),
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
                            Image.asset(reserve.cpiUrl ?? "assets/images/Confidiantehotel.png",
                            fit: BoxFit.cover,),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          reserve.campName ?? "캠핑장명",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Gilroy Bold",
                              color: notifire.getwhiteblackcolor),
                        ),
                        // const SizedBox(height: 6),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.006),
                        Text(
                          reserve.cpdtName ?? "캠핑상품명",
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("예약번호 : ",
                          style: TextStyle(fontSize: 15,
                              fontFamily: "Gilroy Bold",)),
                      Text('${reserve.reservationNo ?? "번호"}',
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
                      Text(reserve.userName ?? "예약자명",
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
                      Text((reserve.reservationDate ?? "일수").toString(),
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
                      Text("${reserve.reservationStart != null ? DateFormat('yyyy-MM-dd').format(reserve.reservationStart!) : "00"} ~ ${reserve.reservationEnd != null ? DateFormat('yyyy-MM-dd').format(reserve.reservationEnd!) : "00"}",
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
                      Text(reserve.campPaymentType ?? "결제방법",
                          style: TextStyle(fontSize: 15,
                              fontFamily: "Gilroy Bold",)),
                    ],
                  ),
                  SizedBox(height: 5,)
                ],
              ),
              Divider(),
              SizedBox(height: 15,),
              if( reserve.campPaymentType == "bankbook")
              Text("통장번호가 출력될거에여", textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const CampHomeScreen()));
                      },
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
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Reservation()));
                      },
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
              ],),
              const Divider(),
              const SizedBox(height: 50,),
              const FooterScreen()
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
