import 'dart:convert';

import 'package:campon_app/board/board_main.dart';
import 'package:campon_app/camp/camp_favorites_screen.dart';
import 'package:campon_app/camp/camp_home_screen.dart';
import 'package:campon_app/camp/campdetail.dart';
import 'package:campon_app/common/footer_screen.dart';
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
  final int campNo;
  const CampProduct({super.key, required this.campNo});

  @override
  State<CampProduct> createState() => _CampProductState();
}

class _CampProductState extends State<CampProduct> {
  Camp _camp = Camp();
  late int campNo = 0;
  int _reserve = 0;
  List<Camp> cpdtList = [];
  List<Camp> environment = [];
  List<Camp> facility = [];
  List<Camp> imgs = [];
  Users seller = Users();
  Board campreview = Board();

  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;
  @override
  void initState() {
    getdarkmodepreviousstate();
    super.initState();
    campNo = widget.campNo;

    getCamp().then((campData) {
      setState(() {
        _camp = campData['campObject'];
        _reserve = campData['productsreserve'];
        cpdtList = campData['cpdtList'];
        environment = campData['environment'];
        facility = campData['facility'];
        seller = campData['seller'];
        imgs = campData['img'];
        campreview = campData['review'];
        print("img: $imgs");
      });
    });
  }

  Future<Map<String, dynamic>> getCamp() async{
    Board productsreview;
    // try{
    var url = 'http://10.0.2.2:8081/api/camp/campproduct/$campNo';
    var response = await http.get(Uri.parse(url));
    print(response.statusCode);

    if (response.statusCode == 200) {
      var utf8Decoded = utf8.decode(response.bodyBytes);
      Map<String, dynamic> data = jsonDecode(utf8Decoded);

      List<Camp> productsimg = List<Camp>.from(
          data['productsimg'].map((item) => Camp.fromJson(item)));
      Camp productsproducts = Camp.fromJson(data['productsproducts']);
      int productsreserve = data['productsreserve'];
      Users productsseller = Users.fromJson(data['productsseller']);
      List<Camp> productsenvironment = List<Camp>.from(data['productsenvironment'].map((item) => Camp.fromJson(item)));
      if (data['productsreview'] is Map<String, dynamic>) {
        productsreview = Board.fromJson(data['productsreview']);
      } else {
        // 데이터가 유효하지 않은 경우 처리
        // 예: 기본값 설정 또는 다른 처리 방법
        productsreview = Board(); // 기본값으로 초기화
      }

      List<Camp> productsfacility = List<Camp>.from(
          data['productsfacility'].map((item) => Camp.fromJson(item)));
      List<Camp> productsproductlist = List<Camp>.from(
          data['productsproductlist'].map((item) => Camp.fromJson(item)));

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
      for (var i = 0; i < productsproductlist.length; i++) {
        cpdt.add(Camp(
            cpdtNo: productsproductlist[i].cpdtNo,
            cpdiUrl: productsproductlist[i].cpdiUrl,
            campTypeName: productsproductlist[i].campTypeName,
            cpdtName: productsproductlist[i].cpdtName,
            cpdtPrice: productsproductlist[i].cpdtPrice));
      }
      Board review = Board(
          reviewNo: productsreview.reviewNo,
          userName: productsreview.userName,
          campName: productsreview.campName,
          reviewImg: productsreview.reviewImg,
          reviewCon: productsreview.reviewCon,
        );
      

      List<Camp>? img = [];
      for (var i = 0; i < productsimg.length; i++) {
        img.add(Camp(
          cpiUrl: productsimg[i].cpiUrl,
        ));
      }

      List<Camp>? environment = [];
      for (var i = 0; i < productsenvironment.length; i++) {
        environment.add(Camp(
          environmentTypeName: productsenvironment[i].environmentTypeName,
        ));
      }

      List<Camp>? facility = [];
      for (var i = 0; i < productsfacility.length; i++) {
        facility.add(Camp(
            facilitytypeImg: productsfacility[i].facilitytypeImg,
            facilitytypeName: productsfacility[i].facilitytypeName));
      }

      Users seller = Users(
          companyName: productsseller.companyName,
          companyNumber: productsseller.companyNumber,
          userName: productsseller.userName);

      print("캠프설명 : ${img}");
      return {
        'campObject': campObject,
        'productsreserve': productsreserve,
        'cpdtList': cpdt,
        'environment': environment,
        'facility': facility,
        'seller': seller,
        'img': img,
        'review': review,
      };
    } else {
      print("서버 문제");
      return {};
    }
    // }catch(e){
    //   print("예외!!!! $e");
    //   return {};
    // }
  }

