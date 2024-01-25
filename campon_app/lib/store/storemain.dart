import 'package:campon_app/common/footer_screen.dart';
import 'package:campon_app/store/cart.dart';
import 'package:campon_app/store/category.dart';
import 'package:campon_app/store/productdetail.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:campon_app/example/Utils/Colors.dart';
import 'package:campon_app/example/Utils/dark_lightmode.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class StoreMain extends StatefulWidget {
  const StoreMain({super.key});

  @override
  State<StoreMain> createState() => _StoreMainState();
}

class _StoreMainState extends State<StoreMain> {
  late ColorNotifire notifire;
  var connected = false;

  int _current = 0;
  final CarouselController _controller = CarouselController();

  //카테고리명, 이미지 등..
  List<dynamic> categories = [
    {"name": "텐트", "image": "img/product/product1.png"},
    {"name": "테이블", "image": "img/product/product2.png"},
    {"name": "체어", "image": "img/product/product3.png"},
    {"name": "매트", "image": "img/product/product4.png"},
    {"name": "조명", "image": "img/product/product5.png"},
    {"name": "화로대", "image": "img/product/product6.png"},
    {"name": "타프", "image": "img/product/product7.png"},
    {"name": "수납", "image": "img/product/product8.png"},
    {"name": "캠핑가전", "image": "img/product/product9.png"},
    {"name": "주방용품", "image": "img/product/product10.png"},
  ];

  List<String> imgList = [
    'img/product/store_banner.png',
    'img/product/store_banner2.png',
    'img/product/store_banner3.png',
    'img/product/store_banner4.png',
    'img/product/store_banner5.png',
  ];

  List<dynamic> productHotList = [
    {
      "productNo": 1,
      "productThumnail": "img/product/11.png",
      "productName": "텐트텐트",
      "productCategory": "텐트",
      "productPrice": "10000"
    },
    {
      "productNo": 1,
      "productThumnail": "img/product/12.png",
      "productName": "아주좋은텐트",
      "productCategory": "텐트",
      "productPrice": "10000"
    },
    {
      "productNo": 1,
      "productThumnail": "img/product/13.png",
      "productName": "정말좋은텐트",
      "productCategory": "텐트",
      "productPrice": "10000"
    },
    {
      "productNo": 1,
      "productThumnail": "img/product/14.png",
      "productName": "최고의텐트",
      "productCategory": "텐트",
      "productPrice": "10000"
    },
    {
      "productNo": 1,
      "productThumnail": "img/product/15.png",
      "productName": "텐트최고",
      "productCategory": "텐트",
      "productPrice": "10000"
    },
  ];

  //하단 광고
  final List<Map<String, dynamic>> lowAdList = [
    {
      "productNo": 1,
      "productThumnail": "img/product/basic.png",
      "productName": "빈슨메시프",
      "productCategory": "베이직 로우 체어 1+1",
      "productPrice": "210,000원",
      "productPrice2": "105,000원"
    },
    {
      "productNo": 1,
      "productThumnail": "img/product/heatta.png",
      "productName": "Heatta",
      "productCategory": "[고급형] 스노우체인 자동차 전륜 체인",
      "productPrice": "68,900원",
      "productPrice2": "51,900원"
    },
    {
      "productNo": 1,
      "productThumnail": "img/product/lugbox.png",
      "productName": "러그박스",
      "productCategory": "[러그박스] 3구 USB 멀티탭 전기릴선",
      "productPrice": "22,000원",
      "productPrice2": "18,900원"
    },
  ];

  List<dynamic> proReviewList = [
    {
      "prNo": 1,
      "prImg": "img/product/review.png",
      "prTitle": "텐트가 좋았어요",
      "prCon": "텐트가 좋았어요 가족들이랑 재밌게 놀다가요",
      "productName": "productName",
      "regDate": "2024-01-17",
      "userId": "홍길동"
    },
    {
      "prNo": 1,
      "prImg": "img/product/review.png",
      "prTitle": "텐트가 좋았어요",
      "prCon": "텐트가 좋았어요 가족들이랑 재밌게 놀다가요",
      "productName": "productName",
      "regDate": "2024-01-17",
      "userId": "길동이"
    },
    {
      "prNo": 1,
      "prImg": "img/product/review.png",
      "prTitle": "텐트가 좋았어요",
      "prCon": "텐트가 좋았어요 가족들이랑 재밌게 놀다가요",
      "productName": "productName",
      "regDate": "2024-01-17",
      "userId": "동길이"
    },
  ];

