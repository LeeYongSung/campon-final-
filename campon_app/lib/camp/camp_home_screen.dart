import 'package:campon_app/camp/camp_products_screen.dart';
import 'package:campon_app/camp/camp_schedule_screen.dart';
import 'package:campon_app/camp/campproduct.dart';
import 'package:campon_app/common/footer_screen.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'package:campon_app/models/camp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
  String exampleImg = "img/camp/exampleImg.png";

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

  List newCampList = [];
  List suggestList = [];
  List newReviewList = [];
  List<String> checkBoxList = [];

  DateTime? today = DateTime.now();
  late String todays;

  Camp? date = Camp();
  String? searchTitle;
  String? searchDate;

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is DateTime) {
      setState(() {
        // 수정한 부분
        if (args.value != null) {
          DateTime selectedDate = args.value;
          print('선택한 날짜: ${DateFormat('yyyy-MM-dd').format(selectedDate)}');
          date = Camp(reservationStart: selectedDate);
          searchDate = date.toString();
        }

        // date 변수에 선택한 날짜를 저장
      });
    }
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          height: 450, // 모달의 높이 설정
          color: Colors.white, // 모달의 배경색 설정
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.07),
              Flexible(
                child: SfDateRangePicker(
                  rangeTextStyle: TextStyle(color: Colors.white),
                  toggleDaySelection: true,
                  endRangeSelectionColor: Colors.yellow,
                  startRangeSelectionColor: Colors.yellow,
                  monthCellStyle: DateRangePickerMonthCellStyle(
                      blackoutDateTextStyle: TextStyle(color: Colors.blueGrey)),
                  backgroundColor: Colors.white,
                  onSelectionChanged: _onSelectionChanged,
                  selectionMode: DateRangePickerSelectionMode.single,
                  initialSelectedDate: DateTime.now(),
                ),
              ),
              Container(
                height: 50.0,
                width: double.infinity, // 'Container' 위젯의 가로 길이를 최대로 설정
                child: ElevatedButton(
                  child: const Text('선택하기'),
                  onPressed: () {
                    Navigator.of(context).pop(); // 모달 닫기
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    newCamp();
    todays = DateFormat('yyyy-MM-dd').format(today!);
  }

  Future newCamp() async {
    print('newCamp...');
    final url = Uri.parse('http://10.0.2.2:8081/api/camp/index');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          var utf8Decoded = utf8.decode(response.bodyBytes);
          var result = json.decode(utf8Decoded);
          print('내부 newCamp...');
          print(result);
          newCampList = result['campnewList'];
          suggestList = result['campHotList'];
          newReviewList = result['newReviewList'];
          print(newCampList);
        });
      } else {
        print('Server returned status code: ${response.statusCode}');
      }
    } catch (e) {
      print('There was a problem with the network request: $e');
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
        leading: GestureDetector(
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            child: Icon(Icons.schedule_outlined),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CampScheduleScreen()));
          },
        ),
        actions: [
          GestureDetector(
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: Icon(Icons.search_outlined),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CampProductsScreen(
                          category: '0',
                          keyword: searchTitle = searchTitle ?? "",
                          searchDate: searchDate = searchDate ?? todays,
                          checkBoxList:
                              checkBoxList.isEmpty ? [] : checkBoxList)));
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
            width: double.infinity,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/campicon1.png',
                            width: 40.0,
                            height: 40.0,
                          ),
                          Text(category1)
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CampProductsScreen(
                                    category: '1',
                                    keyword: searchTitle = searchTitle ?? "",
                                    searchDate: searchDate =
                                        searchDate ?? todays,
                                    checkBoxList: checkBoxList.isEmpty
                                        ? []
                                        : checkBoxList)));
                      },
                    ),
                    GestureDetector(
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/campicon2.png',
                            width: 40.0,
                            height: 40.0,
                          ),
                          Text(category2)
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CampProductsScreen(
                                    category: '2',
                                    keyword: searchTitle = searchTitle ?? "",
                                    searchDate: searchDate =
                                        searchDate ?? todays,
                                    checkBoxList: checkBoxList.isEmpty
                                        ? []
                                        : checkBoxList)));
                      },
                    ),
                    GestureDetector(
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/campicon3.png',
                            width: 40.0,
                            height: 40.0,
                          ),
                          Text(category3)
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CampProductsScreen(
                                    category: '3',
                                    keyword: searchTitle = searchTitle ?? "",
                                    searchDate: searchDate =
                                        searchDate ?? todays,
                                    checkBoxList: checkBoxList.isEmpty
                                        ? []
                                        : checkBoxList)));
                      },
                    ),
                    GestureDetector(
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/campicon4.png',
                            width: 40.0,
                            height: 40.0,
                          ),
                          Text(category4)
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CampProductsScreen(
                                    category: '4',
                                    keyword: searchTitle = searchTitle ?? "",
                                    searchDate: searchDate =
                                        searchDate ?? todays,
                                    checkBoxList: checkBoxList.isEmpty
                                        ? []
                                        : checkBoxList)));
                      },
                    ),
                    GestureDetector(
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/campicon5.png',
                            width: 40.0,
                            height: 40.0,
                          ),
                          Text(category5)
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CampProductsScreen(
                                    category: '5',
                                    keyword: searchTitle = searchTitle ?? "",
                                    searchDate: searchDate =
                                        searchDate ?? todays,
                                    checkBoxList: checkBoxList.isEmpty
                                        ? []
                                        : checkBoxList)));
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
                    Expanded(
                      child: Container(
                        child: ElevatedButton(
                          child: Text(date!.reservationStart != null
                              ? '${DateFormat('yyyy-MM-dd').format(date!.reservationStart!)}'
                              : '날짜 선택'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0.0)),
                            elevation: 2, // 그림자 효과,
                            minimumSize: const Size(100, 50),
                            maximumSize: const Size(double.infinity, 50),
                          ),
                          // 버튼을 눌렀을 때 동작할 내용
                          onPressed: () async {
                            _showModalBottomSheet(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          print("value : " + value);
                          searchTitle = value;
                          print(searchTitle);
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0.0),
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(125, 125, 125, 0.2)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0.0),
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(125, 125, 125, 0.6)),
                          ),
                          hintText: '검색명',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        child: ElevatedButton(
                          child: const Text('지역'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0.0)),
                              elevation: 2 // 그림자 효과
                              ),
                          onPressed: () async {},
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 50,
                        child: ElevatedButton(
                          child: const Text('테마'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0.0)),
                              elevation: 2 // 그림자 효과
                              ),
                          onPressed: () async {},
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 5.0),
                  child: Container(
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Center(
                          child: const Text('캠핑종류'),
                        ),
                        Checkbox(
                          value: _isCheckAuto,
                          onChanged: (value) {
                            setState(() {
                              _isCheckAuto = value!;
                              if (_isCheckAuto == true) {
                                checkBoxList.add('1');
                                checkBoxList.sort();
                                print(checkBoxList);
                              } else {
                                checkBoxList.remove("1");
                                checkBoxList.sort();
                                print(checkBoxList);
                              }
                            });
                          },
                        ),
                        Center(
                          child: const Text("오토캠핑"),
                        ),
                        Checkbox(
                          value: _isCheckGlam,
                          onChanged: (value) {
                            setState(() {
                              _isCheckGlam = value!;
                              if (_isCheckGlam == true) {
                                checkBoxList.add('2');
                                checkBoxList.sort();
                                print(checkBoxList);
                              } else {
                                checkBoxList.remove("2");
                                checkBoxList.sort();
                                print(checkBoxList);
                              }
                            });
                          },
                        ),
                        Center(
                          child: const Text("글램핑"),
                        ),
                        Checkbox(
                          value: _isCheckKara,
                          onChanged: (value) {
                            setState(() {
                              _isCheckKara = value!;
                              if (_isCheckKara == true) {
                                checkBoxList.add('3');
                                checkBoxList.sort();
                                print(checkBoxList);
                              } else {
                                checkBoxList.remove("3");
                                checkBoxList.sort();
                                print(checkBoxList);
                              }
                            });
                          },
                        ),
                        Center(
                          child: const Text("카라반"),
                        ),
                        Checkbox(
                          value: _isCheckPen,
                          onChanged: (value) {
                            setState(() {
                              _isCheckPen = value!;
                              if (_isCheckPen == true) {
                                checkBoxList.add('4');
                                checkBoxList.sort();
                                print(checkBoxList);
                              } else {
                                checkBoxList.remove("4");
                                checkBoxList.sort();
                                print(checkBoxList);
                              }
                            });
                          },
                        ),
                        Center(
                          child: const Text("펜션"),
                        ),
                        Checkbox(
                          value: _isCheckCamp,
                          onChanged: (value) {
                            setState(() {
                              _isCheckCamp = value!;
                              if (_isCheckCamp == true) {
                                checkBoxList.add('5');
                                checkBoxList.sort();
                                print(checkBoxList);
                              } else {
                                checkBoxList.remove("5");
                                checkBoxList.sort();
                                print(checkBoxList);
                              }
                            });
                          },
                        ),
                        Center(
                          child: const Text("캠프닉"),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        child: ElevatedButton(
                          child: const Text('검색하기'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0.0)),
                              elevation: 2 // 그림자 효과
                              ),
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CampProductsScreen(
                                    category: "0",
                                    keyword: searchTitle = searchTitle ?? "",
                                    searchDate: searchDate =
                                        searchDate ?? todays,
                                    checkBoxList: checkBoxList.isEmpty
                                        ? []
                                        : checkBoxList),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30.0),
          Expanded(
            child: Container(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        'assets/images/camp_ads.jpg' ?? exampleImg,
                        width: 150,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset(
                        'assets/images/camp_ads.jpg' ?? exampleImg,
                        width: 150,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30.0),
          Column(
            children: [
              SizedBox(
                width: 500,
                height: 50,
                child: ElevatedButton(
                  child: const Text('캠프온이 처음이신가요? 캠프온 둘러보기'),
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
          const SizedBox(height: 30.0),
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
          const SizedBox(
            height: 10.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1, // 가로 세로 비율을 1로 설정
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(10),
                  itemCount: min(
                      newCampList.length, 6), // 6과 hotelList2.length 중 작은 값을 사용
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 가로에 표시할 항목 수
                    crossAxisSpacing: 10, // 가로 간격
                    mainAxisSpacing: 10, // 세로 간격
                    childAspectRatio: 1, // 항목의 가로 세로 비율
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CampProduct(
                                    campNo: newCampList[index]['campNo'])));
                      },
                      child: Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Column(
                            children: [
                              Image.asset(
                                newCampList[index]['cpiUrl'].toString() ??
                                    exampleImg,
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.cover,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          // const SizedBox(height: 60.0),
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
          const SizedBox(
            height: 10.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1, // 가로 세로 비율을 1로 설정
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(10),
                  itemCount: min(
                      suggestList.length, 6), // 6과 hotelList2.length 중 작은 값을 사용
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 가로에 표시할 항목 수
                    crossAxisSpacing: 10, // 가로 간격
                    mainAxisSpacing: 10, // 세로 간격
                    childAspectRatio: 1, // 항목의 가로 세로 비율
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CampProduct(
                                    campNo: suggestList[index]['campNo'])));
                      },
                      child: Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Column(
                            children: [
                              Image.asset(
                                suggestList[index]['cpiUrl'].toString() ??
                                    exampleImg,
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.cover,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          const SizedBox(height: 30.0),
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
          const SizedBox(
            height: 10.0,
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: newReviewList.length,
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
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Container(
                          height: 75,
                          width: 75,
                          margin: const EdgeInsets.only(right: 12),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              newReviewList[index]["reviewImg"].toString() ??
                                  exampleImg,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                newReviewList[index]["campName"].toString(),
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontFamily: "Gilroy Bold",
                                    color: Colors.grey),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.006),
                              Text(
                                newReviewList[index]["reviewCon"].toString(),
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                    fontFamily: "Gilroy Medium",
                                    overflow: TextOverflow.ellipsis),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.01),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    newReviewList[index]["cpdtName"].toString(),
                                    style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey,
                                        fontFamily: "Gilroy Bold"),
                                  ),
                                  Text(
                                    newReviewList[index]["regDate"].toString(),
                                    style: const TextStyle(
                                        fontSize: 9,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(
            height: 30.0,
          ),
          const FooterScreen(),
          const SizedBox(
            height: 20.0,
          )
        ],
      ),
    );
  }
}
