// ignore_for_file: file_names

// ignore: unused_import
import 'dart:convert';

import 'package:campon_app/camp/camp_home_screen.dart';
import 'package:campon_app/common/footer_screen.dart';
import 'package:campon_app/example/Profile/Favourite.dart';
import 'package:campon_app/example/Utils/customwidget%20.dart';
import 'package:campon_app/example/Utils/dark_lightmode.dart';
import 'package:campon_app/models/camp.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class Reservation extends StatefulWidget {
  const Reservation({super.key});

  @override
  State<Reservation> createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {

  List<Camp> camp = [];
  List<dynamic> product = [];

  @override
  void initState() {
    getdarkmodepreviousstate();
    super.initState();

    getData().then((data){
      setState((){
        camp = data['campList'];
      });
    });
  }

  Future<Map<String, dynamic>> getData() async{
    var url = 'http://10.0.2.2:8081/api/camp/reservation';
    var response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200){
      var utf8Decoded = utf8.decode(response.bodyBytes);
      final data = jsonDecode(utf8Decoded);

      final productList = data['productList'];
      product = productList;
      print(product);

      List<Camp> reservationList = List<Camp>.from(data['reservationList'].map((item) => Camp.fromJson(item)));
      
      List<Camp>? campList = [];
      for(var i = 0; i < reservationList.length; i++){
        campList.add(Camp(
          campNo: reservationList[i].campNo,
          userNo: reservationList[i].userNo,
          cpdtNo: reservationList[i].cpdtNo,
          campName: reservationList[i].campName,
          cpdtName: reservationList[i].cpdtName,
          reservationNo: reservationList[i].reservationNo,
          userName: reservationList[i].userName,
          reservationNop: reservationList[i].reservationNop,
          reservationDate: reservationList[i].reservationDate,
          reservationStart: reservationList[i].reservationStart,
          reservationEnd: reservationList[i].reservationEnd,
          campTel: reservationList[i].campTel,
          cpiUrl: reservationList[i].cpiUrl,
        ));
      }

      return {
        'campList': campList,
        // 'proudctList' : productList,
      };
    }else{
      print("서버 문제");
      return {};
    }
  }

  Future<void> campdelete(int no) async {
    var url = 'http://10.0.2.2:8081/api/camp/reservation/$no';
    var response = await http.delete(Uri.parse(url));

    if(response.statusCode == 200){
      print("삭제 성공");

    }else{
      print("삭제 실패 ${response.statusCode}");
    }

  }

  Future<void> productdelete(int no) async {
    // var url = 'http:/10.0.2.2:8081/api/'
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
        title: 
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                                   builder: (context) =>
                                       CampHomeScreen()));
          },
          child: Image.asset(
            "assets/images/logo2.png",
            width: 110,
            height: 60,
          ),
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
                  itemCount: camp.length,
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
                                        Container(
                                          height: 75,
                                          width: 75,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: notifire.getdarkmodecolor,
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child:
                                                Image.asset(camp[index].cpiUrl ?? "assets/images/Confidiantehotel.png"),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              camp[index].campName ?? "캠핑장명",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: notifire.getwhiteblackcolor,
                                                fontFamily: "Gilroy Bold",
                                                overflow: TextOverflow.ellipsis
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              camp[index].cpdtName ?? "캠핑상품명",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: notifire.getgreycolor,
                                                overflow: TextOverflow.ellipsis
                                              ),
                                            ),
                                            Text(
                                              "예약번호 : ${camp[index].reservationNo ?? '0'}",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: notifire.getgreycolor,
                                                overflow: TextOverflow.ellipsis
                                              ),
                                            ),
                                          ],
                                        ),
                                  // GestureDetector(
                                  //         onTap: () {
                                  //           showDialog(context: context, builder: (BuildContext context){
                                  //             return AlertDialog(
                                  //               content: Text("리뷰쓰러가기"),
                                  //               actions: [
                                  //                 TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text("취소")),
                                  //                 TextButton(onPressed: (){
                                  //                   // productdelete(product[index]['orderNo']);
                                  //                   // setState(() {
                                  //                   //   product.removeAt(index); 
                                  //                   // });   
                                  //                   Navigator.of(context).pop();
                                  //                 }, child: Text("확인")),
                                  //               ],
                                  //             );
                                  //           });
                                            
                                  //         },
                                  //         child: const Icon(
                                  //           Icons.edit,
                                  //           color: Colors.black
                                  //         ),
                                  // ),
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
                                        Row(children: [
                                        GestureDetector(
                                          onTap: () {
                                            showDialog(context: context, builder: (BuildContext context){
                                              return AlertDialog(
                                                content: Text("예약내역을 삭제하시겠습니까?"),
                                                actions: [
                                                  TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text("취소")),
                                                  TextButton(onPressed: (){
                                                    campdelete(camp[index].reservationNo ?? 0);
                                                    setState(() {
                                                      camp.removeAt(index); 
                                                    });   
                                                    Navigator.of(context).pop();
                                                  }, child: Text("삭제")),
                                                ],
                                              );
                                            });
                                            
                                          },
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.black
                                          ),
                                        ),
                                        SizedBox(width: 10,),
                                        GestureDetector(
                                          onTap: () {
                                            showDialog(context: context, builder: (BuildContext context){
                                              return AlertDialog(
                                                content: Text("리뷰쓰러가기"),
                                                actions: [
                                                  TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text("취소")),
                                                  TextButton(onPressed: (){
                                                      // Navigator.of(context).push(MaterialPageRoute(
                                                      //   builder: (context) => reviewInsert()));
                                                  }, child: Text("확인")),
                                                ],
                                              );
                                            });
                                            
                                          },
                                          child: const Icon(
                                            Icons.edit,
                                            color: Colors.black
                                          ),
                                        ),
                                        ],),
                                        SizedBox(height: 10,),
                                        Text("${camp[index].reservationNo ?? "0"}",overflow: TextOverflow.ellipsis),
                                        Text(camp[index].userName ?? "예약자명",overflow: TextOverflow.ellipsis),
                                        Text("${camp[index].reservationNop ?? '0' } 명",overflow: TextOverflow.ellipsis),
                                        Text("${camp[index].reservationDate ?? '0' } 일",overflow: TextOverflow.ellipsis),
                                        Text("${DateFormat('yyyy-MM-dd').format(camp[index].reservationStart ?? DateTime.now())} ~ ${DateFormat('yyyy-MM-dd').format(camp[index].reservationEnd ?? DateTime.now())}",overflow: TextOverflow.ellipsis),
                                        Text(camp[index].campTel ?? '캠핑장연락처',overflow: TextOverflow.ellipsis),
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
                  itemCount: product.length,
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
                                  children:[
                                  Container(
                                          height: 75,
                                          width: 75,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: notifire.getdarkmodecolor,
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child:
                                                Image.asset(product[index]["productThumnail"].toString(),),
                                          ),
                                        ),
                                  
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.6,
                                        child: Text(
                                          product[index]["productName"].toString(),
                                          style: TextStyle(
                                            fontSize: 16,
                                            color:notifire.getwhiteblackcolor,
                                            fontFamily: "Gilroy Bold",
                                            overflow: TextOverflow.ellipsis),
                                        ),
                                      ),
                                      Text(product[index]["productCategory"].toString(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: notifire.getgreycolor)),
                                      Text("${product[index]["productPrice"].toString()}원 * ${product[index]["orderCnt"].toString()}개",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: notifire.getgreycolor)),
                                    ],
                                  ),]),
                                  Column(
                                  children: [
                                  GestureDetector(
                                          onTap: () {
                                            showDialog(context: context, builder: (BuildContext context){
                                              return AlertDialog(
                                                content: Text("리뷰쓰러가기"),
                                                actions: [
                                                  TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text("취소")),
                                                  TextButton(onPressed: (){
                                                    // productdelete(product[index]['orderNo']);
                                                    // setState(() {
                                                    //   product.removeAt(index); 
                                                    // });   
                                                    Navigator.of(context).pop();
                                                  }, child: Text("확인")),
                                                ],
                                              );
                                            });
                                            
                                          },
                                          child: const Icon(
                                            Icons.edit,
                                            color: Colors.black
                                          ),
                                  ),
                                  SizedBox(height: 20,),
                                  GestureDetector(
                                          onTap: () {
                                            showDialog(context: context, builder: (BuildContext context){
                                              return AlertDialog(
                                                content: Text("대여내역을 삭제하시겠습니까?"),
                                                actions: [
                                                  TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text("취소")),
                                                  TextButton(onPressed: (){
                                                    // productdelete(product[index]['orderNo']);
                                                    // setState(() {
                                                    //   product.removeAt(index); 
                                                    // });   
                                                    Navigator.of(context).pop();
                                                  }, child: Text("삭제")),
                                                ],
                                              );
                                            });
                                            
                                          },
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.black
                                          ),
                                  ),
                                ],
                              ),                                  ],)                           
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
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(
                                   builder: (context) =>
                                       CampHomeScreen()));
                      },
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
