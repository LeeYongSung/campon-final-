import 'package:campon_app/example/Login&ExtraDesign/chackout.dart';
import 'package:campon_app/example/Login&ExtraDesign/hoteldetail.dart';
import 'package:campon_app/example/Utils/Colors.dart';
import 'package:campon_app/example/Login&ExtraDesign/review.dart';
import 'package:campon_app/example/Utils/dark_lightmode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:campon_app/example/Utils/customwidget%20.dart';
import 'package:carousel_slider/carousel_slider.dart';

int selectedIndex = 0;



class CampProduct extends StatefulWidget {
  const CampProduct({super.key});

  @override
  State<CampProduct> createState() => _CampProductState();
}

class _CampProductState extends State<CampProduct> {
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;
  @override
  void initState() {
    getdarkmodepreviousstate();
    super.initState();
  }

  late ColorNotifire notifire;

  final List<String> slideList = [
    'assets/images/SagamoreResort.jpg',
    'assets/images/SagamoreResort.jpg',
    'assets/images/SagamoreResort.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.getbgcolor,
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          elevation: 0,
          backgroundColor: notifire.getbgcolor,
          leading: 
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[Padding(
              padding: const EdgeInsets.only(top: 8, left: 12),
              child: CircleAvatar(
                backgroundColor: notifire.getlightblackcolor.withAlpha(0),
                child: BackButton(   //뒤로가기버튼
                  color: Colors.orange,
                ),
              ),
            ),
            Image.asset("assets/images/header_logo.png",
                                  height: 40,)
                                  
            ]),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: notifire.getlightblackcolor.withAlpha(0),
                    child: Icon(Icons.share, color: Colors.orange, size: 25,)
                  ),
                  const SizedBox(width: 20),
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: notifire.getlightblackcolor.withAlpha(0),
                    child: Icon(Icons.star_border, color:Colors.orange, size: 30,)
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),
          ],
          pinned: _pinned,
          snap: _snap,
          floating: _floating,
          expandedHeight: 250,
          flexibleSpace: FlexibleSpaceBar(
            background: CarouselSlider.builder(
               itemCount: slideList.length,
              itemBuilder: (context, index, realIndex) {
                return Stack(
                  children: [
                    Image.asset(
                      "${slideList[index]}",
                      fit: BoxFit.cover,
                      // 이미지 가로 사이즈를 앱 가로 사이즈로 지정
                      width: MediaQuery.of(context).size.width,
                    )
                  ],
                );
              },
              options: CarouselOptions(viewportFraction: 1.0)
          ),
        )),
        SliverToBoxAdapter(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Stack(children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "캠핑장 환경 ( 산/바다 )",
                      style: TextStyle(
                          fontSize: 12,
                          color: notifire.getwhiteblackcolor,
                          fontFamily: "Gilroy Bold"),
                    ),
                    Text(
                      "캠핑장명",
                      style: TextStyle(
                          fontSize: 25,
                          color: notifire.getwhiteblackcolor,
                          fontFamily: "Gilroy Bold"),
                    ),
                    Divider(),
                    const SizedBox(height: 10),
                    Text(
                      "기본정보",
                      style: TextStyle(
                          fontSize: 18,
                          color: notifire.getwhiteblackcolor,
                          fontFamily: "Gilroy Bold"),
                    ),
                    Text(
                      "캠핑장 주소",
                      style: TextStyle(
                          fontSize: 15,
                          color: notifire.getwhiteblackcolor,
                          fontFamily: "Gilroy Bold"),
                    ),
                    Text(
                      "캠핑장 연락처",
                      style: TextStyle(
                          fontSize: 15,
                          color: notifire.getwhiteblackcolor,
                          fontFamily: "Gilroy Bold"),
                    ),
                    Text(
                      "캠핑장 오픈날짜",
                      style: TextStyle(
                          fontSize: 15,
                          color: notifire.getwhiteblackcolor,
                          fontFamily: "Gilroy Bold"),
                    ),
                    Text(
                      "캠핑장 클로즈날짜",
                      style: TextStyle(
                          fontSize: 15,
                          color: notifire.getwhiteblackcolor,
                          fontFamily: "Gilroy Bold"),
                    ),
                    Text(
                      "매너타임",
                      style: TextStyle(
                          fontSize: 15,
                          color: notifire.getwhiteblackcolor,
                          fontFamily: "Gilroy Bold"),
                    ),
                    Container(
                      width: double.infinity,
                    child:TextButton(
                      onPressed: (){},
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 249, 161, 79)), // 배경색 설정
                        ), 
                      child: 
                        Text(
                        "그동안 ( ) 명이 방문하셨습니다.",
                        style: TextStyle(
                          fontSize: 15,
                          color: notifire.getwhiteblackcolor,
                          fontFamily: "Gilroy Bold"),
                    ),)),
                    Divider(),
                    const SizedBox(height: 10),
                    Text(
                      "캠핑장 소개",
                      style: TextStyle(
                          fontSize: 18,
                          color: notifire.getwhiteblackcolor,
                          fontFamily: "Gilroy Bold"),
                    ),
                    ReadMoreText(
                      "캠핑장 소개 지금 3줄 이상이면 접혀진다~캠핑장 소개 지금 3줄 이상이면 접혀진다~캠핑장 소개 지금 3줄 이상이면 접혀진다~캠핑장 소개 지금 3줄 이상이면 접혀진다~캠핑장 소개 지금 3줄 이상이면 접혀진다~캠핑장 소개 지금 3줄 이상이면 접혀진다~캠핑장 소개 지금 3줄 이상이면 접혀진다~캠핑장 소개 지금 3줄 이상이면 접혀진다~",
                      trimLines: 3,
                      trimMode: TrimMode.Line,
                      style: TextStyle(
                          color: notifire.getgreycolor,
                          fontFamily: "Gilroy Medium"),
                      trimCollapsedText: '더보기',
                      trimExpandedText: '접기',
                      lessStyle: TextStyle(color: notifire.getdarkbluecolor),
                      moreStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: notifire.getdarkbluecolor),
                    ),
                    Divider(),
                    const SizedBox(height: 10),
                    Text(
                      "캠핑장 시설",
                      style: TextStyle(
                          fontSize: 18,
                          color: notifire.getwhiteblackcolor,
                          fontFamily: "Gilroy Bold"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Image.asset("assets/images/wifi.png",
                                height: 30, color: notifire.getwhiteblackcolor),
                            Text(
                              "Wifi",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: notifire.getgreycolor,
                                  fontFamily: "Gilroy Medium"),
                            ),
                          ],
                        ),
                        const SizedBox(width: 20,),
                        Column(
                          children: [
                            Image.asset(
                              "assets/images/shower.png",
                              height: 30,
                              color: notifire.getwhiteblackcolor,
                            ),
                            Text(
                              "shower",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: notifire.getgreycolor,
                                  fontFamily: "Gilroy Medium"),
                            )
                          ],
                        ),
                        const SizedBox(width: 20,),
                        ]),
                        Divider(),
                        const SizedBox(height: 10),
                        Text(
                          "캠핑장 위치",
                          style: TextStyle(
                              fontSize: 18,
                              color: notifire.getwhiteblackcolor,
                              fontFamily: "Gilroy Bold"),
                        ),
                        Image.asset(
                          "assets/images/SagamoreResort.jpg", //카카오Map 연결 
                          height: 300,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                        Divider(),
                        const SizedBox(height: 10),
                        Text(
                          "캠핑장 배치도",
                          style: TextStyle(
                              fontSize: 18,
                              color: notifire.getwhiteblackcolor,
                              fontFamily: "Gilroy Bold"),
                        ),
                        Image.asset(
                          "assets/images/SagamoreResort.jpg", // 배치도
                          height: 300,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                        Divider(),
                        const SizedBox(height: 10),
                        Text(
                          "캠핑 상품",
                          style: TextStyle(
                              fontSize: 18,
                              color: notifire.getwhiteblackcolor,
                              fontFamily: "Gilroy Bold"),
                        ),
                        ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: hotelList2.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const hoteldetailpage()));
                            },
                            child: Container(
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
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(
                                        hotelList2[index]["img"].toString(),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "캠핑상품명",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: notifire.getwhiteblackcolor,
                                            fontFamily: "Gilroy Bold"),
                                      ),
                                      Row(
                                      children: [
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width *
                                                  0.2,
                                          child: Text(
                                            "( 글램핑 )"
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: notifire.getgreycolor,
                                                fontFamily: "Gilroy Medium",
                                                overflow: TextOverflow.ellipsis),
                                          ),
                                        ),
                                        SizedBox(
                                          child: Text(
                                            "수용가능 인원 : "
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: notifire.getgreycolor,
                                                fontFamily: "Gilroy Medium",
                                                overflow: TextOverflow.ellipsis),
                                          ),
                                        ),
                                      ]
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.65,
                                        child: Text(
                                          "캠핑상품 소개"
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: notifire.getgreycolor,
                                              fontFamily: "Gilroy Medium",
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "가격",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: notifire
                                                        .getdarkbluecolor,
                                                    fontFamily: "Gilroy Bold"),
                                              ),
                                              Text(
                                                "원 / 1박",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color:
                                                        notifire.getgreycolor,
                                                    fontFamily:
                                                        "Gilroy Medium"),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                        Divider(),
                        const SizedBox(height: 10),
                        Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "캠핑장 리뷰",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Gilroy Bold",
                              color: notifire.getwhiteblackcolor),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const review(),
                            ));
                          },
                          child: Text(
                            "다양한 리뷰 보러가기",
                            style: TextStyle(
                                fontSize: 15,
                                color: notifire.getdarkbluecolor,
                                fontFamily: "Gilroy Medium"),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {
                          return
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const review()));
                            },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey, 
                                width: 1.0, 
                              ),
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white
                            ),
                            child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                    Container(
                                      child: Column(
                                        children:[
                                          Text(
                                            "유저명",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: notifire.getwhiteblackcolor,
                                              fontFamily: "Gilroy Bold"),
                                          ),
                                          Text(
                                            "캠핑장명",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: notifire.getwhiteblackcolor,
                                              fontFamily: "Gilroy Bold"),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context).size.height * 0.007,
                                          ),
                                          Text(
                                            "리뷰내용",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: notifire.getwhiteblackcolor,
                                              fontFamily: "Gilroy Bold"),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 12),
                                      height: 75,
                                      width: 75,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.asset(
                                          "assets/images/SagamoreResort.jpg",
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ],
                          
                                
                              
                            ),
                          ));

                        },
                      ),
                    ),
                        Divider(),
                        const SizedBox(height: 10),
                        Text(
                          "캠핑장 운영정책",
                          style: TextStyle(
                              fontSize: 18,
                              color: notifire.getwhiteblackcolor,
                              fontFamily: "Gilroy Bold"),
                        ),
                        ReadMoreText(
                          "캠핑장 소개 지금 3줄 이상이면 접혀진다~캠핑장 소개 지금 3줄 이상이면 접혀진다~캠핑장 소개 지금 3줄 이상이면 접혀진다~캠핑장 소개 지금 3줄 이상이면 접혀진다~캠핑장 소개 지금 3줄 이상이면 접혀진다~캠핑장 소개 지금 3줄 이상이면 접혀진다~캠핑장 소개 지금 3줄 이상이면 접혀진다~캠핑장 소개 지금 3줄 이상이면 접혀진다~",
                          trimLines: 3,
                          trimMode: TrimMode.Line,
                          style: TextStyle(
                              color: notifire.getgreycolor,
                              fontFamily: "Gilroy Medium"),
                          trimCollapsedText: '더보기',
                          trimExpandedText: '접기',
                          lessStyle: TextStyle(color: notifire.getdarkbluecolor),
                          moreStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: notifire.getdarkbluecolor),
                        ),
                        Divider(),
                        const SizedBox(height: 10),
                        Text(
                          "취소 환불 규정",
                          style: TextStyle(
                              fontSize: 18,
                              color: notifire.getwhiteblackcolor,
                              fontFamily: "Gilroy Bold"),
                        ),
                        ReadMoreText(
                          "캠핑장 소개 지금 3줄 이상이면 접혀진다~캠핑장 소개 지금 3줄 이상이면 접혀진다~캠핑장 소개 지금 3줄 이상이면 접혀진다~캠핑장 소개 지금 3줄 이상이면 접혀진다~캠핑장 소개 지금 3줄 이상이면 접혀진다~캠핑장 소개 지금 3줄 이상이면 접혀진다~캠핑장 소개 지금 3줄 이상이면 접혀진다~캠핑장 소개 지금 3줄 이상이면 접혀진다~",
                          trimLines: 3,
                          trimMode: TrimMode.Line,
                          style: TextStyle(
                              color: notifire.getgreycolor,
                              fontFamily: "Gilroy Medium"),
                          trimCollapsedText: '더보기',
                          trimExpandedText: '접기',
                          lessStyle: TextStyle(color: notifire.getdarkbluecolor),
                          moreStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: notifire.getdarkbluecolor),
                        ),
                        Divider(),
                        const SizedBox(height: 10),
                        Text(
                          "사업자 정보",
                          style: TextStyle(
                              fontSize: 18,
                              color: notifire.getwhiteblackcolor,
                              fontFamily: "Gilroy Bold"),
                        ),
                        Text(
                          "업체명 : ",
                          style: TextStyle(
                              fontSize: 15,
                              color: notifire.getwhiteblackcolor,
                              fontFamily: "Gilroy Bold"),
                        ),
                        Text(
                          "사업자번호 : ",
                          style: TextStyle(
                              fontSize: 15,
                              color: notifire.getwhiteblackcolor,
                              fontFamily: "Gilroy Bold"),
                        ),
                        Text(
                          "사업주 : ",
                          style: TextStyle(
                              fontSize: 15,
                              color: notifire.getwhiteblackcolor,
                              fontFamily: "Gilroy Bold"),
                        ),
                        

                  ],
                ),
              ]),
            )
          ],
        )),
      ])
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