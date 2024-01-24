// ignore_for_file: camel_case_types, avoid_print

import 'dart:convert';

import 'package:campon_app/board/review_read.dart';
import 'package:campon_app/example/Login&ExtraDesign/review.dart';
import 'package:campon_app/example/Utils/Colors.dart';
import 'package:campon_app/example/Utils/customwidget%20.dart';
import 'package:campon_app/example/Utils/dark_lightmode.dart';
import 'package:campon_app/models/board.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class boardMain extends StatefulWidget {
  const boardMain({super.key});

  @override
  State<boardMain> createState() => _boardMainState();
}

class _boardMainState extends State<boardMain> {
  List<String> menu = ["캠핑", "스토어"]; 
  List<Board> newcr = [];
  List<Board> crlist = [];
  List<Board> newpr = [];
  List<Board> prlist = [];
  final ScrollController _controller = ScrollController();


  @override
  void initState() {
    getdarkmodepreviousstate();
    super.initState();
    getMain().then((data) => {
      setState((){
        newcr = data['campreview'];
        crlist = data['crlist'];
        newpr = data['productreview'];
        prlist = data['prlist'];
        print(newpr);
      })
    });
  }

  Future<Map<String, dynamic>> getMain() async{
    var url = 'http://10.0.2.2:8081/api/board/index';
    var response = await http.get(Uri.parse(url));
    print(response.statusCode);
    if(response.statusCode == 200){
      var utf8Decoded = utf8.decode(response.bodyBytes);
      Map<String,dynamic> data = jsonDecode(utf8Decoded);

      List<Board> campreview = List<Board>.from(data['newReviewList'].map((item) => Board.fromJson(item)));
      List<Board> crlist = List<Board>.from(data['crlist'].map((item) => Board.fromJson(item)));
      List<Board> storereview = List<Board>.from(data['newprlist'].map((item) => Board.fromJson(item)));
      List<Board> prlist = List<Board>.from(data['prlist'].map((item) => Board.fromJson(item)));

      List<Board> cr = [];
      for(var i = 0; i < campreview.length; i++){
        cr.add(Board(
          reviewNo: campreview[i].reviewNo,
          reviewTitle: campreview[i].reviewTitle,
          regDate: campreview[i].regDate,
          campName: campreview[i].campName,
          cpdtName: campreview[i].cpdtName,
          reviewImg: campreview[i].reviewImg,
        ));
      }
      List<Board> allcr = [];
      for(var i = 0; i < crlist.length; i++){
        allcr.add(Board(
          reviewNo: crlist[i].reviewNo,
          reviewTitle: crlist[i].reviewTitle,
          regDate: crlist[i].regDate,
          userName: crlist[i].userName,
          campName: crlist[i].campName,
          cpdtName: crlist[i].cpdtName,
          reviewImg: crlist[i].reviewImg,
        ));
      }
      List<Board> pr = [];
      for(var i = 0; i < storereview.length; i++){
        pr.add(Board(
          prNo: storereview[i].prNo,
          prTitle: storereview[i].prTitle,
          prImg: storereview[i].prImg,
          userName: storereview[i].userName,
          productName: storereview[i].productName,
          regDate: storereview[i].regDate,
        ));
      }
      List<Board> allpr = [];
      for(var i = 0; i < prlist.length; i++){
        allpr.add(Board(
          prNo: prlist[i].prNo,
          prTitle: prlist[i].prTitle,
          prImg: prlist[i].prImg,
          userName: prlist[i].userName,
          productName: prlist[i].productName,
          regDate: prlist[i].regDate,
        ));
      }

      return {
        'campreview' : cr,
        'crlist' : allcr,
        'productreview' : pr,
        'prlist' : allpr,
      };
    }else {
      print("서버 문제");
      return {};
    }
  }


