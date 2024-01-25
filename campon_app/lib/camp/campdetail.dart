import 'dart:convert';

import 'package:campon_app/camp/camp_home_screen.dart';
import 'package:campon_app/camp/reservate.dart';
import 'package:campon_app/common/footer_screen.dart';
import 'package:campon_app/example/Login&ExtraDesign/chackout.dart';
import 'package:campon_app/example/Login&ExtraDesign/hoteldetail.dart';
import 'package:campon_app/example/Utils/Colors.dart';
import 'package:campon_app/example/Login&ExtraDesign/review.dart';
import 'package:campon_app/example/Utils/dark_lightmode.dart';
import 'package:campon_app/models/camp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:campon_app/example/Utils/customwidget%20.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;

int selectedIndex = 0;

class CampDetail extends StatefulWidget {
  final int? cpdtNo;
  const CampDetail({super.key, required this.cpdtNo});

  @override
  State<CampDetail> createState() => _CampDetailState();
}

class _CampDetailState extends State<CampDetail> {
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;

  Camp camp = Camp();
  Camp date = Camp();
  List<Camp> imgs = [];

  @override
  void initState() {
    getdarkmodepreviousstate();
    super.initState();

    getCamp().then((campData) {
      setState(() {
        camp = campData['camp'];
        imgs = campData['img'];
      });
    });
  }

  Future<Map<String, dynamic>> getCamp() async {
    var url = 'http://10.0.2.2:8081/api/camp/campdetail/${widget.cpdtNo}';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var utf8Decoded = utf8.decode(response.bodyBytes);
      Map<String, dynamic> data = jsonDecode(utf8Decoded);

      List<Camp> productimg = List<Camp>.from(
          data['productimg'].map((item) => Camp.fromJson(item)));
      Camp productintro = Camp.fromJson(data['productintro']);

      Camp camp = Camp(
          cpdtNo: productintro.cpdtNo,
          campName: productintro.campName,
          cpdtName: productintro.cpdtName,
          campTypeName: productintro.campTypeName,
          cpdtSize: productintro.cpdtSize,
          cpdtNop: productintro.cpdtNop,
          cpdtPrice: productintro.cpdtPrice,
          cpdtIntroduction: productintro.cpdtIntroduction);
      List<Camp>? img = [];
      for (var i = 0; i < productimg.length; i++) {
        img.add(Camp(
          cpdiUrl: productimg[i].cpdiUrl,
        ));
      }

      return {
        'camp': camp,
        'img': img,
      };
    } else {
      print("서버 문제");
      return {};
    }
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
                  child: BackButton(
                    //뒤로가기버튼
                    color: Colors.orange,
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CampHomeScreen()));
                        },
                        child: Image.asset(
                          "assets/images/logo2.png",
                          width: 110,
                          height: 60,
                        ),
                      ),
                      const SizedBox(width: 70),
                      CircleAvatar(
                          radius: 22,
                          backgroundColor:
                              notifire.getlightblackcolor.withAlpha(0),
                          child: Icon(
                            Icons.share,
                            color: Colors.orange,
                            size: 25,
                          )),
                      const SizedBox(width: 20),
                      // CircleAvatar(
                      //     radius: 22,
                      //     backgroundColor:
                      //         notifire.getlightblackcolor.withAlpha(0),
                      //     child: Icon(
                      //       Icons.star_border,
                      //       color: Colors.orange,
                      //       size: 30,
                      //     )),
                      // const SizedBox(width: 20),
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
                    itemCount: imgs.length,
                    itemBuilder: (context, index, realIndex) {
                      if (index >= 0 && index < imgs.length) {
                        return Stack(
                          children: [
                            Image.asset(
                              "${imgs[index].cpdiUrl}",
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                            )
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                    options: CarouselOptions(viewportFraction: 1.0)),
              )),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              camp.campName ?? '캠핑장명',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: notifire.getwhiteblackcolor,
                                  fontFamily: "Gilroy Bold"),
                            ),
                            Text(
                              camp.cpdtName ?? "캠핑상품명",
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
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(children: [
                                      Text(
                                        "유형",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: notifire.getwhiteblackcolor,
                                            fontFamily: "Gilroy Bold"),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        camp.campTypeName ?? "캠핑유형",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: notifire.getwhiteblackcolor,
                                            fontFamily: "Gilroy Bold"),
                                      ),
                                    ]),
                                    Column(children: [
                                      Text(
                                        "크기",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: notifire.getwhiteblackcolor,
                                            fontFamily: "Gilroy Bold"),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        camp.cpdtSize ?? "상품 사이즈",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: notifire.getwhiteblackcolor,
                                            fontFamily: "Gilroy Bold"),
                                      ),
                                    ]),
                                    Column(children: [
                                      Text(
                                        "인원",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: notifire.getwhiteblackcolor,
                                            fontFamily: "Gilroy Bold"),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        camp.cpdtNop.toString(),
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: notifire.getwhiteblackcolor,
                                            fontFamily: "Gilroy Bold"),
                                      ),
                                    ]),
                                    Column(children: [
                                      Text(
                                        "가격",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: notifire.getwhiteblackcolor,
                                            fontFamily: "Gilroy Bold"),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        camp.cpdtPrice.toString(),
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: notifire.getwhiteblackcolor,
                                            fontFamily: "Gilroy Bold"),
                                      ),
                                    ]),
                                  ],
                                )),
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
                          camp.cpdtIntroduction ?? "상품소개",
                          trimLines: 3,
                          trimMode: TrimMode.Line,
                          style: TextStyle(
                              color: notifire.getgreycolor,
                              fontFamily: "Gilroy Medium"),
                          trimCollapsedText: '더보기',
                          trimExpandedText: '접기',
                          lessStyle:
                              TextStyle(color: notifire.getdarkbluecolor),
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
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Reservate(
                                  cpdtNo: widget.cpdtNo,
                                  date: date,
                                )));
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 254, 217, 131)), // 배경색 설정
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(0.0), // 모서리 radius 조절
                          ),
                        ),
                      ),
                      child: Text(
                        "예약하기",
                        style: TextStyle(
                            fontSize: 15,
                            color: notifire.getwhiteblackcolor,
                            fontFamily: "Gilroy Bold"),
                      ),
                    )),
                const Divider(),
                const SizedBox(
                  height: 50,
                ),
                const FooterScreen()
              ],
            ),
          ),
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
