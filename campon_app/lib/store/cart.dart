import 'dart:convert';

import 'package:campon_app/store/payment.dart';
import 'package:campon_app/store/productdetail.dart';
import 'package:campon_app/store/storemain.dart';
import 'package:flutter/material.dart';
import 'package:campon_app/example/Utils/customwidget%20.dart';
import 'package:campon_app/example/Utils/dark_lightmode.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:campon_app/example/Utils/Colors.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  late ColorNotifire notifire;
  bool connected = false;

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

  //장바구니 상품 가져오는 함수
  Future<void> getCartList() async {
    print('getCartList() 함수 실행');
    try {
      final response =
          await http.get(Uri.parse('http://10.0.2.2:8081/api/product/cart'));
      if (response.statusCode == 200) {
        final cartList2 = jsonDecode(utf8.decode(response.bodyBytes));
        print('cartList2는? ${cartList2}');
        setState(() {
          cartList = cartList2;
          connected = true;
        });
      } else {
        print('카트리스트 못가져옴');
      }
    } catch (e) {
      print('장바구니 상품 가져오는 중 에러 발생, ${e}');
    }
  }

  //장바구니에서 삭제
  Future<void> removeCart(cartNo) async {
    //상품을 삭제하시겠습니까? 알람
    try {
      var response = await http.delete(Uri.parse(
          "http://10.0.2.2:8081/api/product/cartDelete?cartNo=${cartNo}"));
      if (response.statusCode == 200) {
        print('장바구니에서 상품 하나 삭제');
        //삭제되었습니다 알람
        delDialogS();
        //페이지 다시 로드
        getCartList();
      } else {
        //삭제실패 알람
        print('장바구니에서 상품 하나 삭제 실패');
        delDialogF();
      }
    } catch (e) {
      //서버접근에러 - 삭제실패 알람
      print('서버접근에러 : ${e}');
      delDialogE();
    }
  }

  //삭제 dialog
  void delDialogS() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('장바구니에서 삭제!'),
          content: Text('장바구니에서 해당 상품이 삭제되었습니다.'),
          actions: [
            TextButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void delDialogF() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('장바구니에서 삭제 실패!'),
          content: Text('다시 시도해보세요'),
          actions: [
            TextButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void delDialogE() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('장바구니에서 삭제 실패!'),
          content: Text('서버 에러'),
          actions: [
            TextButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //대여하기 버튼 클릭 시 실행되는 함수
  Future<void> paymentfunc() async {
    print('(cartList.length는? ${cartList.length}');
    if (cartList.length <= 0) {
      print('장바구니에 담긴 상품 없음');
      //장바구니에 추가하라고 알림창 띄우기
      paymentDialog();
    } else {
      //대여 페이지로 이동
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return Payment();
        },
      ));
    }
  }

  void paymentDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("장바구니에 상품을 추가하세요!"),
          content: Text('상품 메인 화면으로 이동할까요?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return StoreMain();
                    },
                  ));
                },
                child: Text("확인")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("취소")),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getCartList();
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            "assets/images/logo2.png",
            width: 110,
            height: 60,
          ),
          centerTitle: true,
          leading: GestureDetector(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: Icon(Icons.arrow_back_ios),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            GestureDetector(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                child: Icon(Icons.shopping_cart),
              ),
              onTap: () {
                print('장바구니 클릭.....');
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Cart()));
              },
            ),
          ],
        ),
        backgroundColor: notifire.getbgcolor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Text(
                "장바구니 List",
                style: TextStyle(
                    fontSize: 24,
                    color: notifire.getwhiteblackcolor,
                    fontFamily: "Gilroy Bold"),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Divider(
                color: notifire.getgreycolor,
              ),
              (cartList.length == 0)
                  ? Text(
                      "장바구니에 담긴 상품 없음!",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )
                  : Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                                                : Image.asset(
                                                    "img/product/11.png",
                                                    fit: BoxFit.cover),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                cartList[index]
                                                        ["productCategory"]
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: notifire
                                                        .getwhiteblackcolor,
                                                    fontFamily: "Gilroy Bold"),
                                              ),
                                              Text(
                                                cartList[index]["productName"]
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: notifire
                                                        .getdarkbluecolor,
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
                                                overflow:
                                                    TextOverflow.ellipsis),
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
                                                    color: notifire
                                                        .getwhiteblackcolor,
                                                    fontFamily: "Gilroy Bold"),
                                              ),
                                              //버튼 2개
                                              Row(
                                                children: [
                                                  //상세정보 버튼
                                                  Container(
                                                    width: 80,
                                                    height: 40,
                                                    child: AppButton(
                                                        buttontext: "상세정보",
                                                        onclick: () {
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      ProductDetail(
                                                                          productNo:
                                                                              '${cartList[index]["productNo"]}')));
                                                        }),
                                                  ),

                                                  SizedBox(
                                                    width: 10,
                                                  ),

                                                  //삭제 버튼
                                                  Container(
                                                    width: 80,
                                                    height: 40,
                                                    child: AppButton(
                                                        buttontext: "삭제",
                                                        onclick: () {
                                                          //장바구니에서 삭제 함수 실행
                                                          removeCart(
                                                              '${cartList[index]["cartNo"]}');
                                                        }),
                                                  ),
                                                ],
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
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 65,
          color: Colors.amber,
          child: Center(
            child: InkWell(
              onTap: () {
                //결제 페이지로 이동
                paymentfunc();
              },
              child: Text(
                "대여하기",
                style: TextStyle(
                    color: WhiteColor, fontSize: 20, fontFamily: "Gilroy Bold"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