  //비동기 요청
  Future<void> getProductHotList() async {
    final response =
        await http.get(Uri.parse("http://10.0.2.2:8081/api/product/index"));
    // 서버로부터 응답이 성공적으로 돌아왔는지 확인
    if (response.statusCode == 200) {
      setState(() {
        connected = true;
      });
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      // data는 JSON 형태이므로, 'productHotList' 키로 접근하여 데이터를 가져옵니다.
      final productHotList2 = data['productHotList'];
      final proReviewList2 = data['proReviewList'];
      print('productHotList는? ${productHotList2.toString()}');
      print('proReviewList2는? ${proReviewList2.toString()}');
      productHotList = productHotList2;

      for (int i = 0; i < proReviewList2.length; i++) {
        String datetimeStr = proReviewList2[i]["regDate"].toString();
        DateTime dateTime = DateTime.parse(datetimeStr);
        String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
        proReviewList2[i]["formattedDate"] = formattedDate;
      }
      proReviewList = proReviewList2;
    } else {
      throw Exception('Failed to load product hot list');
    }
  }

  //이미지 에 대한 서버 접근 가능한지에 대한 여부 함수
  Future<Widget> checkUrlAccessibility(String url, int index) async {
    // try {
    final response = await http.get(Uri.parse(url));
    if (response == 200) {
      print('서버 접근 가능');
      return Image.network(
        // "http://10.0.2.2:8081/api/img?file=${proReviewList[index]['prImg'].toString()}",
        url,
        fit: BoxFit.cover,
      );
    }
    //   } else {
    //     return Image.asset("img/product/11.png", fit: BoxFit.cover);
    //   }
    // } catch (e) {
    //   print('서버 접근 불가');
    //   return Image.asset("img/product/11.png", fit: BoxFit.cover);
    // }
    return CircularProgressIndicator();
  }

  Widget sliderWidget() {
    return CarouselSlider(
        carouselController: _controller,
        items: imgList.map((imgLink) {
          return Builder(
            builder: (context) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image(
                  fit: BoxFit.contain,
                  image: AssetImage(imgLink),
                ),
              );
            },
          );
        }).toList(), //items

