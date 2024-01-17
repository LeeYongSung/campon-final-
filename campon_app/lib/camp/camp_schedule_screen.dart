import 'package:campon_app/common/footer_screen.dart';
import 'package:flutter/material.dart';

class CampScheduleScreen extends StatefulWidget {
  const CampScheduleScreen({super.key});

  @override
  State<CampScheduleScreen> createState() => _CampScheduleScreenState();
}

class _CampScheduleScreenState extends State<CampScheduleScreen> {
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
                '현재날짜',
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