  Future<void> Add() async{
    Map<String,dynamic> data = {
      'campNo' : campNo
    };

    var url = 'http://10.0.2.2:8081/api/camp/favorites';
    var response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data)
    );

    if (response.statusCode == 201) {
        print('성공');
        showDialog(context: context, builder: (BuildContext context){
                                              return AlertDialog(
                                                content: Text("찜 페이지로 이동하시겠습니까?"),
                                                actions: [
                                                  TextButton(onPressed: (){Navigator.of(context).push(MaterialPageRoute(
                                                                            builder: (context) => CampFavoritesScreen()));}, child: Text("이동")),
                                                  TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text("취소")),
                                                ],
                                              );
                                            });

    }else{
      print("에러");

    }

  }

  late ColorNotifire notifire;

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
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) =>
                                                CampHomeScreen()));
                    },
                    child: Image.asset(
                      "assets/images/logo2.png",
                      width: 110,
                      height: 60,
                    ),
                  ),
                  const SizedBox(width: 20),
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: notifire.getlightblackcolor.withAlpha(0),
                    child: Icon(Icons.share, color: Colors.orange, size: 25,)
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () { Add();},
                    child: Icon(Icons.star_border, color:Colors.orange, size: 30,),
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
               itemCount: imgs.length,
              itemBuilder: (context, index, realIndex) {
                if (index >= 0 && index < imgs.length) {
                      return Stack(           
                        children: [
                          Image.asset(
                            "${imgs[index].cpiUrl}",
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                          )
                        ],
                      );
                    } else {
                      return Container();
                    }                             
              },
              options: CarouselOptions(viewportFraction: 1.0)
          ),
        )),
        SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: environment
                            .map((item) => Text(
                                  item.environmentTypeName ?? '환경',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: notifire.getwhiteblackcolor,
                                      fontFamily: "Gilroy Bold"),
                                ))
                            .toList(),
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
                          child: TextButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 249, 161, 79)), // 배경색 설정
                            ),
                            child: Text(
                              "그동안 $_reserve 명이 방문하셨습니다.",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: notifire.getwhiteblackcolor,
                                  fontFamily: "Gilroy Bold"),
                            ),
                          )),
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
                        children: facility
                            .map((item) => Column(
                                  children: [
                                    Image.asset(
                                        item.facilitytypeImg ??
                                            "assets/images/wifi.png",
                                        height: 30,
                                        color: notifire.getwhiteblackcolor),
                                    Text(
                                      item.facilitytypeName ?? '시설명',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: notifire.getgreycolor,
                                          fontFamily: "Gilroy Medium"),
                                    ),
                                  ],
                                ))
                            .toList(),
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
                        "캠핑장 배치도",
                        style: TextStyle(
                            fontSize: 18,
                            color: notifire.getwhiteblackcolor,
                            fontFamily: "Gilroy Bold"),
                      ),
                      Image.asset(
                        _camp.campLayout ??
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
                                  builder: (context) => CampDetail(
                                      cpdtNo: cpdtList[index].cpdtNo)));
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
                                        cpdtList[index].cpdiUrl ??
                                            "assets/images/SagamoreResort.jpg",
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
                                          cpdtList[index].campTypeName ??
                                              '캠핑 타입',
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
                                                cpdtList[index]
                                                    .cpdtPrice
                                                    .toString(),
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
                              builder: (context) => const boardMain(),
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
                      child: campreview.reviewNo != null ?
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const review()));
                                },
                              child:  Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    
                                        Container(
                                          margin: EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children:[
                                              Text(
                                                campreview.userName ?? '작성자',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: notifire.getwhiteblackcolor,
                                                  fontFamily: "Gilroy Bold"),
                                              ),
                                              Text(
                                                campreview.campName ?? "캠핑장명",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: notifire.getwhiteblackcolor,
                                                  fontFamily: "Gilroy Bold"),
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context).size.height * 0.007,
                                              ),
                                              Text(
                                                campreview.reviewCon ?? "리뷰내용",
                                                style: TextStyle(
                                                  fontSize: 13,
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
                                              campreview.reviewImg ?? "assets/images/SagamoreResort.jpg",
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ],
                                ),
                              ) ) : Text("등록된 리뷰가 없습니다.")
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
                          "1. 캠핑장 입실 : 오후 1시 ~ 오후 9시 \n2. 온수 사용 시간 오전 8시 ~ 오후 10시 \n( 화장실 외 부대 시설 - 오후 10시 마감 ) \n3. 노래를 크게 틀지 마시고 아이들이 너무 시끄럽게 하지 말아 주세요. \n4. 캠핑장 입실시 모두 관리실에 오셔서 체크인 해 주세요. \n5. 담배는 지정된 흡연실에서만 이용하세요. \n6. 쓰레기은 관리실 앞에 지정된 장소에서 분리 해 주세요. \n7. 카라반, 캠핑카, 차량추가, 전기차 충전시, 1박 10,000원 추가요금 부과 \n8. 불명시 화롯대 받침대 사용하시고 화롯대은 바닥에서 15센치 이상 되는 화롯대을 사용 해 주세요. \n9. 예약자 외 외부인, 차량 통제 \n10. 예약 후 다른 사이트로 이동이 안됩니다. \n11. 전기 사용은 600w 이내로 사용 해 주세요. \n12. 퇴실 시  쓰레기 분리 해 주시고 사이트 내에 청소 부탁합니다.",
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
                          "입금 12시간 이후 취소시 10% 공제 후 환급\n1.예약 후 24시간 후  취소 ☞ 총 요금의 10% 공제 후 환급\n2.사용예정일 10일 전까지 취소 ☞ 총 요금의 20% 공제 후 환급\n3.사용예정일 6 일 전까지 취소 ☞ 총 요금의 30% 공제 후 환급\n4.사용예정일 5일 전까지 취소 ☞ 총 요금의 50% 공제 후 환급\n5.사용예정일 4 일 전까지 취소 ☞ 총 요금의 60% 공제 후 환급 \n6.사용예정일 3 일전 또는 당일 취소시 환급 불가\n- 천재지변( 태풍, 폭설 )으로 인해 입실 불가시 전액 환불 처리 합니다.",
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

            ),
          SizedBox(height: 50.0),
          // Container(
          //   width: double.infinity,
          //   child:FooterScreen(),
          // )
          ],
        ),
        ),
      ],
      ),
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
