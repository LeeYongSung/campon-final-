import 'package:campon_app/common/footer_screen.dart';
import 'package:campon_app/provider/user_provider.dart';
import 'package:campon_app/store/storeheader.dart';
import 'package:campon_app/store/storemain.dart';
import 'package:campon_app/user/join_intro.dart';
import 'package:flutter/material.dart';
import 'package:campon_app/example/Utils/dark_lightmode.dart';
import 'package:provider/provider.dart';
import 'package:campon_app/example/Utils/customwidget%20.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late ColorNotifire notifire;
//컨트롤러
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _userPwController = TextEditingController();

  //아이디 저장, 자동로그인
  bool isChecked = false;
  bool isChecked1 = false;

  //로그인 함수
  // Future<void> login (username, password) async {
  Future<void> login(UserProvider userProvider) async {
    try {
      String username = _userIdController.text;
      String password = _userPwController.text;
      // 로그인 요청
      await userProvider.login(username, password);

      if (userProvider.isLogin) {
        print('로그인 여부 : ${userProvider.isLogin}');
        await userProvider.getUserInfo();
        print('유저정보 저장 완료...');
        print(userProvider.userInfo);
        print('로그인 성공');
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const StoreMain()));
      }
      // 로그인 요청
      // var response = await http.post(Uri.parse('http://10.0.2.2:8081/login?username=${username}&password=${password}'));
      // if (response.statusCode == 200 ){
      //   print('로그인 성공');
      //    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const StoreMain()));
      // } else {
      //   print('로그인 실패');
      //   showLoginFailedDialog();
      // }
    } catch (e) {
      print('로그인 시도 중 서버와의 연결 오류 ${e}');
    }
  }

  // 로그인 실패 시 알림 다이얼로그 표시
  void showLoginFailedDialog() {
    //showDialog 메서드
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('로그인 실패'),
          content: Text('아이디 혹은 비밀번호가 일치하지 않습니다.'),
          actions: [
            TextButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

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
                child: Form(
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        child: TextFormField(
                          controller: _userIdController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              fillColor: Colors.white,
                              filled: true,
                              icon: Icon(
                                Icons.alternate_email,
                              ),
                              errorStyle: TextStyle(fontSize: 10),
                              labelText: '아이디'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '아이디를 입력하세요';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),

                      //비밀번호
                      Container(
                        height: 50,
                        child: TextFormField(
                          obscureText: true,
                          controller: _userPwController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              fillColor: Colors.white,
                              filled: true,
                              icon: Image.asset("assets/images/password.png",
                                  height: 25, color: Colors.black),
                              labelText: '비밀번호'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '비밀번호 입력하세요';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
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
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      value: isChecked,
                                      fillColor:
                                          MaterialStateProperty.all<Color>(
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
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      value: isChecked1,
                                      fillColor:
                                          MaterialStateProperty.all<Color>(
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

                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),

                      //로그인 버튼
                      AppButton(
                          buttontext: "로그인",
                          onclick: () {
                            print('로그인 버튼 클릭');
                            print('아이디저장여부 : ${isChecked}');
                            print('자동로그인여부 : ${isChecked1}');
                            //로그인 함수
                            login(userProvider);
                            // login(_userIdController.text, _userPwController.text);
                          }),

                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      //회원가입 버튼
                      AppButton(
                          buttontext: "회원가입하기",
                          onclick: () {
                            print('회원가입 버튼 클릭');
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const JoinIntro()));
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
