import 'dart:convert';

import 'package:campon_app/store/storemain.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:campon_app/example/Utils/customwidget%20.dart';
import 'package:campon_app/example/Utils/dark_lightmode.dart';
import 'package:http/http.dart' as http;

class JoinUser extends StatefulWidget {
  final String role;
  const JoinUser({super.key, required this.role});

  @override
  State<JoinUser> createState() => _JoinUserState();
}

class _JoinUserState extends State<JoinUser> {
  late ColorNotifire notifire;

  //입력 컨트롤러
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _userTelController = TextEditingController();
  final TextEditingController _userAddressController = TextEditingController();
  final TextEditingController _userPwController = TextEditingController();
  final TextEditingController _userPwCheckController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _companyNumberController =
      TextEditingController();
  // final _role = 'ROLE_USER';
  final _formKey = GlobalKey<FormState>();

  //이미 있는 아이디들
  List<dynamic> idList = [];

  //아이디 중복 검사 함수
  Future<void> idConfirm() async {
    try {
      var response =
          await http.get(Uri.parse('http://10.0.2.2:8081/api/user/join'));
      var utf8Decoded = utf8.decode(response.bodyBytes);
      var result = json.decode(utf8Decoded);
      print(
          'result는? ${result}'); // [admin, user, seller, test, dd, aa, 아이디, 아이디, 아이디, chuyj15, chuyj15, chuyj15, chuyj15, chuyj151, chuyj151, chuyj151, chuyj151]
      setState(() {
        idList = result;
      });
    } catch (e) {
      print('idConfirm함수 실행시 오류, ${e}');
    }
  }