  late ColorNotifire notifire;
  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return DefaultTabController(
      initialIndex: 0,
      length: menu.length,
      child: Scaffold(
      appBar:AppBar(
        backgroundColor: notifire.getbgcolor,
        title: Image.asset(
                        "assets/images/logo2.png",
                        width: 110,
                        height: 60,
              ),
        centerTitle: true,
        bottom: TabBar(tabs: List.generate(
          menu.length,
          (index) => Tab( text: menu[index])),
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.orange,
          indicatorColor: Colors.orangeAccent,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
      ),
      backgroundColor: bgcolor,
      body: TabBarView(
        children: <Widget>[
          // 캠핑쪽
          // 최근게시글
          Stack(children:[
          ListView(
          controller: _controller,
          children:[
          const Padding(
            padding: EdgeInsets.all(10),
            child:Text("실시간 캠핑장 리뷰", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),),          
          ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: newcr.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => reviewRead(reviewNo: newcr[index].reviewNo)));
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
                                        newcr[index].reviewImg ?? "assets/images/logo2.png",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        newcr[index].reviewTitle ?? '제목',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: notifire.getwhiteblackcolor,
                                            fontFamily: "Gilroy Bold"),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width * 0.7,
                                        child: Text(
                                          newcr[index].campName ?? '캠핑장명',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: notifire.getwhiteblackcolor,
                                              fontFamily: "Gilroy Medium",
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                      ),
                                      Text(
                                        newcr[index].cpdtName ?? '상품명',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: notifire.getgreycolor,
                                          fontFamily: "Gilroy Bold"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      // 목록
          const Padding(
            padding: EdgeInsets.all(10),
            child:Text("전체 캠핑장 리뷰", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),),          
          ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: crlist.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => reviewRead(reviewNo: crlist[index].reviewNo)));
                            },
                            child: Container(
                              width: double.infinity,
                              height: 35,
                              margin: const EdgeInsets.symmetric(vertical: 3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: notifire.getdarkmodecolor,
                              ),
                              child: Row(
                                children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.1,
                                        child: Text(
                                          "${crlist[index].reviewNo ?? '번호'}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: notifire.getwhiteblackcolor,
                                              fontFamily: "Gilroy Bold"),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width * 0.5,
                                        child: Text(
                                          crlist[index].reviewTitle ?? '제목',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: notifire.getwhiteblackcolor,
                                              fontFamily: "Gilroy Medium",
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.2,
                                        child: Text(
                                          crlist[index].userName ?? '작성자',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: notifire.getgreycolor,
                                            fontFamily: "Gilroy Bold"),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.2,
                                        child: Text(
                                          "${DateFormat('yyyy-MM-dd').format(crlist[index].regDate ?? DateTime.now())}",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: notifire.getgreycolor,
                                            fontFamily: "Gilroy Bold"),
                                          // textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                              ),
                            ),
                          );
                        },
                      ),
                       
          ]),
          Positioned(
              bottom: 16.0, // 아래 여백
              right: 16.0, // 오른쪽 여백
              child: FloatingActionButton(
                onPressed: () {
                  _controller.animateTo(
                    0.0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                child: Icon(Icons.arrow_upward, color: Colors.white,),
                backgroundColor: Color.fromARGB(255, 255, 176, 57),
              ),
            ),         
          ]),

          // 스토어쪽
          Stack(children:[
          ListView(
          controller: _controller,
          children:[
          const Padding(
            padding: EdgeInsets.all(10),
            child:Text("실시간 스토어 리뷰", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),),          
          ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: newpr.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => review()));
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
                                        newpr[index].prImg ?? "assets/images/logo2.png",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        newpr[index].prTitle ?? '제목',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: notifire.getwhiteblackcolor,
                                            fontFamily: "Gilroy Bold"),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width * 0.7,
                                        child: Text(
                                          newpr[index].productName ?? '상품명',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: notifire.getwhiteblackcolor,
                                              fontFamily: "Gilroy Medium",
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      // 목록
          const Padding(
            padding: EdgeInsets.all(10),
            child:Text("전체 스토어 리뷰", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),),          
          ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: prlist.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => review()));
                            },
                            child: Container(
                              width: double.infinity,
                              height: 35,
                              margin: const EdgeInsets.symmetric(vertical: 3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: notifire.getdarkmodecolor,
                              ),
                              child: Row(
                                children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.1,
                                        child: Text(
                                          "${prlist[index].prNo ?? '번호'}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: notifire.getwhiteblackcolor,
                                              fontFamily: "Gilroy Bold"),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width * 0.5,
                                        child: Text(
                                          prlist[index].prTitle ?? '제목',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: notifire.getwhiteblackcolor,
                                              fontFamily: "Gilroy Medium",
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.2,
                                        child: Text(
                                          prlist[index].userName ?? '작성자',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: notifire.getgreycolor,
                                            fontFamily: "Gilroy Bold"),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.2,
                                        child: Text(
                                          "${DateFormat('yyyy-MM-dd').format(prlist[index].regDate ?? DateTime.now())}",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: notifire.getgreycolor,
                                            fontFamily: "Gilroy Bold"),
                                          // textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                              ),
                            ),
                          );
                        },
                      ),
                       
          ]),
          Positioned(
              bottom: 16.0, // 아래 여백
              right: 16.0, // 오른쪽 여백
              child: FloatingActionButton(
                onPressed: () {
                  _controller.animateTo(
                    0.0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                child: Icon(Icons.arrow_upward, color: Colors.white,),
                backgroundColor: Color.fromARGB(255, 255, 176, 57),
              ),
            ),         
          ]),

      ]),
    )
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
