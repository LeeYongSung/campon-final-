import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:campon_app/example/Login&ExtraDesign/chackout.dart';
import 'package:campon_app/example/Login&ExtraDesign/review.dart';
import 'package:campon_app/example/Utils/Colors.dart';
import 'package:campon_app/example/Utils/customwidget%20.dart';
import 'package:campon_app/example/Utils/dark_lightmode.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

class ProductDetail extends StatefulWidget {
  final String productNo;
  const ProductDetail({super.key, required this.productNo});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  var connected = false;
  late String productNo = widget.productNo;
  int _current = 0;
  final CarouselController _controller = CarouselController();

  List<dynamic> imgList = [
    'img/product/11.png',
    'img/product/12.png',
    'img/product/13.png',
    'img/product/14.png',
    'img/product/15.png',
  ];

  late ColorNotifire notifire;
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;

  bool isExpanded = false;

//상품 정보
  dynamic product = {
    "productNo": 1,
    "productThumnail": "img/product/product1.png",
    "productCategory": "텐트",
    "productName": "비바코 리빙쉘텐트 젤라",
    "productPrice": "50,000",
    "productConFile": "img/product/store_banner3.png",
  };
  // product? {productNo: 1, productName: 1, productThumnail: /img/product/3d5486f7-470c-496f-a5ef-707ff8d29c1a_20231115_103134.png, productCon: 상품1, productIntro: 상품설명1, productCategory: 텐트, productPrice: 10000000, regDate: 2023-11-01T07:28:23.000+00:00, updDate: 2023-11-01T07:28:23.000+00:00, userNo: null, productimgNo: null, productimgUrl: null, productImgsUrlList: null, productThmFile: null, productConFile: null, productImgs: null, cartNo: null, cartCnt: null, productsaveNo: 0, wishlistNo: 0, orderCnt: 0, sum: null, orderNo: 0}

  List<dynamic> proReviewList = [
    {
      "prNo": 1,
      "prImg": "img/product/review.png",
      "prTitle": "후기 제목",
      "prCon": "구체적 후기 내용",
      "productName": "productName",
      "regDate": "2024-01-17",
      "userId": "userId"
    },
    {
      "prNo": 1,
      "prImg": "img/product/review.png",
      "prTitle": "후기 제목",
      "prCon": "구체적 후기 내용",
      "productName": "productName",
      "regDate": "2024-01-17",
      "userId": "userId"
    },
    {
      "prNo": 1,
      "prImg": "img/product/review.png",
      "prTitle": "후기 제목",
      "prCon": "구체적 후기 내용",
      "productName": "productName",
      "regDate": "2024-01-17",
      "userId": "userId"
    },
  ];

