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

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  List<String> imgList = [
    'img/product/store_banner.png',
    'img/product/store_banner2.png',
    'img/product/store_banner3.png',
    'img/product/store_banner4.png',
    'img/product/store_banner5.png',
  ];

//상세이미지의 높이를 받아오는 방법
  GlobalKey _imageKey = GlobalKey();
  double _imageHeight = 10;
  void _updateImageHeight()  {
    final BuildContext? context =   _imageKey.currentContext;
      print('이미지하이트는? ${_imageHeight}');
    if (context != null) {
      // findRenderObject가 널이 아닌 RenderObject를 반환할 것이라는 것을 보장한 후에,
      // RenderBox로 캐스팅합니다.
      RenderBox renderBox = context.findRenderObject() as RenderBox;
      setState(() {
        _imageHeight = renderBox.size.height;
        print('이미지하이트는? ${_imageHeight}');
      });
       print('이미지하이트는? ${_imageHeight}');
    }
  }

  late ColorNotifire notifire;
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;

  bool isExpanded = false;

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
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateImageHeight());
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);

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
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: notifire.getlightblackcolor,
                      child: Icon(
                        Icons.shopping_cart,
                        color: notifire.getdarkwhitecolor,
                        weight: 25,
                      ),
                    ),
                    const SizedBox(width: 20),
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
                      "카테고리 분류",
                      style: TextStyle(
                          fontSize: 14,
                          color: notifire.getgreycolor,
                          // color: notifire.getwhiteblackcolor,
                          fontFamily: "Gilroy Bold"),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "대여상품 제목",
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
                          "22",
                          style: TextStyle(
                              // color: notifire.getgreycolor,
                              color: notifire.getwhiteblackcolor,
                              fontSize: 18,
                              fontFamily: "Gilroy Medium"),
                        ),
                      ],
                    ),

                    Text(
                      "100000원",
                      style: TextStyle(
                          // color: notifire.getgreycolor,
                          color: notifire.getwhiteblackcolor,
                          fontSize: 18,
                          fontFamily: "Gilroy Medium"),
                    ),

                    //상세 이미지
                    AnimatedContainer(
                      height: isExpanded
                          ? _imageHeight *(MediaQuery.of(context).size.width /100) 
                          : 100, // isExpanded가 true일 때 전체 이미지를 보여주고, false일 때는 높이를 제한합니다.
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        child: Image.asset(
                          "img/product/product1.png",
                          key: _imageKey,
                          fit: BoxFit.cover, // 이미지가 컨테이너를 꽉 채우도록 설정합니다.
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
                  ]), //Column 끝
            ),
          ),
        ]));
  }
}
