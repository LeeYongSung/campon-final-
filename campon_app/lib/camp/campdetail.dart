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



class CampDetail extends StatefulWidget {
  const CampDetail({super.key});

  @override
  State<CampDetail> createState() => _CampDetailState();
}

class _CampDetailState extends State<CampDetail> {
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
          leading: Padding(
            padding: const EdgeInsets.only(top: 8, left: 12),
            child: CircleAvatar(
              backgroundColor: notifire.getlightblackcolor.withAlpha(0),
              child: BackButton(   //뒤로가기버튼
                color: Colors.orange,
              ),
            ),
          ),
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
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "캠핑장명 ",
                      style: TextStyle(
                          fontSize: 12,
                          color: notifire.getwhiteblackcolor,
                          fontFamily: "Gilroy Bold"),
                    ),
                    Text(
                      "캠핑상품명",
                      style: TextStyle(
                          fontSize: 25,
                          color: notifire.getwhiteblackcolor,
                          fontFamily: "Gilroy Bold"),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                      border: Border.all(
                        color: notifire.getgreycolor, // 외곽선 색상
                        width: 1.5, // 외곽선 두께
                      ),
                    ),
                      child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                            children:[
                              Text(
                                "유형",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: notifire.getwhiteblackcolor,
                                  fontFamily: "Gilroy Bold"),
                              ),
                              const SizedBox(height: 10,),
                              Text(
                                "오토캠핑",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: notifire.getwhiteblackcolor,
                                  fontFamily: "Gilroy Bold"),
                              ),
                            ]
                            ),
                            Column(
                            children:[
                              Text(
                                "크기",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: notifire.getwhiteblackcolor,
                                  fontFamily: "Gilroy Bold"),
                              ),
                              const SizedBox(height: 10,),
                              Text(
                                "9m X 5m",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: notifire.getwhiteblackcolor,
                                  fontFamily: "Gilroy Bold"),
                              ),
                            ]
                            ),
                            Column(
                            children:[
                              Text(
                                "인원",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: notifire.getwhiteblackcolor,
                                  fontFamily: "Gilroy Bold"),
                              ),
                              const SizedBox(height: 10,),
                              Text(
                                "4",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: notifire.getwhiteblackcolor,
                                  fontFamily: "Gilroy Bold"),
                              ),
                            ]
                            ),
                            Column(
                            children:[
                              Text(
                                "가격",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: notifire.getwhiteblackcolor,
                                  fontFamily: "Gilroy Bold"),
                              ),
                              const SizedBox(height: 10,),
                              Text(
                                "45000",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: notifire.getwhiteblackcolor,
                                  fontFamily: "Gilroy Bold"),
                              ),
                            ]
                            ),       
                        ],)
                        ),
                    Divider(),
                  ],
                ),
                    Text(
                      "캠핑장 상품 소개",
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
              ]),
            ),
            Container(
                      width: double.infinity,
                    child:ElevatedButton(
                      onPressed: (){},
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 254, 217, 131)), // 배경색 설정
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0), // 모서리 radius 조절
                            ),
                          ),
                        ), 
                      child: 
                        Text(
                        "예약하기",
                        style: TextStyle(
                          fontSize: 15,
                          color: notifire.getwhiteblackcolor,
                          fontFamily: "Gilroy Bold"),
                    ),)),
          ],
        ),),
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