  //회원가입 버튼 클릭 시 실행되는 함수
  Future<void> join(
      userId, userName, userEmail, userTel, userAddress, userPw,companyName,  companyNumber) async {
    Map<String, dynamic> body = {
      "userId": userId,
      "userName": userName,
      "userEmail": userEmail,
      "userTel": userTel,
      "userAddress": userAddress,
      "userPw": userPw,
      "companyName": (widget.role =="ROLE_SELL") ? companyName : '',
      "companyNumber": (widget.role =="ROLE_SELL") ?  companyNumber : '0',
      "auth": widget.role,
    };

    try {
      var response = await http.post(
          Uri.parse('http://10.0.2.2:8081/api/user/join'),
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'});
      // var utf8Decoded = utf8.decode(response.bodyBytes);
      // var result = json.decode(utf8Decoded);
      // var result = json.decode(response.body);
      var result = response.body;
      print("result는 ? ${result}");
      if (result == "SUCCESS") {
        print('회원가입 성공');
      } else {
        print('회원가입 실패');
      }
    } catch (e) {
      print('서버측에 회원가입 정보 전달 실패, ${e}');
    }
  }

  @override
  void initState() {
    super.initState();
    idConfirm();
    print('widget.role은? ${widget.role}');
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        backgroundColor: notifire.getbgcolor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      print('닫기 버튼 클릭');
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.red), // 배경색 설정
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10.0), // 모서리 radius 조절
                        ),
                      ),
                    ),
                    child: Text(
                      "닫기",
                      style: TextStyle(
                          fontSize: 15,
                          color: notifire.getwhiteblackcolor,
                          fontFamily: "Gilroy Bold"),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              Text(
                "회원정보를 입력해주세요.",
                style: TextStyle(
                    fontSize: 24,
                    color: notifire.getwhiteblackcolor,
                    fontFamily: "Gilroy Bold"),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(children: [
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
                            labelText: '아이디는 영문과 숫자 조합만 가능'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '아이디를 입력하세요';
                          }
                          if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
                            return '아이디는 영문과 숫자 조합만 가능합니다';
                          }
                          for (var i = 0; i < idList.length; i++) {
                            if (idList[i] == value) {
                              return '아이디 중복입니다. 다른 아이디를 입력하세요';
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Container(
                      height: 50,
                      child: TextFormField(
                        controller: _userNameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                            icon: Icon(
                              Icons.face,
                            ),
                            errorStyle: TextStyle(fontSize: 13),
                            labelText: '이름'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '이름을 입력하세요';
                          }
                          if (!RegExp(r'^[가-힣]{1,5}$').hasMatch(value)) {
                            return '이름은 1자에서 5자까지의 한글로 입력해주세요.';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    //이메일
                    Container(
                      height: 50,
                      child: TextFormField(
                        controller: _userEmailController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                            icon: Icon(
                              Icons.mail,
                            ),
                            labelText: '이메일'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '이메일을 입력하세요';
                          }
                          if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$')
                              .hasMatch(value)) {
                            return '올바른 이메일 주소를 입력해주세요.';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    //핸드폰번호
                    Container(
                      height: 50,
                      child: TextFormField(
                        controller: _userTelController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                            icon: Icon(
                              Icons.phone_iphone,
                            ),
                            labelText: '핸드폰번호'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '핸드폰번호를 입력하세요';
                          }
                          if (!RegExp(r'^01[016789]\d{7,8}$').hasMatch(value)) {
                            return '핸드폰 번호는 01012341234 형식으로 입력해주세요.';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    //주소
                    Container(
                      height: 50,
                      child: TextFormField(
                        controller: _userAddressController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                            icon: Icon(
                              Icons.home,
                            ),
                            labelText: '주소'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '주소를 입력하세요';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
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
                          if (value.length < 8 ||
                              !RegExp(r'^(?=.*[0-9])(?=.*[a-zA-Z])')
                                  .hasMatch(value)) {
                            return '비밀번호는 8자 이상이어야 하며, 숫자와 영문자를 포함해야 합니다.';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    //비밀번호 확인
                    Container(
                      height: 50,
                      child: TextFormField(
                        obscureText: true,
                        controller: _userPwCheckController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                            icon: Image.asset(
                              "assets/images/password.png",
                              height: 25,
                              color: Colors.black,
                            ),
                            labelText: '비밀번호 확인'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '비밀번호 입력하세요';
                          }
                          if (_userPwController.text != value) {
                            return '비밀번호가 일치하지 않습니다';
                          }
                          return null;
                        },
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                    (widget.role == "ROLE_SELL")
                        ? Column(
                            children: [
                              Text(
                                "기업정보를 입력해주세요.",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: notifire.getwhiteblackcolor,
                                    fontFamily: "Gilroy Bold"),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.01),

                              //ROLE_SELL 일 때
                              //업체명
                              Container(
                                height: 50,
                                child: TextFormField(
                                  controller: _companyNameController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      fillColor: Colors.white,
                                      filled: true,
                                      icon: Icon(
                                        Icons.apartment,
                                      ),
                                      labelText: '업체명'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '업체명을 입력하세요';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.02),

                              //회사 사업자 번호
                              Container(
                                height: 50,
                                child: TextFormField(
                                  controller: _companyNumberController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      fillColor: Colors.white,
                                      filled: true,
                                      icon: Icon(
                                        Icons.apartment,
                                      ),
                                      labelText: '사업자 번호'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '사업자 번호를 입력하세요';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.02),
                            ],
                          )
                        : Text(""),

                    AppButton(
                        buttontext: "회원가입",
                        onclick: () {
                          print('회원가입 버튼 클릭');
                          if (_formKey.currentState!.validate()) {
                            //유효성 검사 통과
                            // 데이터 요청
                            print('아이디 : ${_userIdController.text}');
                            print('이름 : ${_userNameController.text}');
                            print('이메일 : ${_userEmailController.text}');
                            print('핸드폰 번호 : ${_userTelController.text}');
                            print('주소 : ${_userAddressController.text}');
                            print('비밀번호 : ${_userPwController.text}');
                            print('비밀번호 확인 : ${_userPwCheckController.text}');
                            // if (widget.role == "ROLE_SELL") {
                              print('업체명 : ${_companyNameController.text}');
                              print('사업자번호 : ${_companyNumberController.text}');
                            // }
                            join(
                                _userIdController.text,
                                _userNameController.text,
                                _userEmailController.text,
                                _userTelController.text,
                                _userAddressController.text,
                                _userPwController.text,
                                _companyNameController.text,
                                _companyNumberController.text,
                                );
                          }
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => const homepage()));

                          Navigator.pushReplacement(context, MaterialPageRoute(
                            //TODO 경로수정
                            builder : (context)=>StoreMain()
                          ));
                        }),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
