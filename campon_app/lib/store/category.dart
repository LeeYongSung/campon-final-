import 'dart:convert';

import 'package:campon_app/camp/camp_schedule_screen.dart';
import 'package:flutter/material.dart';
import 'package:campon_app/example/Utils/dark_lightmode.dart';
import 'package:provider/provider.dart';
import 'package:campon_app/example/Login&ExtraDesign/homepage.dart';
import 'package:campon_app/example/Utils/customwidget%20.dart';
import 'package:http/http.dart' as http;

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  late ColorNotifire notifire;

  List category = [
    {
      "productThumnail": "img/product/product1.png",
      "productCategory": "텐트",
      "productName": "상품이름",
      "productIntro": "상품설명",
      "productPrice": "3000",
    },
    {
      "productThumnail": "img/product/product1.png",
      "productCategory": "텐트2",
      "productName": "상품이름2",
      "productIntro": "상품설명2",
      "productPrice": "30002",
    },
  ];

//TODO 하드코딩
var categoryName = '텐트';
  //카테고리 상품 가져오는 함수

  Future<void> getCatProList () async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8081/api/product/productList?category=${categoryName}'));
    if (response.statusCode == 200){
      final category2 = jsonDecode(utf8.decode(response.bodyBytes));
      print('카테고리2는? ${category2}');
      //카테고리2는? [{productNo: 1, productName: 1, productThumnail: /img/product/3d5486f7-470c-496f-a5ef-707ff8d29c1a_20231115_103134.png, productCon: C:/upload/f463b7a9-fe3c-4221-a72e-4adab7eea70f_camp1-5.jpg, productIntro: 상품설명1, productCategory: 텐트, productPrice: 10000000, regDate: 2023-11-01T07:28:23.000+00:00, updDate: 2023-11-01T07:28:23.000+00:00, userNo: null, productimgNo: null, productimgUrl: null, productImgsUrlList: null, productThmFile: null, productConFile: null, productImgs: null, cartNo: null, cartCnt: null, productsaveNo: 0, wishlistNo: 0, orderCnt: 0, sum: null, orderNo: 0}]
      setState(() {
        category = category2;
      });

    }
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
            child: Icon(Icons.schedule_outlined),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CampScheduleScreen()));
          },
        ),
        actions: [
          GestureDetector(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: Icon(Icons.search_outlined),
            ),
            onTap: () {
              print('test2.....');
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
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: 85,
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Image.asset(
                            "img/product/product1.png",
                            height: 60,
                          ),
                          Text(
                            "텐트",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Gilroy Medium",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 85,
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Image.asset(
                            "img/product/product2.png",
                            height: 60,
                          ),
                          Text(
                            "테이블",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Gilroy Medium",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 85,
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Image.asset(
                            "img/product/product3.png",
                            height: 60,
                          ),
                          Text(
                            "체어",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Gilroy Medium",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 85,
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Image.asset(
                            "img/product/product4.png",
                            height: 60,
                          ),
                          Text(
                            "매트",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Gilroy Medium",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 85,
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Image.asset(
                            "img/product/product5.png",
                            height: 60,
                          ),
                          Text(
                            "조명",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Gilroy Medium",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 85,
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Image.asset(
                            "img/product/product6.png",
                            height: 60,
                          ),
                          Text(
                            "화로대",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Gilroy Medium",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 85,
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Image.asset(
                            "img/product/product7.png",
                            height: 60,
                          ),
                          Text(
                            "타프",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Gilroy Medium",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 85,
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Image.asset(
                            "img/product/product8.png",
                            height: 60,
                          ),
                          Text(
                            "수납",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Gilroy Medium",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 85,
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Image.asset(
                            "img/product/product9.png",
                            height: 60,
                          ),
                          Text(
                            "캠핑가전",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Gilroy Medium",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 85,
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Image.asset(
                            "img/product/product10.png",
                            height: 60,
                          ),
                          Text(
                            "주방용품",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Gilroy Medium",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
              child: Expanded(
                child: ListView.builder(
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
                                child: Image.network(
                                  "http://10.0.2.2:8081/api/img?file=${category[index]["productThumnail"].toString()}",
                                  fit: BoxFit.cover,
                                ),
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                          //TODO 수정예정
                                                              const homepage()));
                                                }),
                                          ),

                                          SizedBox(width: 10,),

                                          //장바구니 버튼
                                          Container(
                                            width: 80,
                                            height: 40,
                                            child: AppButton(
                                                buttontext: "장바구니",
                                                onclick: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const homepage()));
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
