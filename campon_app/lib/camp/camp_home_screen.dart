import 'package:campon_app/camp/camp_products_screen.dart';
import 'package:campon_app/camp/camp_schedule_screen.dart';
import 'package:campon_app/common/footer_screen.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CampHomeScreen extends StatefulWidget {
  const CampHomeScreen({super.key});

  @override
  State<CampHomeScreen> createState() => _CampHomeScreenState();
}

class _CampHomeScreenState extends State<CampHomeScreen> {
  String category1 = '오토캠핑';
  String category2 = '글램핑';
  String category3 = '카라반';
  String category4 = '펜션';
  String category5 = '캠프닉';

  bool _isCheckAuto = false;
  bool _isCheckGlam = false;
  bool _isCheckKara = false;
  bool _isCheckPen = false;
  bool _isCheckCamp = false;

  final List<String> slideList = [
    'assets/images/camp1.jpg',
    'assets/images/camp1.jpg',
    'assets/images/camp1.jpg',
  ];

  List hotelList2 = [
    {
      "id": "1",
      "title": "test",
      "img": "assets/images/SwissHotel.jpg",
      "price": "\￦100,000/",
      "address": "재미지고 재미졌음",
      "Night": "Night",
      "review": "4.9",
      "reviewCount": "(160 Reviews)"
    },
    {
      "id": "2",
      "title": "test",
      "img": "assets/images/SwissHotel.jpg",
      "price": "\￦100,000/",
      "address": "재미지고 재미졌음",
      "Night": "Night",
      "review": "4.9",
      "reviewCount": "(160 Reviews)"
    },
    {
      "id": "3",
      "title": "test",
      "img": "assets/images/SwissHotel.jpg",
      "price": "\￦100,000/",
      "address": "재미지고 재미졌음",
      "Night": "Night",
      "review": "4.9",
      "reviewCount": "(160 Reviews)"
    },
    {
      "id": "4",
      "title": "test",
      "img": "assets/images/SwissHotel.jpg",
      "price": "\￦100,000/",
      "address": "재미지고 재미졌음",
      "Night": "Night",
      "review": "4.9",
      "reviewCount": "(160 Reviews)"
    },
  ];
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
        leading: GestureDetector(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            child: Icon(Icons.schedule_outlined),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CampScheduleScreen()));
          },
        ),
        actions: [
          GestureDetector(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: Icon(Icons.search_outlined),
            ),
            onTap: () {
              print('test2.....');
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            child: CarouselSlider.builder(
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
              options: CarouselOptions(viewportFraction: 1.0 // 화면당 이미지 개수 (1개)
                  ),
            ),
          ),
          Container(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      child: Column(
                        children: [
                          Image.asset('assets/images/campicon1.png'),
                          Text(category1)
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CampProductsScreen(category: category1)));
                      },
                    ),
                    GestureDetector(
                      child: Column(
                        children: [
                          Image.asset('assets/images/campicon2.png'),
                          Text(category2)
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CampProductsScreen(category: category2)));
                      },
                    ),
                    GestureDetector(
                      child: Column(
                        children: [
                          Image.asset('assets/images/campicon3.png'),
                          Text(category3)
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CampProductsScreen(category: category3)));
                      },
                    ),
                    GestureDetector(
                      child: Column(
                        children: [
                          Image.asset('assets/images/campicon4.png'),
                          Text(category4)
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CampProductsScreen(category: category4)));
                      },
                    ),
                    GestureDetector(
                      child: Column(
                        children: [
                          Image.asset('assets/images/campicon5.png'),
                          Text(category5)
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CampProductsScreen(category: category5)));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: 500,
                          height: 50,
                          child: ElevatedButton(
                            child: Text('날짜 선택'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0.0)),
                                elevation: 2 // 그림자 효과
                                ),
                            // 버튼을 눌렀을 때 동작할 내용
                            onPressed: () async {
                              // 카카오 로그아웃 요청 - context => provider 가져와서 사용
                              // var user = context.read<UserProvider>();
                              // if(user.isLogin) {
                              //   user.kakaoLogout();
                              //   print('카카오 로그아웃 완료~!');
                              // }
                              // Navigator.pushReplacementNamed(context, "/login");
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: 500,
                          height: 50,
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0.0),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(125, 125, 125, 0.2)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0.0),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(125, 125, 125, 0.6)),
                              ),
                              hintText: '검색명',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: 250,
                          height: 50,
                          child: ElevatedButton(
                            child: Text('지역'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0.0)),
                                elevation: 2 // 그림자 효과
                                ),
                            // 버튼을 눌렀을 때 동작할 내용
                            onPressed: () async {
                              // 카카오 로그아웃 요청 - context => provider 가져와서 사용
                              // var user = context.read<UserProvider>();
                              // if(user.isLogin) {
                              //   user.kakaoLogout();
                              //   print('카카오 로그아웃 완료~!');
                              // }
                              // Navigator.pushReplacementNamed(context, "/login");
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: 250,
                          height: 50,
                          child: ElevatedButton(
                            child: Text('테마'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0.0)),
                                elevation: 2 // 그림자 효과
                                ),
                            // 버튼을 눌렀을 때 동작할 내용
                            onPressed: () async {
                              // 카카오 로그아웃 요청 - context => provider 가져와서 사용
                              // var user = context.read<UserProvider>();
                              // if(user.isLogin) {
                              //   user.kakaoLogout();
                              //   print('카카오 로그아웃 완료~!');
                              // }
                              // Navigator.pushReplacementNamed(context, "/login");
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
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
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: 500,
                          height: 50,
                          child: ElevatedButton(
                            child: Text('검색하기'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0.0)),
                                elevation: 2 // 그림자 효과
                                ),
                            // 버튼을 눌렀을 때 동작할 내용
                            onPressed: () async {
                              // 카카오 로그아웃 요청 - context => provider 가져와서 사용
                              // var user = context.read<UserProvider>();
                              // if(user.isLogin) {
                              //   user.kakaoLogout();
                              //   print('카카오 로그아웃 완료~!');
                              // }
                              // Navigator.pushReplacementNamed(context, "/login");
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 30.0),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Image.asset('assets/images/camp_ads.jpg'),
                  ],
                ),
                Column(
                  children: [
                    Image.asset('assets/images/camp_ads.jpg'),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 30.0),
          Column(
            children: [
              SizedBox(
                width: 500,
                height: 50,
                child: ElevatedButton(
                  child: Text('캠프온이 처음이신가요? 캠프온 둘러보기'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0)),
                      elevation: 2 // 그림자 효과
                      ),
                  // 버튼을 눌렀을 때 동작할 내용
                  onPressed: () async {
                    // 카카오 로그아웃 요청 - context => provider 가져와서 사용
                    // var user = context.read<UserProvider>();
                    // if(user.isLogin) {
                    //   user.kakaoLogout();
                    //   print('카카오 로그아웃 완료~!');
                    // }
                    // Navigator.pushReplacementNamed(context, "/login");
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 30.0),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '신규캠핑장',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 130,
                height: 130,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/camp1-4.jpg',
                        width: 130.0,
                        height: 130.0,
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: 130,
                height: 130,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/camp1-4.jpg',
                        width: 130.0,
                        height: 130.0,
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: 130,
                height: 130,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/camp1-4.jpg',
                        width: 130.0,
                        height: 130.0,
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 130,
                height: 130,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/camp1-4.jpg',
                        width: 130.0,
                        height: 130.0,
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: 130,
                height: 130,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/camp1-4.jpg',
                        width: 130.0,
                        height: 130.0,
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: 130,
                height: 130,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/camp1-4.jpg',
                        width: 130.0,
                        height: 130.0,
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 60.0),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '추천캠핑장',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 130,
                height: 130,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/camp1-4.jpg',
                        width: 130.0,
                        height: 130.0,
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: 130,
                height: 130,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/camp1-4.jpg',
                        width: 130.0,
                        height: 130.0,
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: 130,
                height: 130,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/camp1-4.jpg',
                        width: 130.0,
                        height: 130.0,
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 130,
                height: 130,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/camp1-4.jpg',
                        width: 130.0,
                        height: 130.0,
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: 130,
                height: 130,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/camp1-4.jpg',
                        width: 130.0,
                        height: 130.0,
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: 130,
                height: 130,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/camp1-4.jpg',
                        width: 130.0,
                        height: 130.0,
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 30.0),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '실시간리뷰',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: hotelList2.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) =>
                  //         const hoteldetailpage()));
                },
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            hotelList2[index]["title"].toString(),
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Gilroy Bold",
                                color: Colors.grey),
                          ),
                          // const SizedBox(height: 6),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.006),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.65,
                            child: Text(
                              hotelList2[index]["address"].toString(),
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                  fontFamily: "Gilroy Medium",
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.01),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    hotelList2[index]["price"].toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                        fontFamily: "Gilroy Bold"),
                                  ),
                                  Text(
                                    hotelList2[index]["Night"].toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                        fontFamily: "Gilroy Medium"),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const SizedBox(width: 12),
                                  Image.asset(
                                    "assets/images/star.png",
                                    height: 20,
                                  ),
                                  const SizedBox(width: 2),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Row(
                                      children: [
                                        Text(
                                          hotelList2[index]["review"]
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          hotelList2[index]["reviewCount"]
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                              fontFamily: "Gilroy Medium"),
                                        ),
                                      ],
                                    ),
                                  )
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
          const SizedBox(
            height: 30.0,
          ),
          FooterScreen(),
          SizedBox(
            height: 20.0,
          )
        ],
      ),
    );
  }
}
