import 'dart:convert';

import 'package:campon_app/board/board_main.dart';
import 'package:campon_app/camp/campproduct.dart';
import 'package:campon_app/common/footer_screen.dart';
import 'package:campon_app/example/Utils/dark_lightmode.dart';
import 'package:campon_app/models/board.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class storereviewRead extends StatefulWidget {
  int? prNo;
  storereviewRead({super.key, required this.prNo});

  @override
  State<storereviewRead> createState() => _storereviewReadState();
}

class _storereviewReadState extends State<storereviewRead> {
  Board review = Board();

  @override
  void initState() {
    getdarkmodepreviousstate();
    super.initState();
    getReview().then((data){
      setState((){
        review = data;
      });
    });
  }

  Future<Board> getReview() async {
    var url = 'http://10.0.2.2:8081/api/board/prread/${widget.prNo}';
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200) {
      var utf8Decoded = utf8.decode(response.bodyBytes);
      Map<String,dynamic> data = jsonDecode(utf8Decoded);
      Board board = Board(
        prNo: data['prNo'],
        prTitle: data['prTitle'],
        userName: data['userName'],
        productThumnail: data['productThumnail'],
        productName: data['productName'],
        productCategory: data['productCategory'],
        orderCnt: data['orderCnt'],
        prCon: data['prCon'],
        prImg: data['prImg'],
      );  
      print("board: $data");
      return board;
    }else{
      print("서버오류");
      return Board();
    }
  }

  late ColorNotifire notifire;
  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      appBar:AppBar(
        backgroundColor: notifire.getbgcolor,
        title: Image.asset(
                        "assets/images/logo2.png",
                        width: 110,
                        height: 60,
              ),
        centerTitle: true,
      ),
      backgroundColor: notifire.getbgcolor,
      body: ListView(
        children:[Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child:ElevatedButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const boardMain()));
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.orange), 
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                ),
              ), 
            child: 
              Text(
              "목록",
              style: TextStyle(
                fontSize: 15,
                color: notifire.getblackwhitecolor,
                fontFamily: "Gilroy Bold"),
          ),),),
          const Divider(),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            child: Padding(padding: EdgeInsets.symmetric(horizontal: 10) ,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width:MediaQuery.of(context).size.width * 0.1,
                  child:FittedBox(
                    fit: BoxFit.scaleDown,
                      child: Text(
                        "${review.prNo}",
                        style: TextStyle(
                            fontSize: 13,
                            color: notifire.getwhiteblackcolor,
                            fontFamily: "Gilroy Medium"),
                      ),
                )),
                Container(
                  width:MediaQuery.of(context).size.width * 0.55,
                  alignment: Alignment.centerLeft,
                  child:FittedBox(
                    fit: BoxFit.scaleDown,
                      child: Text(
                        review.prTitle ?? "리뷰제목",
                        style: TextStyle(
                            fontSize: 18,
                            color: notifire.getwhiteblackcolor,
                            fontFamily: "Gilroy Medium"),
                      ),
                )),
                Container(
                  width:MediaQuery.of(context).size.width * 0.2,
                  alignment: Alignment.centerRight,
                  child:FittedBox(
                    fit: BoxFit.scaleDown,
                      child: Text(
                        review.userName ?? '유저명',
                        style: TextStyle(
                            fontSize: 15,
                            color: notifire.getwhiteblackcolor,
                            fontFamily: "Gilroy Medium"),
                      ),
                )),
              ],
            ),),
          ),
          InkWell(
            onTap: (){
              // Navigator.of(context).push(MaterialPageRoute(
              //       builder: (context) => CampProduct(campNo: review.campNo )));
            },
          child:Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      review.productThumnail ?? "assets/images/logo2.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.productName ?? '상품명',
                      style: TextStyle(
                          fontSize: 15,
                          color: notifire.getwhiteblackcolor,
                          fontFamily: "Gilroy Bold"),
                    ),
                    SizedBox(
                      width:
                          MediaQuery.of(context).size.width *
                              0.2,
                      child: Text(
                        review.productCategory ?? '상품분류',
                        style: TextStyle(
                            fontSize: 13,
                            color: notifire.getwhiteblackcolor,
                            fontFamily: "Gilroy Medium",
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    Text(
                      "대여 수량 : ${review.orderCnt}",
                      style: TextStyle(
                          fontSize: 16,
                          color: notifire.getwhiteblackcolor,
                          fontFamily: "Gilroy Bold"),
                    ),
                  ],
                ),
              ],
            ),
          ),),
          Divider(),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              // color: notifire.getdarkmodecolor,
            ),
            child: Text(
              review.prCon ?? "내용",
              style: TextStyle(
                          fontSize: 16,
                          color: notifire
                              .getwhiteblackcolor,
                          fontFamily: "Gilroy Bold"),)
          ),
          const SizedBox(height: 15,),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: notifire.getdarkmodecolor,
            ),
            child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      review.prImg ?? "assets/images/logo2.png",
                      fit: BoxFit.fill,
                    ),
                  ),
          ),
          SizedBox(height: 50,),
          Divider(),
          SizedBox(height: 50,),
          FooterScreen()
      ],)
    ]));
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