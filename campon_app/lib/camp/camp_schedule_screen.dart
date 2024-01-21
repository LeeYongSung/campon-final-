import 'package:campon_app/common/footer_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CampScheduleScreen extends StatefulWidget {
  const CampScheduleScreen({super.key});

  @override
  State<CampScheduleScreen> createState() => _CampScheduleScreenState();
}

class _CampScheduleScreenState extends State<CampScheduleScreen> {
  List items = [];

  final ScrollController _controller = ScrollController();

  int _page = 1;
  Map<String, dynamic> _pageObj = {'last': 0};
  var today = '';

  @override
  void initState() {
    super.initState();

    // 처음 데이터
    fetch();

    // 다음 페이지 (스크롤)
    _controller.addListener(() {
      // 스크롤 맨밑
      // _controller.position.maxScrollExtent : 스크롤 위치의 최댓값
      // _controller.position.offset : 현재 스크롤 위치
      print('현재 스크롤 : ${_controller.offset}');
      // if (_controller.position.maxScrollExtent < _controller.offset + 50) {
      //   // 데이터 요청 (다음 페이지)
      //   fetch();
      // }
    });
  }

  Future fetch() async {
    print('fetch...');

    final url = Uri.parse('http://10.0.2.2:8081/api/camp/schedule');
    final response = await http.get(url);
    print(response.statusCode);

    if (response.statusCode == 200) {
      print('여긴?');
      setState(() {
        var utf8Decoded = utf8.decode(response.bodyBytes);
        var result = json.decode(utf8Decoded);

        print(result);
        items = result['campschedule'];
        today = result['startDate'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/images/logo2.png",
          width: 110,
          height: 60,
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10.0, left: 5.0, bottom: 30.0),
            child: Text(
              '30일 이내의 오픈일정을 보여줍니다.',
              style: TextStyle(fontSize: 12.0, color: Colors.grey),
            ),
          ),
          Container(
            width: double.infinity,
            height: 50,
            color: Colors.grey,
            child: Center(
              child: Text(
                '$today',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _controller,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                // index : 0 ~ 19
                if (index < items.length) {
                  final item = items[index];
                  return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 200,
                                  width: double.infinity,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12)),
                                    child: Image.asset(
                                      items[index]["cpiUrl"].toString(),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 30,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.grey),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Image.asset("assets/images/star.png",
                                              height: 17),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 4),
                                            child: Text(
                                              items[index]["review"].toString(),
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.white,
                                                  fontFamily: "Gilroy Bold"),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        items[index]["campName"].toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                            fontFamily: "Gilroy Bold"),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/images/location.png",
                                            height: 20,
                                            color: Colors.deepOrange,
                                          ),
                                          const SizedBox(width: 10),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.60,
                                            child: Text(
                                              items[index]["campAddress"]
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                  fontFamily: "Gilroy Medium",
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            items[index]["campOpen"],
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey,
                                                fontFamily: "Gilroy Medium"),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Divider(color: Colors.grey),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      hotelsystem(
                                          image: "assets/images/Bed.png",
                                          text: "2 Beds",
                                          radi: 3),
                                      hotelsystem(
                                          image: "assets/images/wifi.png",
                                          text: "Wifi",
                                          radi: 3),
                                      hotelsystem(
                                          image: "assets/images/gym.png",
                                          text: "Gym",
                                          radi: 3),
                                      hotelsystem(
                                          image: "assets/images/Frame.png",
                                          text: "Breakfast",
                                          radi: 0),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ));
                }
                // index : 20
                else if ((_page - 1) > 1 && _page < _pageObj['last']!) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
              itemCount: items.length + 1, // ProgressIndicator(+1)
            ),
          ),
          SizedBox(height: 50.0),
          const FooterScreen(),
        ],
      ),
    );
  }

  hotelsystem({String? image, text, double? radi}) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          image!,
          height: 25,
          color: Colors.deepPurple,
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style:
              TextStyle(color: Colors.deepOrange, fontFamily: "Gilroy Medium"),
        ),
        const SizedBox(width: 3),
        CircleAvatar(
          radius: radi,
          backgroundColor: Colors.deepOrange,
        )
      ],
    );
  }
}