  // int productNo = 1; //하드코딩 (TODO)
  int reviewCount = 10;
  //리뷰 비동기 요청
  Future<void> getReviewList(productNo) async {
    final response = await http.get(Uri.parse(
        "http://10.0.2.2:8081/api/product/productdetail?productNo=${productNo}"));
    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      final product2 = data['product'];
      final productReview2 = data['proReviewList'];
      final reviewCount2 = data['reviewCount'];
      // productReview의 formattedDate 속성 추가
      for (int i = 0; i < productReview2.length; i++) {
        String datetimeStr = productReview2[i]["regDate"].toString();
        DateTime dateTime = DateTime.parse(datetimeStr);
        String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
        productReview2[i]["formattedDate"] = formattedDate;
      }

      setState(() {
        connected = true;
        proReviewList = productReview2;
        print('proReviewList는? ${proReviewList}');
        product = product2;
        print('product는? ${product}');
        // product는? {productNo: 9, productName: 9, productThumnail: /img/product/e2d875ad-a365-4d9e-af4e-8df0a9141a7b_20231115_113435.png, productCon: 상품9, productIntro: 상품설명9, productCategory: 캠핑가전, productPrice: 90000000, regDate: 2023-11-01T07:28:23.000+00:00, updDate: 2023-11-01T07:28:23.000+00:00, userNo: null, productimgNo: null, productimgUrl: null, productImgsUrlList: [/img/productdetai1.jpg, /img/productdetai2.jpg, /img/productdetai3.jpg, /img/productdetai4.jpg, /img/productdetai5.jpg], productThmFile: null, productConFile: null, productImgs: null, cartNo: null, cartCnt: null, productsaveNo: 0, wishlistNo: 0, orderCnt: 0, sum: null, orderNo: 0}

        //이미지 슬라이드
        imgList = product["productImgsUrlList"];
        print('imgList는? ${imgList}');

        reviewCount = reviewCount2;
        print('reviewCount? ${reviewCount}');
      });
    } else {
      throw Exception('Failed to load getReviewList()');
    }
  }

  //장바구니 버튼 클릭 시 실행되는 함수
  Future<dynamic> addCart() async {
    print("장바구니 버튼 클릭");
    print("장바구니 버튼 클릭");
    print("장바구니 버튼 클릭");
    print("장바구니 버튼 클릭");
    //TODO 하드코딩
    int userNo = 1;
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:8081/api/product/addProductsaveAjax?productNo=${productNo}&userNo=${userNo}'));
    if (response.statusCode == 200) {
      print("response.statusCode == 200 입니다. ");
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      if (data == "SUCCESS") {
        print("data == 'SUCCESS' ");
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("장바구니에 등록되었습니다."),
            );
          },
        );
      } else {
        print("data == 'SUCCESS' 아님 ");
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("장바구니에 이미 등록되어있습니다. "),
            );
          },
        );
      }
    }
  }

