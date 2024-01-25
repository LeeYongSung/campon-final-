import 'dart:convert';

import 'package:campon_app/camp/camp_schedule_screen.dart';
import 'package:campon_app/store/cart.dart';
import 'package:campon_app/store/productdetail.dart';
import 'package:flutter/material.dart';
import 'package:campon_app/example/Utils/dark_lightmode.dart';
import 'package:provider/provider.dart';
import 'package:campon_app/example/Login&ExtraDesign/homepage.dart';
import 'package:campon_app/example/Utils/customwidget%20.dart';
import 'package:http/http.dart' as http;

class Category extends StatefulWidget {
  final categoryName;
  const Category({super.key, required this.categoryName});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  late String categoryName = widget.categoryName;
  late ColorNotifire notifire;

  bool connected = false;

  //카테고리명, 이미지 등..
  List<dynamic> categories = [
    {"name": "텐트", "image": "img/product/product1.png"},
    {"name": "테이블", "image": "img/product/product2.png"},
    {"name": "체어", "image": "img/product/product3.png"},
    {"name": "매트", "image": "img/product/product4.png"},
    {"name": "조명", "image": "img/product/product5.png"},
    {"name": "화로대", "image": "img/product/product6.png"},
    {"name": "타프", "image": "img/product/product7.png"},
    {"name": "수납", "image": "img/product/product8.png"},
    {"name": "캠핑가전", "image": "img/product/product9.png"},
    {"name": "주방용품", "image": "img/product/product10.png"},
  ];

  List category = [
    {
      "productNo": "1",
      "productThumnail": "img/product/11.png",
      "productCategory": "텐트",
      "productName": "상품이름",
      "productIntro": "상품설명",
      "productPrice": "3000",
    },
    {
      "productNo": "2",
      "productThumnail": "img/product/12.png",
      "productCategory": "텐트2",
      "productName": "상품이름2",
      "productIntro": "상품설명2",
      "productPrice": "30002",
    },
  ];

  //카테고리 상품 가져오는 함수
  Future<void> getCatProList() async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:8081/api/product/productList?category=${categoryName}'));
    if (response.statusCode == 200) {
      final category2 = jsonDecode(utf8.decode(response.bodyBytes));
      print('카테고리2는? ${category2}');
      //카테고리2는? [{productNo: 1, productName: 1, productThumnail: /img/product/3d5486f7-470c-496f-a5ef-707ff8d29c1a_20231115_103134.png, productCon: C:/upload/f463b7a9-fe3c-4221-a72e-4adab7eea70f_camp1-5.jpg, productIntro: 상품설명1, productCategory: 텐트, productPrice: 10000000, regDate: 2023-11-01T07:28:23.000+00:00, updDate: 2023-11-01T07:28:23.000+00:00, userNo: null, productimgNo: null, productimgUrl: null, productImgsUrlList: null, productThmFile: null, productConFile: null, productImgs: null, cartNo: null, cartCnt: null, productsaveNo: 0, wishlistNo: 0, orderCnt: 0, sum: null, orderNo: 0}]
      setState(() {
        category = category2;
        connected = true;
      });
    }
  }

  //이미지 에 대한 서버 접근 가능한지에 대한 여부 함수
  Future<Widget> checkUrlAccessibility(String url, int index) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response == 200) {
        print('서버 접근 가능');
        return Image.network(
          "http://10.0.2.2:8081/api/img?file=${category[index]["productThumnail"].toString()}",
          fit: BoxFit.cover,
        );
      } else {
        return Image.asset("img/product/11.png", fit: BoxFit.cover);
      }
    } catch (e) {
      print('서버 접근 불가');
      return Image.asset("img/product/11.png", fit: BoxFit.cover);
    }
  }

  //장바구니 클릭 시 실행될 함수
  Future<void> addCart(String productNo) async {
    int userNo = 2; //TODO 하드코딩
    try {
      var response = await http.get(Uri.parse(
          "http://10.0.2.2:8081/api/product/addProductsaveAjax?productNo=${productNo}&userNo=${userNo}"));
      var result = response.body;
      if (result == "SUCCESS") {
        print("장바구니에 담기기 성공");
        //위젯
        showCartDialogS();
      } else {
        print("이미 장바구니에 담긴 상품");
        showCartDialogF();
      }
    } catch (e) {
      print("장바구니에 담기 실패.. 서버에러 ${e}");
      showCartDialogE();
    }
  }

  void showCartDialogS() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("장바구니에 담겼습니다!"),
          content: Text("장바구니로 이동하시겠습니까?"),
          actions: [
            TextButton(
                onPressed: () {
                  //TODO 장바구니 페이지로 이동
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => Cart()));
                },
                child: Text("이동")),
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

  void showCartDialogF() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("이미 장바구니에 담긴 상품입니다!"),
          content: Text("장바구니로 이동하시겠습니까?"),
          actions: [
            TextButton(
                onPressed: () {
                  //TODO 장바구니 페이지로 이동
                  Navigator.pop(context);
                },
                child: Text("이동")),
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

  void showCartDialogE() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("장바구니에 담기 실패!"),
          content: Text("다시 시도해보세요"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("확인")),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getCatProList();
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return SafeArea(
        child: Scaffold(
      //TODO 여기부터 수정 (헤더)
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
              //TODO
            },
          ),
        ],
      ),
      backgroundColor: notifire.getbgcolor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('카테고리'),
            SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width * 5,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 85,
                    child: InkWell(
                      onTap: () {
                        // Navigator.push(
                        //             context,
                        //             MaterialPageRoute(
                        //                 builder: (context) => Category(categoryName : "${categories[index]["name"]}")));
                        categoryName = categories[index]["name"];
                        print(categoryName);
                        getCatProList();
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            "${categories[index]["image"]}",
                            height: 60,
                          ),
                          Text(
                            "${categories[index]["name"]}",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Gilroy Medium",
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(
              height: 30,
            ),

            Text(
              "텐트", // TODO : 카테고리명 출력
              style: TextStyle(
                  fontSize: 16,
                  color: notifire.getwhiteblackcolor,
                  fontFamily: "Gilroy Bold"),
            ),

            const SizedBox(height: 15),
            //카페고리 상품 목록 출력
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Container(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: category.length,
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
                                            "http://10.0.2.2:8081/api/img?file=${category[index]["productThumnail"].toString()}",
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
                                        category[index]["productCategory"]
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: notifire.getwhiteblackcolor,
                                            fontFamily: "Gilroy Bold"),
                                      ),
                                      Text(
                                        category[index]["productName"]
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
                                    category[index]["productIntro"].toString(),
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
                                        "${category[index]["productPrice"].toString()}원",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: notifire.getwhiteblackcolor,
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
                                                                      '${category[index]["productNo"]}')));
                                                }),
                                          ),

                                          SizedBox(
                                            width: 10,
                                          ),

                                          //장바구니 버튼
                                          Container(
                                            width: 80,
                                            height: 40,
                                            child: AppButton(
                                                buttontext: "장바구니",
                                                onclick: () {
                                                  addCart(
                                                      "${category[index]["productNo"]}");
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
    ));
  }
}
