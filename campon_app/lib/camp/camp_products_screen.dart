import 'package:campon_app/common/footer_screen.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

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
  List items = [
    {
      "id": "1",
      "title": "Grand Park City Hotel",
      "img": "assets/images/SwissHotel.jpg",
      "price": "\$26/",
      "address": "155 Rajadamri Road, Bangkok 10330 Thailand",
      "Night": "Night",
      "review": "4.9",
      "reviewCount": "(160 Reviews)"
    },
    {
      "id": "2",
      "title": "The Leela hotel",
      "img": "assets/images/TheLeelaHotel.jpg",
      "price": "\$28/",
      "address": "Chao Anou Road, 112 Vat Chan Village, Chanthabouly District",
      "Night": "Night",
      "review": "4.8",
      "reviewCount": "(150 Reviews)"
    },
    {
      "id": "3",
      "title": "Mandarin Oriental",
      "img": "assets/images/NationalHotel.jpg",
      "price": "\$30/",
      "address": "1091/336 New Petchburi Road, 10400 Bangkok, Thailand",
      "Night": "Night",
      "review": "4.7",
      "reviewCount": "(140 Reviews)"
    },
    {
      "id": "4",
      "title": "Anantara Siam hotel",
      "img": "assets/images/dubaiHotel.jpg",
      "price": "\$32/",
      "address": "87 Wireless Road, Phatumwan, 10330, Bangkok",
      "Night": "Night",
      "review": "4.6",
      "reviewCount": "(130 Reviews)"
    },
    {
      "id": "5",
      "title": "Boutique Hotel",
      "img": "assets/images/AnticipatedHotel.jpg",
      "price": "\$34/",
      "address": "Sheikh Mohammed Bin Rashed Boulevard, Downtown Dubai",
      "Night": "Night",
      "review": "4.5",
      "reviewCount": "(120 Reviews)"
    },
    {
      "id": "6",
      "title": "Sterling Hotel",
      "img": "assets/images/IntercontinentalHotel.jpg",
      "price": "\$36/",
      "address": "103 River Street, Ballina, Ballina, Australia",
      "Night": "Night",
      "review": "4.4",
      "reviewCount": "(110 Reviews)"
    },
    {
      "id": "7",
      "title": "Royal Fort Hotel",
      "img": "assets/images/StateHotel.jpg",
      "price": "\$38/",
      "address": "449 Sainte-Hélène St Montréal, Quebec, H2Y 2K9 Canada",
      "Night": "Night",
      "review": "4.3",
      "reviewCount": "(100 Reviews)"
    },
    {
      "id": "8",
      "title": "Singapore Hotel",
      "img": "assets/images/vishakhapatnamHotel.jpg",
      "price": "\$40/",
      "address": "1, Voznesensky Avenue",
      "Night": "Night",
      "review": "4.2",
      "reviewCount": "(90 Reviews)"
    },
    {
      "id": "9",
      "title": "Hyatt Hotel",
      "img": "assets/images/hotel.jpg",
      "price": "\$42/",
      "address":
          "Bandra Kurla Complex Vicinity, Mumbai, Maharashtra, India, 400 055",
      "Night": "Night",
      "review": "4.1",
      "reviewCount": "(80 Reviews)"
    },
    {
      "id": "10",
      "title": "Luxury Hotel",
      "img": "assets/images/SagamoreResort.jpg",
      "price": "\$44/",
      "address": "14, Moyka river embankment.",
      "Night": "Night",
      "review": "3.8",
      "reviewCount": "(70 Reviews)"
    },
  ];

  final ScrollController _controller = ScrollController();

  int _page = 1;
  Map<String, dynamic> _pageObj = {'last': 0};

  @override
  void initState() {
    super.initState();

    // 처음 데이터
    // fetch();

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

  // Future fetch() async {
  //   print('fetch...');
  //   // http
  //   // 1. URL 인코딩
  //   // 2. GET 방식 요청
  //   final url = Uri.parse('http://10.0.2.2:8080/board?page=${_page}');
  //   final response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     setState(() {
  //       // items.addAll(['New']);
  //       // JSON 문자열 ➡ List<>
  //       var utf8Decoded = utf8.decode(response.bodyBytes);
  //       var result = json.decode(utf8Decoded);
  //       final page = result['page'];
  //       final List list = result['list'];
  //       // final List newData = json.decode(utf8Decoded);
  //       print('page : ');
  //       print(page);
  //       _pageObj = page;

  //       items.addAll(list.map<String>((item) {
  //         // Map<String, ?> : 요소 접근 - item.['key']
  //         // Item (id, title, body)
  //         final boardNo = item['boardNo'];
  //         final title = item['title'];
  //         return 'Item $boardNo - $title';
  //       }));
  //       _page++;
  //     });
  //   }
  // }

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
                            Column(
                              children: [
                                SizedBox(
                                  width: 200,
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
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  width: 200,
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
                              ],
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
                    child: Row(
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
                                      items[index]["img"].toString(),
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
                                        items[index]["title"].toString(),
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
                                              items[index]["address"]
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
                                            "Per Night",
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
