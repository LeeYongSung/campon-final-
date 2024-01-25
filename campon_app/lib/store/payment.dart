import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:campon_app/example/Utils/dark_lightmode.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  late ColorNotifire notifire;
  var connected = false;

  //결제수단
  String? _payVal = "";

  //캠핑장 선택
  List<bool> isSelected = [false, false];
  int selectedCamp = -1;
  Future<void> isSelectedLength(length) async {
    isSelected = [];
    for (var i = 0; i < length; i++) {
      isSelected.add(false);
    }
    print('isSelected ????' + isSelected.toString());
  }

  //수량
  List<TextEditingController> _countController =
      List<TextEditingController>.generate(
          2, (index) => TextEditingController(text: '1'));
  List<int> _count = [1, 1];
  final int _maxCount = 30;
  final int _minCount = 1;
  void controllerMake(length) {
    _countController = List<TextEditingController>.generate(
        length, (index) => TextEditingController(text: '1'));
    for (var i = 0; i < length; i++) {
      print('_countController[$i] 출력 : ${_countController[i]}');
    }
  }

  void countMake(length) {
    for (var i = 0; i < length; i++) {
      _count.add(1);
      print('_count 출력 : ${_count.toString()}');
    }
  }

  //예약한 캠핑장 선택
  String? _resGroup;

  //장바구니에 담긴 상품
  List cartList = [
    {
      "productNo": "1",
      "productThumnail": "img/product/11.png",
      "productCategory": "텐트",
      "productName": "상품이름",
      "productIntro": "상품설명",
      "productPrice": 3000,
      "cartNo": "1000000",
    },
    {
      "productNo": "2",
      "productThumnail": "img/product/12.png",
      "productCategory": "텐트",
      "productName": "상품이름2",
      "productIntro": "상품설명2",
      "productPrice": 30002,
      "cartNo": "1000000",
    },
  ];
  List reservationList = [
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
      "formattedStart": "2024-01-01",
      "formattedEnd": "2024-01-02"
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
      "formattedStart": "2024-01-01",
      "formattedEnd": "2024-01-02"
    },
  ];

  //장바구니 목록이랑 캠핑장 예약 정보 가져오는 함수
  Future<void> getPayList() async {
    print("getPayList () 함수 실행");
    try {
      var response =
          await http.get(Uri.parse('http://10.0.2.2:8081/api/product/payment'));
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      print("getPayList () 함수 실행2");
      setState(() {
        cartList = data["cartList"];
        print("cartList ? ${cartList}");
        //{productNo: 1, productName: 1, productThumnail: /img/product/3d5486f7-470c-496f-a5ef-707ff8d29c1a_20231115_103134.png, productCon: C:/upload/productCon1.jpg, productIntro: 상품설명1, productCategory: 텐트, productPrice: 10000000, regDate: 2023-11-01T07:28:23.000+00:00, updDate: 2023-11-01T07:28:23.000+00:00, userNo: 2, productimgNo: null, productimgUrl: null, productImgsUrlList: null, productThmFile: null, productConFile: null, productImgs: null, cartNo: 43, cartCnt: 1, productsaveNo: 0, wishlistNo: 0, orderCnt: 0, sum: null, orderNo: 0},
        print("cartList.length ? ${cartList.length}");
        if (data["reservationList"] == null) {
        } else {
          reservationList = data["reservationList"]; //데이터없을 때 고려해줘야 함
        }
        for (int i = 0; i < reservationList.length; i++) {
          String datetimeStr =
              reservationList[i]["reservationStart"].toString();
          DateTime dateTime = DateTime.parse(datetimeStr);
          String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
          reservationList[i]["formattedStart"] = formattedDate;
          String datetimeStr2 = reservationList[i]["reservationEnd"].toString();
          DateTime dateTime2 = DateTime.parse(datetimeStr);
          String formattedDate2 = DateFormat('yyyy-MM-dd').format(dateTime2);
          reservationList[i]["formattedEnd"] = formattedDate2;
        }
        controllerMake(cartList.length);
        countMake(cartList.length);
        print("reservationList.length ? ${reservationList.length}");
        print("reservationList ? ${reservationList}");
        isSelectedLength(reservationList.length);
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: notifire.getbgcolor,
        body: SingleChildScrollView(
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
                                            color: notifire.getwhiteblackcolor,
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
                                    cartList[index]["productIntro"].toString(),
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
                                        "가격 : ${(cartList[index]["productPrice"] * int.parse(_countController[index].text)).toString()} 원",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: notifire.getwhiteblackcolor,
                                            fontFamily: "Gilroy Bold"),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      // + , - 버튼
                                      Container(
                                        width: 130,
                                        child: TextField(
                                          textAlign: TextAlign.center,
                                          controller: _countController[
                                              index], //여기 초기값 들어감
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                          decoration: InputDecoration(
                                            prefixIcon: Container(
                                              width: 10,
                                              child: OutlinedButton(
                                                onPressed: () {
                                                  // -버튼 클릭 시 실행됨
                                                  if (_minCount >=
                                                      _count[index]) {
                                                    return;
                                                  }
                                                  setState(() {
                                                    _count[index] =
                                                        _count[index] - 1;
                                                  });
                                                  _countController[index].text =
                                                      _count[index].toString();
                                                },
                                                child: Text('-'),
                                              ),
                                            ),
                                            suffixIcon: Container(
                                                width: 10,
                                                child: OutlinedButton(
                                                  onPressed: () {
                                                    // + 버튼 클릭 시 실행됨
                                                    if (_maxCount <
                                                        _count[index]) {
                                                      return;
                                                    }
                                                    setState(() {
                                                      _count[index] =
                                                          _count[index] + 1;
                                                    });
                                                    _countController[index]
                                                            .text =
                                                        _count[index]
                                                            .toString();
                                                  },
                                                  child: Text('+'),
                                                )),
                                          ),
                                          onChanged: (value) {},
                                        ),
                                      ),
                                    ],
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Text(
              "예약한 캠핑장 목록",
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Gilroy Bold",
                  color: notifire.getwhiteblackcolor),
            ),
            Text(
              "배송받을 캠핑장을 선택해주세요",
              style: TextStyle(
                  fontFamily: "Gilroy Bold",
                  color: notifire.getwhiteblackcolor),
            ),
            ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(10),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: reservationList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      isSelected[index] = true;
                      selectedCamp = reservationList[index]["reservationNo"];
                      for (var i = 0; i < reservationList.length; i++) {
                        if (i != index) {
                          isSelected[i] = false;
                        }
                      }
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: isSelected[index]
                          ? Colors.yellow
                          : notifire.getdarkmodecolor,
                    ),
                    child: Row(
                      children: [
                        //캠핑장 이미지
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          height: 80,
                          width: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: connected
                                ? Image.network(
                                    "http://10.0.2.2:8081/api/img?file=${reservationList[index]["cpiUrl"].toString()}",
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset('img/camp/camp1-1-1.jpg',
                                    fit: BoxFit.cover),
                          ),
                        ),
                        //캠핑장 정보
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              reservationList[index]["campName"].toString(),
                              style: TextStyle(
                                  fontSize: 15,
                                  color: notifire.getwhiteblackcolor,
                                  fontFamily: "Gilroy Bold"),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.006),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.65,
                              child: Text(
                                reservationList[index]["cpdtName"].toString(),
                                style: TextStyle(
                                    fontSize: 19,
                                    color: notifire.getwhiteblackcolor,
                                    fontFamily: "Gilroy Medium",
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01),
                            //예약날짜
                            Row(
                              children: [
                                Text(
                                  "예약 날짜",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: notifire.getgreycolor,
                                      fontFamily: "Gilroy Medium"),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "${reservationList[index]["formattedStart"]} ~ ${reservationList[index]["formattedEnd"]}",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: notifire.getdarkbluecolor,
                                      fontFamily: "Gilroy Bold"),
                                ),
                              ],
                            ),
                            //예약번호
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/star.png",
                                  height: 20,
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  "예약번호",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: notifire.getgreycolor,
                                      fontFamily: "Gilroy Medium"),
                                ),
                                SizedBox(width: 7),
                                Text(
                                  reservationList[index]["reservationNo"]
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: notifire.getdarkbluecolor,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),

            //결제수단 선택
            Container(
              width: double.infinity,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.amber,
              ),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "결제수단 선택",
                    style: TextStyle(fontSize: 12),
                  ),
                  Expanded(
                    child: ListTile(
                        title: const Text(
                          '카드 결제',
                          style: TextStyle(fontSize: 12),
                        ),
                        leading: SizedBox(
                          width: 24,
                          height: 24,
                          child: Radio(
                            value: "카드",
                            groupValue: _payVal,
                            onChanged: (value) {
                              setState(() {
                                _payVal = value;
                              });
                            },
                          ),
                        )),
                  ),
                  Expanded(
                    child: ListTile(
                        title: const Text('무통장 입금',
                            style: TextStyle(fontSize: 12)),
                        leading: SizedBox(
                          width: 24,
                          height: 24,
                          child: Radio(
                            hoverColor: Colors.red,
                            activeColor: Colors.black,
                            value: "무통장",
                            groupValue: _payVal,
                            onChanged: (value) {
                              setState(() {
                                _payVal = value;
                              });
                            },
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
