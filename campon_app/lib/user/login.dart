import 'package:campon_app/common/footer_screen.dart';
import 'package:campon_app/store/storeheader.dart';
import 'package:flutter/material.dart';
import 'package:campon_app/example/Utils/dark_lightmode.dart';
import 'package:provider/provider.dart';
import 'package:campon_app/example/Utils/customwidget%20.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late ColorNotifire notifire;

  //아이디 저장, 자동로그인
  bool isChecked = false;
  bool isChecked1 = false;

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(
      context,
      listen: true,
    );
    return SafeArea(
      child: Scaffold(
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
        // actions: [
        //   GestureDetector(
        //     child: Padding(
        //       padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        //       child: Icon(Icons.shopping_cart),
        //     ),
        //     onTap: () {
        //       print('장바구니 클릭.....');
        //       //TODO

        //     },
        //   ),
        // ],
      ),
        backgroundColor: notifire.getbgcolor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(children: [
                Image.asset(
                  'img/product/login_banner.jpg',
                  fit: BoxFit.cover,
                ),
                Positioned(
                    top: 110,
                    left: 80,
                    child: Text(
                      '캠핑온에 오신걸 환영합니다.',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Gilroy Bold",
                        color: Colors.white,
                      ),
                    )),
              ]),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Column(
                  children: [
                    //아이디
                    textfield(
                        feildcolor: notifire.getdarkmodecolor,
                        hintcolor: notifire.getgreycolor,
                        text: '아이디',
                        prefix: Icon(
                          Icons.face,
                          color: notifire.getgreycolor,
                        ),
                        // Image.asset("assets/images/call.png",
                        //     height: 25, color: notifire.getgreycolor),
                        suffix: null),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    //비밀번호
                    textfield(
                        feildcolor: notifire.getdarkmodecolor,
                        hintcolor: notifire.getgreycolor,
                        text: '비밀번호',
                        prefix: Image.asset("assets/images/password.png",
                            height: 25, color: notifire.getgreycolor),
                        suffix: null),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),

//아이디 저장, 자동로그인
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //아이디 저장
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            // color: notifire.getdarkmodecolor
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: Row(
                              children: [
                                Text('아이디 저장'),
                                Theme(
                                  data: ThemeData(
                                      unselectedWidgetColor:
                                          notifire.getdarkwhitecolor),
                                  child: Checkbox(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    value: isChecked,
                                    fillColor: MaterialStateProperty.all<Color>(
                                        Colors.orange),
                                    onChanged: (value) {
                                      setState(() {
                                        isChecked = value!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            // color: notifire.getdarkmodecolor
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: Row(
                              children: [
                                Text('자동 로그인'),
                                Theme(
                                  data: ThemeData(
                                      unselectedWidgetColor:
                                          notifire.getdarkwhitecolor),
                                  child: Checkbox(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    value: isChecked1,
                                    fillColor: MaterialStateProperty.all<Color>(
                                        Colors.orange),
                                    onChanged: (value) {
                                      setState(() {
                                        isChecked1 = value!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                    //로그인 버튼
                    AppButton(
                        buttontext: "로그인",
                        onclick: () {
                          print('로그인 버튼 클릭');
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => const homepage()));
                        }),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    //회원가입 버튼
                    AppButton(
                        buttontext: "회원가입하기",
                        onclick: () {
                          print('회원가입 버튼 클릭');
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => const homepage()));
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
