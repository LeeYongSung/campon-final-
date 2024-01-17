import 'package:campon_app/camp/camp_favorites_screen.dart';
import 'package:campon_app/camp/camp_home_screen.dart';
import 'package:campon_app/example/Login&ExtraDesign/home.dart';
import 'package:campon_app/example/Massage/massage.dart';
import 'package:campon_app/example/Profile/profile.dart';
import 'package:campon_app/example/Search/Search.dart';
import 'package:flutter/material.dart';

int selectedIndex = 0;

class CampMainScreen extends StatefulWidget {
  const CampMainScreen({super.key});

  @override
  State<CampMainScreen> createState() => _CampMainScreenState();
}

class _CampMainScreenState extends State<CampMainScreen> {
  var _userAuth = 'user';
  // 각 페이지 연결
  // 로그인 기능 완료 시 각 권한 별 체크

  List<Widget> get _pageOption {
    return _userAuth == 'user'
        ? [
            CampHomeScreen(),
            Search(),
            massage(),
            profile(),
            CampFavoritesScreen(),
          ]
        : [];
  }

  @override
  Widget build(BuildContext context) {
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
