import 'package:flutter/material.dart';

class FooterScreen extends StatelessWidget {
  const FooterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/images/logo1.png',
                  width: 100,
                  height: 50,
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 30.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                GestureDetector(
                  child: Text(
                    '회사소개',
                    style: TextStyle(fontSize: 12.0),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                GestureDetector(
                  child: Text(
                    '이용약관',
                    style: TextStyle(fontSize: 12.0),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                GestureDetector(
                  child: Text(
                    '개인정보처리방침',
                    style: TextStyle(fontSize: 12.0),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                GestureDetector(
                  child: Text(
                    '사업자정보확인',
                    style: TextStyle(fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 30.0,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 70.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Image.asset(
                    'images/SNS/Instagram.png',
                    width: 30,
                    height: 30,
                  ),
                ],
              ),
              Column(
                children: [
                  Image.asset(
                    'images/SNS/Google.png',
                    width: 30,
                    height: 30,
                  ),
                ],
              ),
              Column(
                children: [
                  Image.asset(
                    'images/SNS/TikTok.png',
                    width: 30,
                    height: 30,
                  ),
                ],
              ),
              Column(
                children: [
                  Image.asset(
                    'images/SNS/Vector.png',
                    width: 30,
                    height: 30,
                  ),
                ],
              ),
              Column(
                children: [
                  Image.asset(
                    'images/SNS/YouTube.png',
                    width: 30,
                    height: 30,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 70.0),
          child: Row(
            children: [
              Column(
                children: [
                  SizedBox(
                    width: 120,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('고객센터\n연결하기'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Row(
                      children: [
                        Text(
                          '고객센터 번호 : 032-000-0000',
                          style: TextStyle(fontSize: 9.0),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Row(
                      children: [
                        Text(
                          '고객센터 메일 : campon@campon.com',
                          style: TextStyle(fontSize: 9.0),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Row(
                      children: [
                        Text(
                          '고객센터 문의시간 : 09:00 ~ 18:00',
                          style: TextStyle(fontSize: 9.0),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                '캠프온은 통신판매 중개자로서 통신판매의 당사자가 아니며 당사의 상품 대여 고객지원을 제외한 캠핑장 예약,\n이용 등과 관련한 의무와 책임 등 모든 거래에 대한 책음은 가맹점에게 있습니다.',
                style: TextStyle(fontSize: 9.0),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 30.0,
        ),
        Center(
          child: Text('CampOn corp.'),
        ),
      ],
    );
  }
}
