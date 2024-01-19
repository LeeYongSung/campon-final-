import 'package:flutter/material.dart';
import 'package:campon_app/example/Utils/dark_lightmode.dart';
import 'package:provider/provider.dart';

class JoinIntro extends StatefulWidget {
  const JoinIntro({super.key});

  @override
  State<JoinIntro> createState() => _JoinIntroState();
}

class _JoinIntroState extends State<JoinIntro> {
  late ColorNotifire notifire;

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(
      context,
      listen: true,
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: notifire.getbgcolor,
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
              child: Icon(Icons.arrow_back_ios),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            GestureDetector(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                child: Icon(Icons.person_2),
              ),
              onTap: () {
                print('마이페이지 클릭.....');
                //TODO
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  "회원가입",
                  style: TextStyle(
                      fontSize: 24,
                      color: notifire.getwhiteblackcolor,
                      fontFamily: "Gilroy Bold"),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Divider(
                  color: notifire.getgreycolor,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "회원유형을 선택해 주세요",
                  style: TextStyle(
                      fontSize: 16,
                      // color: notifire.getlightblackcolor,
                      fontFamily: "Gilroy Medium"),
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    print('일반 회원 클릭');
                  },
                  child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: notifire.getblackwhitecolor,
                        border: Border.all(
                          color: notifire.getgreycolor,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text('일반 회원'),
                      )),
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    print('기업 회원 클릭');
                  },
                  child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: notifire.getblackwhitecolor,
                        border: Border.all(
                          color: notifire.getgreycolor,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text('기업 회원'),
                      )),
                ),

                SizedBox(
                  height: 20,
                ),

                Text('※ 기업 회원의 경우 별도의 승인이 필요하여 원활한 승인을 위해 가입 신청 후 CampOn 이메일로 사업자 등록증을 송부하여 주시기 바랍니다.',
                style: TextStyle(   fontSize: 14,
                      color: notifire.getlightblackcolor,
                      fontFamily: "Gilroy Medium"),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