//이미지 슬라이드
  Widget sliderWidget() {
    return CarouselSlider(
        carouselController: _controller,
        items: imgList.map((imgLink) {
          return Builder(
            builder: (context) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image(
                  fit: BoxFit.cover,
                  image: connected
                      ? NetworkImage(
                              'http://10.0.2.2:8081/api/img?file=${imgLink}')
                          as ImageProvider<Object>
                      : AssetImage(imgLink),
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
    getReviewList(productNo);
    print('productNo은 ? ${productNo}');
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);

//상세이미지의 높이 알아내기
    Image image = Image.network('https://i.stack.imgur.com/lkd0a.png');
    Completer<ui.Image> completer = Completer<ui.Image>();
    image.image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool isSync) {
        completer.complete(info.image);
      }),
    );

    return Scaffold(
        backgroundColor: notifire.getbgcolor,
        body: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            elevation: 0,
            backgroundColor: notifire.getbgcolor,
            leading: Padding(
              padding: const EdgeInsets.only(top: 8, left: 12),
              child: CircleAvatar(
                backgroundColor: notifire.getlightblackcolor,
                child: BackButton(
                  color: notifire.getdarkwhitecolor,
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                  children: [
                    //장바구니 버튼
                    GestureDetector(
                      onTap: () {
                        print("장바구니 버튼 클릭");
                        addCart();
                      },
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor: notifire.getlightblackcolor,
                        child: Icon(
                          Icons.shopping_cart,
                          color: notifire.getdarkwhitecolor,
                          weight: 25,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    //찜 버튼
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: notifire.getlightblackcolor,
                      child: Image.asset(
                        "assets/images/heart.png",
                        color: notifire.getdarkwhitecolor,
                        height: 25,
                      ),
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
              background: Stack(children: [sliderWidget(), sliderIndicator()]),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${product['productCategory']}",
                      style: TextStyle(
                          fontSize: 14,
                          color: notifire.getgreycolor,
                          // color: notifire.getwhiteblackcolor,
                          fontFamily: "Gilroy Bold"),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "${product['productName']}",
                      style: TextStyle(
                          // color: notifire.getgreycolor,
                          color: notifire.getwhiteblackcolor,
                          fontSize: 18,
                          fontFamily: "Gilroy Medium"),
                    ),
                    Divider(
                      color: notifire.getgreycolor,
                    ),
                    Row(
                      children: [
                        Text(
                          "리뷰수   ",
                          style: TextStyle(
                              // color: notifire.getgreycolor,
                              color: notifire.getwhiteblackcolor,
                              fontSize: 18,
                              fontFamily: "Gilroy Medium"),
                        ),
                        Text(
                          "${reviewCount}",
                          style: TextStyle(
                              // color: notifire.getgreycolor,
                              color: notifire.getwhiteblackcolor,
                              fontSize: 18,
                              fontFamily: "Gilroy Medium"),
                        ),
                      ],
                    ),

                    Text(
                      "${product['productPrice']}원",
                      style: TextStyle(
                          // color: notifire.getgreycolor,
                          color: notifire.getwhiteblackcolor,
                          fontSize: 18,
                          fontFamily: "Gilroy Medium"),
                    ),

                    //상세 이미지

                    AnimatedContainer(
                      height: isExpanded ? 1000 : 150,
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        child: connected
                            ? Image.network(
                                "http://10.0.2.2:8081/api/img?file=${product['productCon']}",
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                "img/product/detailproduct.jpg",
                                fit: BoxFit.fitWidth,
                              ),
                      ),
                      duration:
                          Duration(milliseconds: 500), // 애니메이션 효과 시간을 설정합니다.
                      curve: Curves.fastOutSlowIn, // 애니메이션 효과를 설정합니다.
                    ),

                    TextButton(
                      child: Text(isExpanded
                          ? '접기'
                          : '더보기'), // isExpanded 상태에 따라 버튼 텍스트를 변경합니다.
                      onPressed: () {
                        setState(() {
                          isExpanded = !isExpanded; // isExpanded 상태를 토글합니다.
                        });
                      },
                    ),

                    Divider(
                      color: notifire.getgreycolor,
                    ),

                    const SizedBox(height: 10),
                    Text(
                      "상품리뷰",
                      style: TextStyle(
                          // color: notifire.getgreycolor,
                          color: notifire.getwhiteblackcolor,
                          fontSize: 18,
                          fontFamily: "Gilroy Medium"),
                    ),

                    //상품 후기
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
                                        ?
                                        //상품후기 이미지
                                        Image.network(
                                            "http://10.0.2.2:8081/api/img?file=${proReviewList[index]['prImg']}",
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset("img/product/review.png"),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      proReviewList[index]["prTitle"]
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: notifire.getwhiteblackcolor,
                                          fontFamily: "Gilroy Bold"),
                                    ),
                                    //텍스트가 넘쳐서 컨테이너 속성을 줌
                                    Container(
                                      width: 250,
                                      child: Text(
                                        proReviewList[index]["prCon"]
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: notifire.getgreycolor,
                                            fontFamily: "Gilroy Medium",
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ),
                                    Text(
                                      proReviewList[index]["formattedDate"]
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: notifire.getgreycolor,
                                          fontFamily: "Gilroy Medium",
                                          overflow: TextOverflow.ellipsis),
                                      maxLines: 2,
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

                    //대여안내
                    //캠프온이 처음이신가요?
                    InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Divider(
                            color: notifire.getgreycolor,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(),
                              Text(
                                '대여안내',
                                style: TextStyle(),
                              ),
                              Icon(Icons.arrow_forward_ios),
                            ],
                          ),
                          Divider(
                            color: notifire.getgreycolor,
                          ),
                        ],
                      ),
                    ),
                    //상품정보공시
                    InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Divider(
                            color: notifire.getgreycolor,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(),
                              Text(
                                '상품정보공시',
                                style: TextStyle(),
                              ),
                              Icon(Icons.arrow_forward_ios),
                            ],
                          ),
                          Divider(
                            color: notifire.getgreycolor,
                          ),
                        ],
                      ),
                    ),
                  ]), //Column 끝
            ),
          ),
        ]));
  }
}
