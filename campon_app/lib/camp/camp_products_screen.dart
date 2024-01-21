import 'package:campon_app/common/footer_screen.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CampProductsScreen extends StatefulWidget {
  final String category;
  const CampProductsScreen({super.key, required this.category});

  @override
  State<CampProductsScreen> createState() => _CampProductsScreenState();
}

class _CampProductsScreenState extends State<CampProductsScreen> {
  final GlobalKey<ExpansionTileCardState> cardA = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = GlobalKey();

  bool _isCheckAuto = false;
  bool _isCheckGlam = false;
  bool _isCheckKara = false;
  bool _isCheckPen = false;
  bool _isCheckCamp = false;

  late String category;

  List items = [];
  // List<String> campType = [];
  List<String> campType = ["1", "2", "3", "4", "5"];

  final ScrollController _controller = ScrollController();

  int _page = 1;
  Map<String, dynamic> _pageObj = {'last': 0};

  @override
  void initState() {
    super.initState();

    category = widget.category ?? '0';
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
    print(category);
    print(campType);
    // http
    // 1. URL 인코딩
    // 2. GET 방식 요청
    if (category == '0') {
      final url = Uri.parse('http://10.0.2.2:8081/api/camp/campSearch');
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'keyword': '',
            'searchDate': '2024-01-21',
            'regionNo': category,
            'checkBoxList': campType,
          }));
      print(response.statusCode);

      if (response.statusCode == 200) {
        print('여긴?');
        setState(() {
          // items.addAll(['New']);
          // JSON 문자열 ➡ List<>
          var utf8Decoded = utf8.decode(response.bodyBytes);
          var result = json.decode(utf8Decoded);

          print(result);

          items = result;
        });
      }
    } else {
      final url =
          Uri.parse('http://10.0.2.2:8081/api/camp/campproducts/$category');
      final response = await http.get(url);
      print(response.statusCode);

      if (response.statusCode == 200) {
        print('여긴?');
        setState(() {
          // items.addAll(['New']);
          // JSON 문자열 ➡ List<>
          var utf8Decoded = utf8.decode(response.bodyBytes);
          var result = json.decode(utf8Decoded);

          print(result);
          items = result;
          // final page = result['page'];
          // final List list = result['list'];
          // // final List newData = json.decode(utf8Decoded);
          // print('page : ');
          // print(page);
          // _pageObj = page;

          //   items.addAll(list.map<String>((item) {
          //     // Map<String, ?> : 요소 접근 - item.['key']
          //     // Item (id, title, body)
          //     final campNo = item['campNo'];
          //     final campName = item['campName'];
          //     return 'Item $campNo - $campName';
          //   }));
          //   _page++;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String categoryName = widget.category;

    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/images/logo2.png",
          width: 110,
          height: 60,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: ExpansionTileCard(
              key: cardB,
              expandedTextColor: Colors.deepOrange,
              leading: Icon(Icons.search),
              title: const Text('검색하기'),
              children: <Widget>[
                const Divider(
                  thickness: 1.0,
                  height: 1.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            child: TextField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0.0),
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromRGBO(125, 125, 125, 0.2)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0.0),
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromRGBO(125, 125, 125, 0.6)),
                                ),
                                hintText: '검색명',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text('날짜'),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text('지역'),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
                    child: Container(
                      height: 50,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Row(
                            children: [
                              Text('캠핑종류'),
                              Checkbox(
                                value: _isCheckAuto,
                                onChanged: (value) {
                                  setState(() {
                                    _isCheckAuto = value!;
                                  });
                                },
                              ),
                              Text("오토캠핑"),
                              Checkbox(
                                value: _isCheckGlam,
                                onChanged: (value) {
                                  setState(() {
                                    _isCheckGlam = value!;
                                  });
                                },
                              ),
                              Text("글램핑"),
                              Checkbox(
                                value: _isCheckKara,
                                onChanged: (value) {
                                  setState(() {
                                    _isCheckKara = value!;
                                  });
                                },
                              ),
                              Text("카라반"),
                              Checkbox(
                                value: _isCheckPen,
                                onChanged: (value) {
                                  setState(() {
                                    _isCheckPen = value!;
                                  });
                                },
                              ),
                              Text("펜션"),
                              Checkbox(
                                value: _isCheckCamp,
                                onChanged: (value) {
                                  setState(() {
                                    _isCheckCamp = value!;
                                  });
                                },
                              ),
                              Text("캠프닉"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text('검색하기'),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0))),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30.0),
            child: Image.asset('assets/images/wide_banner.jpg'),
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
                                          // Image.asset("assets/images/star.png",
                                          //     height: 17),
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
