import 'dart:convert';

import 'package:campon_app/camp/campdetail.dart';
import 'package:campon_app/example/Login&ExtraDesign/chackout.dart';
import 'package:campon_app/example/Login&ExtraDesign/hoteldetail.dart';
import 'package:campon_app/example/Utils/Colors.dart';
import 'package:campon_app/example/Login&ExtraDesign/review.dart';
import 'package:campon_app/example/Utils/dark_lightmode.dart';
import 'package:campon_app/models/camp.dart';
import 'package:campon_app/models/user.dart';
import 'package:campon_app/models/board.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:campon_app/example/Utils/customwidget%20.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;

int selectedIndex = 0;



class CampProduct extends StatefulWidget {
  const CampProduct({super.key});

  @override
  State<CampProduct> createState() => _CampProductState();
}

class _CampProductState extends State<CampProduct> {
  Camp _camp = Camp();
  int _reserve = 0;
  List<Camp> cpdtList = [];
  List<Camp> environment = [];
  List<Camp> facility = [];
  Users seller = Users();

  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;
  @override
  void initState() {
    getdarkmodepreviousstate();
    super.initState();
    
    getCamp().then((campData){
      setState((){
        _camp = campData['campObject'];
        _reserve = campData['productsreserve'];
        cpdtList = campData['cpdtList'];
        environment = campData['environment'];
        facility = campData['facility'];
        seller = campData['seller'];
        print(cpdtList);
      });
    });
  }