        options: CarouselOptions(
          height: 300,
          viewportFraction: 1.0,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 4),
          onPageChanged: (index, reason) {
            setState(() {
              _current = index;
            });
          }, // options
        ));
  }

  Widget sliderIndicator() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: imgList.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => _controller.animateToPage(entry.key),
            child: Container(
              width: 12,
              height: 12,
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    Colors.white.withOpacity(_current == entry.key ? 0.9 : 0.4),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getProductHotList();
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
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
            child: Icon(Icons.star),
          ),
          onTap: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => ));
          },
        ),
        actions: [
          GestureDetector(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: Icon(Icons.shopping_cart),
            ),
            onTap: () {
              print('장바구니 클릭');
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Cart()));
            },
          ),
        ],
      ),
      backgroundColor: notifire.getbgcolor,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              children: [
                // 상단 광고( 이미지 슬라이드 )
                SizedBox(
                  height: 300,
                  child: Stack(children: [sliderWidget(), sliderIndicator()]),
                ), // 상단 광고 끝 ( 이미지 슬라이드 )

                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 60,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Category(categoryName: '텐트')));
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    "img/product/product1.png",
                                    height: 30,
                                  ),
                                  Text(
                                    "텐트",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: "Gilroy Medium"),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 60,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Category(categoryName: '테이블')));
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    "img/product/product2.png",
                                    height: 30,
                                  ),
                                  Text(
                                    "테이블",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: "Gilroy Medium"),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 60,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Category(categoryName: '체어')));
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    "img/product/product3.png",
                                    height: 30,
                                  ),
                                  Text(
                                    "체어",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: "Gilroy Medium"),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 60,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Category(categoryName: '매트')));
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    "img/product/product4.png",
                                    height: 30,
                                  ),
                                  Text(
                                    "매트",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: "Gilroy Medium"),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 60,
                            child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Category(categoryName: '조명')));
                                },
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "img/product/product5.png",
                                      height: 30,
                                    ),
                                    Text(
                                      "조명",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Gilroy Medium"),
                                    )
                                  ],
                                )),
                          ),
                        ],
                      ), //한 Row 끝
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 60,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Category(categoryName: '화로대')));
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    "img/product/product6.png",
                                    height: 30,
                                  ),
                                  Text(
                                    "화로대",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: "Gilroy Medium"),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 60,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Category(categoryName: '타프')));
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    "img/product/product7.png",
                                    height: 30,
                                  ),
                                  Text(
                                    "타프",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: "Gilroy Medium"),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 60,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Category(categoryName: '수납')));
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    "img/product/product8.png",
                                    height: 30,
                                  ),
                                  Text(
                                    "수납",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: "Gilroy Medium"),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 60,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Category(categoryName: '캠핑가전')));
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    "img/product/product9.png",
                                    height: 30,
                                  ),
                                  Text(
                                    "캠핑가전",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: "Gilroy Medium"),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 60,
                            child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Category(categoryName: '주방용품')));
                                },
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "img/product/product10.png",
                                      height: 30,
                                    ),
                                    Text(
                                      "주방용품",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Gilroy Medium"),
                                    )
                                  ],
                                )),
                          ),
                        ],
                      ), //한 Row 끝

                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04),

                      //추천상품 시작
                      Text(
                        "추천 상품",
                        style: TextStyle(
                            fontSize: 16,
                            color: notifire.getwhiteblackcolor,
                            fontFamily: "Gilroy Bold"),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      Divider(
                        color: notifire.getgreycolor,
                      ),

                      //추천상품 목록 출력
                      GridView.builder(
                        shrinkWrap: true,
                        physics:
                            NeverScrollableScrollPhysics(), // GridView 스크롤 방지
                        itemCount: productHotList.length, // 생성할 아이템의 총 개수
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 한 줄에 표시할 아이템의 수
                          crossAxisSpacing: 10.0, // 가로 방향 아이템의 간격
                          mainAxisSpacing: 10.0, // 세로 방향 아이템의 간격
                          childAspectRatio: 1.0, // 아이템의 가로 세로 비율
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductDetail(
                                            productNo:
                                                '${productHotList[index]["productNo"]}')));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 122, 122, 122)),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Column(
                                    children: [
                                      // Stack(
                                      //   children: [
                                      Container(
                                        height: 100,
                                        width: double.infinity,
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(12),
                                              topRight: Radius.circular(12)),
                                          child: !connected
                                              ? Image.asset(
                                                  productHotList[index][
                                                              "productThumnail"]
                                                          .toString()
                                                          .startsWith('/')
                                                      ? productHotList[index][
                                                              "productThumnail"]
                                                          .toString()
                                                          .substring(1)
                                                      : productHotList[index][
                                                              "productThumnail"]
                                                          .toString(),
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.network(
                                                  'http://10.0.2.2:8081/api/img?file=${productHotList[index]["productThumnail"]}'),
                                        ),
                                      ),
                                      //   ],
                                      // ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  productHotList[index]
                                                          ["productNo"]
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: notifire
                                                          .getwhiteblackcolor,
                                                      fontFamily:
                                                          "Gilroy Bold"),
                                                ),
                                                Text(
                                                  productHotList[index]
                                                          ["productName"]
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: notifire
                                                          .getdarkbluecolor,
                                                      fontFamily:
                                                          "Gilroy Bold"),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              "${productHotList[index]["productPrice"].toString()}원",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: notifire.getgreycolor,
                                                  fontFamily: "Gilroy Medium",
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ) //Container,
                              );
                        },
                      ) // 그리드빌더 끝
                    ],
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                //캠프온이 처음이신가요?
                InkWell(
                  onTap: () {},
                  child: Column(
                    children: [
                      Divider(
                        color: notifire.getgreycolor,
                      ),
                      Text(
                        '캠프온이 처음이신가요? 캠프온 이용 안내',
                        style: TextStyle(),
                      ),
                      Divider(
                        color: notifire.getgreycolor,
                      ),
                    ],
                  ),
                ),

                //하단 광고 목록 출력
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(), // GridView 스크롤 방지
                  itemCount: lowAdList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 5),
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
                                  lowAdList[index]["productThumnail"]
                                          .toString()
                                          .startsWith('/')
                                      ? lowAdList[index]["productThumnail"]
                                          .toString()
                                          .substring(1)
                                      : lowAdList[index]["productThumnail"]
                                          .toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  lowAdList[index]["productName"].toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: notifire.getwhiteblackcolor,
                                      fontFamily: "Gilroy Bold"),
                                ),
                                Text(
                                  lowAdList[index]["productCategory"]
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: notifire.getgreycolor,
                                      fontFamily: "Gilroy Medium",
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                            Expanded(child: SizedBox()),
                            Column(
                              children: [
                                Text(
                                  lowAdList[index]["productPrice"].toString(),
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: notifire.getgreycolor,
                                      fontFamily: "Gilroy Medium",
                                      decoration: TextDecoration.lineThrough,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                Text(
                                  lowAdList[index]["productPrice2"].toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: notifire.getwhiteblackcolor,
                                      fontFamily: "Gilroy Bold"),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                // 상품 후기
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Text(
                  "상품 후기",
                  style: TextStyle(
                      fontSize: 16,
                      color: notifire.getwhiteblackcolor,
                      fontFamily: "Gilroy Bold"),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Divider(
                  color: notifire.getgreycolor,
                ),

                //상품 후기 목록  출력
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: proReviewList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 5),
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
                                child: connected
                                    ? Image.network(
                                        "http://10.0.2.2:8081/api/img?file=${proReviewList[index]['prImg'].toString()}",
                                        errorBuilder: (BuildContext context,
                                            Object exception,
                                            StackTrace? stackTrace) {
                                          return const CircularProgressIndicator();
                                        },
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        proReviewList[index]["prImg"]
                                                .toString()
                                                .startsWith('/')
                                            ? proReviewList[index]["prImg"]
                                                .toString()
                                                .substring(1)
                                            : proReviewList[index]["prImg"]
                                                .toString(),
                                        fit: BoxFit.cover,
                                      ),

                                // FutureBuilder<Widget?>(
                                //     future: checkUrlAccessibility(
                                //         "http://10.0.2.2:8081/api/img?file=${proReviewList[index]['prImg'].toString()}",
                                //         index),
                                //     builder: (context, snapshot) {
                                //       if (snapshot.connectionState == ConnectionState.waiting) {
                                //         // 데이터 로딩 중에 보여줄 위젯
                                //         return Image.asset("img/product/product1.png", fit: BoxFit.cover);
                                //       } else if (snapshot.hasError) {
                                //         // 에러가 발생했을 때 보여줄 위젯
                                //         return Image.asset("img/product/product2.png", fit: BoxFit.cover);
                                //       } else {
                                //         // 데이터가 성공적으로 로드되었을 때 보여줄 위젯
                                //         return snapshot.data ??
                                //            Image.asset("img/product/product3.png", fit: BoxFit.cover);
                                //       }
                                //     },
                                //   ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  proReviewList[index]["prTitle"].toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: notifire.getwhiteblackcolor,
                                      fontFamily: "Gilroy Bold"),
                                ),
                                Text(
                                  proReviewList[index]["prCon"].toString(),
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: notifire.getgreycolor,
                                      fontFamily: "Gilroy Medium",
                                      overflow: TextOverflow.ellipsis),
                                ),
                                Text(
                                  proReviewList[index]["formattedDate"]
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: notifire.getgreycolor,
                                      fontFamily: "Gilroy Medium",
                                      overflow: TextOverflow.ellipsis),
                                ),
                                Text(
                                  proReviewList[index]["userId"].toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: notifire.getwhiteblackcolor,
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
                SizedBox(
                  height: 30.0,
                ),
                const FooterScreen()
              ],
            ),
          ),
        ],
      ), //CustomScrollView 끝
    );
  }
}
