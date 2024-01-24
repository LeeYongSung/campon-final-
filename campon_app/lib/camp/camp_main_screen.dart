import 'package:campon_app/board/board_main.dart';
import 'package:campon_app/board/camp_reviewupdate_screen.dart';
import 'package:campon_app/board/product_reviewupdate_screen%20copy.dart';
import 'package:campon_app/camp/camp_favorites_screen.dart';
import 'package:campon_app/camp/camp_home_screen.dart';
import 'package:campon_app/camp/camp_products_screen.dart';
import 'package:campon_app/board/camp_reviewadd_screen.dart';
import 'package:campon_app/camp/reservation.dart';
import 'package:campon_app/example/Login&ExtraDesign/home.dart';
import 'package:campon_app/example/Massage/massage.dart';
import 'package:campon_app/example/Profile/profile.dart';
import 'package:campon_app/example/Search/Search.dart';
import 'package:campon_app/models/camp.dart';
import 'package:campon_app/store/storemain.dart';
import 'package:campon_app/user/login.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

int selectedIndex = 0;

class CampMainScreen extends StatefulWidget {
  const CampMainScreen({super.key});

  @override
  State<CampMainScreen> createState() => _CampMainScreenState();
}

class _CampMainScreenState extends State<CampMainScreen> {
  var _userAuth = 'user';
  Camp camp = Camp();
  DateTime today = DateTime.now();
  var todaySearch;
  List<String> checkBoxList = ["1", "2", "3", "4", "5"];
  String? keyword;

  // 각 페이지 연결
  // 로그인 기능 완료 시 각 권한 별 체크

  List<Widget> get _pageOption {
    return _userAuth == 'user'
        ? [
            CampHomeScreen(), // 캠핑장 메인
            StoreMain(), // 상품 메인
            CampProductsScreen(
                category: '0',
                keyword: keyword,
                searchDate: todaySearch,
                checkBoxList: checkBoxList), // 검색
            // boardMain(), // 리뷰게시판
            // CampReviewUpdate(reviewNo: 11),
            // CampReviewAdd(userNo: 2, campNo: 11, cpdtNo: 10, reservationNo: 11),
            ProductReviewUpdate(
              reviewNo: 29,
            ),
            // profile(), // 마이페이지
            Login()
          ]
        : [];
  }

  @override
  Widget build(BuildContext context) {
    initState() {
      todaySearch = DateFormat('yyyy-MM-dd').format(today);
      keyword = camp.keyword;
    }

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 0,
        selectedLabelStyle: const TextStyle(
            fontFamily: 'Gilroy Bold', fontWeight: FontWeight.bold),
        fixedColor: Colors.deepOrange,
        unselectedLabelStyle: const TextStyle(fontFamily: 'Gilroy Medium'),
        currentIndex: selectedIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
              icon: Image.asset("assets/images/homeicon.png",
                  color: selectedIndex == 0 ? Colors.deepOrange : Colors.grey,
                  height: MediaQuery.of(context).size.height / 35),
              label: 'Home'),
          const BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: '대여',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            label: '검색',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            label: '게시판',
          ),
          const BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            label: '마이페이지',
          ),
        ],
        onTap: (index) {
          setState(() {});
          selectedIndex = index;
        },
      ),
      body: _pageOption[selectedIndex],
    );
  }
}