  Future<Map<String, dynamic>> getCamp() async{
    // try{
    var url = 'http://10.0.2.2:8081/api/camp/campproduct/11';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200){
    var utf8Decoded = utf8.decode(response.bodyBytes);
    Map<String, dynamic> data = jsonDecode(utf8Decoded);

    List<Camp> productsimg = List<Camp>.from(data['productsimg'].map((item) => Camp.fromJson(item)));
      Camp productsproducts = Camp.fromJson(data['productsproducts']);
      int productsreserve = data['productsreserve'];
      Users productsseller = Users.fromJson(data['productsseller']);
      List<Camp> productsenvironment = List<Camp>.from(data['productsenvironment'].map((item) => Camp.fromJson(item)));
      // List<Board> productsreview = List<Board>.from(data['productsreview'].map((item) => Board.fromJson(item)));
      List<Camp> productsfacility = List<Camp>.from(data['productsfacility'].map((item) => Camp.fromJson(item)));
      List<Camp> productsproductlist = List<Camp>.from(data['productsproductlist'].map((item) => Camp.fromJson(item)));

      Camp campObject = Camp(
        campName: productsproducts.campName,
        campAddress: productsproducts.campAddress,
        campTel: productsproducts.campTel,
        campOpen: productsproducts.campOpen,
        campClose: productsproducts.campClose,
        campCaution: productsproducts.campCaution,
        campLatitude: productsproducts.campLatitude,
        campLongitude: productsproducts.campLongitude,
        campLayout: productsproducts.campLayout,
        campIntroduction: productsproducts.campIntroduction,
      );
      
      List<Camp>? cpdt = [];
      for(var i = 0; i < productsproductlist.length; i++){
        cpdt.add(Camp(
          cpdtNo: productsproductlist[i].cpdtNo,
          cpdiUrl: productsproductlist[i].cpdiUrl,
          campTypeName: productsproductlist[i].campTypeName,
          cpdtName: productsproductlist[i].cpdtName,
          cpdtPrice: productsproductlist[i].cpdtPrice
        ));
      }

      List<Camp>? environment = [];
      for(var i = 0; i < productsenvironment.length; i++){
        environment.add(Camp(
          environmentTypeName: productsenvironment[i].environmentTypeName,
        ));
      }
      
      List<Camp>? facility = [];
      for(var i = 0; i < productsfacility.length; i++){
        facility.add(Camp(
          facilitytypeImg: productsfacility[i].facilitytypeImg,
          facilitytypeName: productsfacility[i].facilitytypeName
        ));
      }

      Users seller = Users(
        companyName: productsseller.companyName,
        companyNumber: productsseller.companyNumber,
        userName: productsseller.userName
      );
      
      print("캠프설명 : ${campObject}");
      return {
        'campObject': campObject,
        'productsreserve': productsreserve,
        'cpdtList' : cpdt,
        'environment' : environment,
        'facility' : facility,
        'seller' : seller
      };
    }else{
      print("서버 문제");
      return {};
    }
    // }catch(e){
    //   print("예외!!!! $e");
    //   return {};
    // }
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
            ]),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/logo2.png",
                    width: 110,
                    height: 60,
                  ),
                  const SizedBox(width: 20),
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
              child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: environment.map((item) => 
                            Text(
                            item.environmentTypeName ?? '환경',
                            style: TextStyle(
                                fontSize: 12,
                                color: notifire.getwhiteblackcolor,
                                fontFamily: "Gilroy Bold"),
                          )).toList(),
                      ),
                    Text(
                      _camp.campName ?? '캠핑장명',
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
                      "주소 : ${_camp.campAddress ?? '캠핑장 주소'}",
                      style: TextStyle(
                          fontSize: 15,
                          color: notifire.getwhiteblackcolor,
                          fontFamily: "Gilroy Bold"),
                    ),
                    Text(
                      "연락처 : ${_camp.campTel ?? '캠핑장 연락처'}",
                      style: TextStyle(
                          fontSize: 15,
                          color: notifire.getwhiteblackcolor,
                          fontFamily: "Gilroy Bold"),
                    ),
                    Text(
                      "OPEN : ${_camp.campOpen ?? '오픈일'}",
                      style: TextStyle(
                          fontSize: 15,
                          color: notifire.getwhiteblackcolor,
                          fontFamily: "Gilroy Bold"),
                    ),
                    Text(
                      "CLOSE : ${_camp.campClose ?? '마감일'}",
                      style: TextStyle(
                          fontSize: 15,
                          color: notifire.getwhiteblackcolor,
                          fontFamily: "Gilroy Bold"),
                    ),
                    Text(
                      "매너타임 : ${_camp.campCaution ?? '매너타임'}",
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
                        "그동안 $_reserve 명이 방문하셨습니다.",
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
                      _camp.campIntroduction ?? '캠핑장 소개',
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: facility.map((item) => Column(
                          children: [
                            Image.asset("assets/images/wifi.png", height: 30, color: notifire.getwhiteblackcolor),
                            Text(
                              item.facilitytypeName ?? '시설명',
                              style: TextStyle(fontSize: 15, color: notifire.getgreycolor, fontFamily: "Gilroy Medium"),
                            ),
                          ],
                        )).toList(),
                      ),
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
                          "캠핑장 배치도 : ${_camp.campLayout ?? '캠핑장 배치도'}",
                          // "캠핑장 배치도",
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
                        itemCount: cpdtList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      CampDetail(cpdtNo: cpdtList[index].cpdtNo)));
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
                                        cpdtList[index].cpdtName ?? '캠핑상품명',
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
                                            cpdtList[index].campTypeName ?? '캠핑 타입',
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
                                                cpdtList[index].cpdtPrice.toString(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: notifire
                                                        .getdarkbluecolor,
                                                    fontFamily: "Gilroy Bold"),
                                              ),
                                              Text(
                                                " 원 / 1박",
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
                          "업체명 : ${seller.companyName ?? '업체명'}",
                          style: TextStyle(
                              fontSize: 15,
                              color: notifire.getwhiteblackcolor,
                              fontFamily: "Gilroy Bold"),
                        ),
                        Text(
                          "사업자번호 : ${seller.companyNumber ?? '사업자번호'}",
                          style: TextStyle(
                              fontSize: 15,
                              color: notifire.getwhiteblackcolor,
                              fontFamily: "Gilroy Bold"),
                        ),
                        Text(
                          "사업주 : ${seller.userName ?? '사업주'}",
                          style: TextStyle(
                              fontSize: 15,
                              color: notifire.getwhiteblackcolor,
                              fontFamily: "Gilroy Bold"),
                        ),
                        

                  ],
                ),

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