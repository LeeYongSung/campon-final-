import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:campon_app/example/Utils/dark_lightmode.dart';
import 'package:provider/provider.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
    late ColorNotifire notifire;
  var connected = false;

   //장바구니에 담긴 상품
  List cartList = [
    {
      "productNo": "1",
      "productThumnail": "img/product/11.png",
      "productCategory": "텐트",
      "productName": "상품이름",
      "productIntro": "상품설명",
      "productPrice": "3000",
      "cartNo": "1000000",
    },
    {
      "productNo": "2",
      "productThumnail": "img/product/12.png",
      "productCategory": "텐트",
      "productName": "상품이름2",
      "productIntro": "상품설명2",
      "productPrice": "30002",
      "cartNo": "1000000",
    },
  ];
  List reserVationList = [
    {
      "campNo": 2,
      "regionNo": 1,
      "campName": "안조은캠핑장",
      "campAddress": "안조은시 안조은동 안조은캠핑장",
      "campCaution": "없음",
      "campIntroduction": "안조은캠핑장에 오신것을 환영합니다",
      "cpdtNo": 1,
      "cpdtName": "안조은펜션",
      "cpdtIntroduction": "안조은 팬션에 안조은 팬션",
      "cpdtNop": 1,
      "cpiNo": 6,
      "cpiUrl": "/img/camp1.jpg",
      "reservationNo": 1,
      "reservationNop": 10,
      "reservationStart": "2024-02-20T15:00:00.000+00:00",
      "reservationEnd": "2024-02-28T15:00:00.000+00:00",
      "reservationDate": 10,
      "userNo": 2,
      "userName": "추윤주",
      "userTel": "01000000000",
    },
    {
      "campNo": 2,
      "regionNo": 2,
      "campName": "안조은캠핑장",
      "campAddress": "안조은시 안조은동 안조은캠핑장",
      "campCaution": "없음",
      "campIntroduction": "안조은캠핑장에 오신것을 환영합니다",
      "cpdtNo": 1,
      "cpdtName": "안조은펜션",
      "cpdtIntroduction": "안조은 팬션에 안조은 팬션",
      "cpdtNop": 1,
      "cpiNo": 6,
      "cpiUrl": "/img/camp1.jpg",
      "reservationNo": 2,
      "reservationNop": 10,
      "reservationStart": "2024-02-20T15:00:00.000+00:00",
      "reservationEnd": "2024-02-28T15:00:00.000+00:00",
      "reservationDate": 10,
      "userNo": 2,
      "userName": "추윤주",
      "userTel": "01000000000",
    },

    
  ];

  //장바구니 목록이랑 캠핑장 예약 정보 가져오는 함수
  Future<void> getPayList () async {
      print("getPayList () 함수 실행");
    try {
        var response = await http.get(Uri.parse('http://10.0.2.2:8081/api/product/payment'));
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        setState(() {
        cartList = data["cartList"];
      print("cartList ? ${cartList}");
        reserVationList = data["reserVationList"];
      print("reserVationList ? ${reserVationList}");
        });
    } catch (e) {
      print("getPayList () 중 에러 발생 ${e}");
    }
  }


@override
  void initState() {
    super.initState();
    getPayList();
  }


  @override
  Widget build(BuildContext context) {
     notifire = Provider.of<ColorNotifire>(context, listen: true);
    return SafeArea(child: 
      Scaffold(
        backgroundColor: notifire.getbgcolor,
        body : SingleChildScrollView(
          child: Column(children: [
             SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Text(
                "결제하기",
                style: TextStyle(
                    fontSize: 24,
                    color: notifire.getwhiteblackcolor,
                    fontFamily: "Gilroy Bold"),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Divider(
                color: notifire.getgreycolor,
              ),

                Text(
                "주문상품 목록",
                style: TextStyle(
                    fontSize: 20,
                    color: notifire.getwhiteblackcolor,
                    fontFamily: "Gilroy Bold"),
              ),

                Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Container(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: cartList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: notifire.getdarkmodecolor),
                          child: Column(
                            children: [
                              Container(
                                height: 140,
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12)),
                                  child:

                                      //썸네일 이미지
                                      connected
                                          ? Image.network(
                                              "http://10.0.2.2:8081/api/img?file=${cartList[index]["productThumnail"].toString()}",
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset("img/product/11.png",
                                              fit: BoxFit.cover),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          cartList[index]["productCategory"]
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              color:
                                                  notifire.getwhiteblackcolor,
                                              fontFamily: "Gilroy Bold"),
                                        ),
                                        Text(
                                          cartList[index]["productName"]
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: notifire.getdarkbluecolor,
                                              fontFamily: "Gilroy Bold"),
                                        ),
                                      ],
                                    ),
                                    //상품 인트로
                                    Text(
                                      cartList[index]["productIntro"]
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: notifire.getgreycolor,
                                          fontFamily: "Gilroy Medium",
                                          overflow: TextOverflow.ellipsis),
                                    ),

                                    //가격
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${cartList[index]["productPrice"].toString()}원",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color:
                                                  notifire.getwhiteblackcolor,
                                              fontFamily: "Gilroy Bold"),
                                        ),
                                        //버튼 2개
                                        // Row(
                                        //   children: [
                                        //     //상세정보 버튼
                                        //     Container(
                                        //       width: 80,
                                        //       height: 40,
                                        //       child: AppButton(
                                        //           buttontext: "상세정보",
                                        //           onclick: () {
                                        //             Navigator.of(context).push(
                                        //                 MaterialPageRoute(
                                        //                     builder: (context) =>
                                        //                         ProductDetail(
                                        //                             productNo:
                                        //                                 '${cartList[index]["productNo"]}')));
                                        //           }),
                                        //     ),

                                        //     SizedBox(
                                        //       width: 10,
                                        //     ),

                                        //     //삭제 버튼
                                        //     Container(
                                        //       width: 80,
                                        //       height: 40,
                                        //       child: AppButton(
                                        //           buttontext: "삭제",
                                        //           onclick: () {
                                        //             //장바구니에서 삭제 함수 실행
                                        //             removeCart(
                                        //                 '${cartList[index]["cartNo"]}');
                                        //           }),
                                        //     ),
                                        //   ],
                                        // ),
                                      ],
                                    ),

                                   Text(
                            "예약한 캠핑장 목록",
                            style: TextStyle(
                                fontFamily: "Gilroy Bold",
                                color: notifire.getwhiteblackcolor),
                          ),

                           SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),

                          ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.all(10),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: reserVationList.length,
                            itemBuilder: (context, index) {
                              // return RadioListTile<String>(
                              //   value : reserVationList[index]["reservationNo"], 
                              // );
                            },
                          ),

                          


                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
           


          ]),
        ),
      ),
    );
  }
}