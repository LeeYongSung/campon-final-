// ignore_for_file: camel_case_types, prefer_final_fields, unused_import, prefer_interpolation_to_compose_strings

import 'dart:async';
import 'package:campon_app/example/Utils/Colors.dart';
import 'package:campon_app/example/Utils/customwidget%20.dart';
import 'package:campon_app/example/CreatAccount/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/dark_lightmode.dart';

class verifyaccount extends StatefulWidget {
  const verifyaccount({super.key});

  @override
  State<verifyaccount> createState() => _verifyaccountState();
}

class _verifyaccountState extends State<verifyaccount> {
  @override
  void initState() {
    startTimer();
    getdarkmodepreviousstate();
    super.initState();
  }

  formatedTime(timeInSecond) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute:$second";
  }

  int _start = 30;

  void startTimer() {}
  late ColorNotifire notifire;

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
        backgroundColor: notifire.getbgcolor,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(75),
            child: CustomAppbar(
                centertext: "",
                ActionIcon: null,
                bgcolor: notifire.getbgcolor,
                actioniconcolor: notifire.getwhiteblackcolor,
                leadingiconcolor: notifire.getwhiteblackcolor)),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Verify Your Account",
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Gilroy Bold",
                    color: notifire.getwhiteblackcolor),
              ),
              const SizedBox(
                height: 10,
              ),
              Text("We’ve send verification code to",
                  style: TextStyle(
                      fontSize: 14,
                      color: notifire.getgreycolor,
                      fontFamily: "Gilroy Medium")),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              Text("Verify Your code",
                  style: TextStyle(
                      fontSize: 17,
                      fontFamily: "Gilroy Medium",
                      color: notifire.getwhiteblackcolor)),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              textfield(
                feildcolor: notifire.getdarkmodecolor,
                hintcolor: notifire.getgreycolor,
                text: 'Verification Code',
                prefix: Image.asset(
                  "assets/images/verification.png",
                  height: 25,
                  color: notifire.getgreycolor,
                ),
                suffix: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    "Resend in  " + formatedTime(_start).toString(),
                    style: TextStyle(
                        color: notifire.getgreycolor,
                        fontFamily: "Gilroy Medium"),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2.15,
              ),
              AppButton(
                buttontext: "Verify Account",
                onclick: bottomsheet,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Didn’t receive the code? ",
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Gilroy Medium",
                        color: notifire.getwhiteblackcolor)),
                InkWell(
                  onTap: () {},
                  child: Text("Resend",
                      style: TextStyle(
                          fontSize: 16,
                          color: Darkblue,
                          fontFamily: "Gilroy Medium")),
                )
              ])
            ]),
          ),
        ));
  }

  bottomsheet() {
    return showModalBottomSheet(
        context: context,
        backgroundColor: notifire.getbgcolor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (BuildContext context) {
          return SizedBox(
            height: 600,
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Positioned(
                      top: 30,
                      child: CircleAvatar(
                        radius: 70,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(200),
                          child: Image.asset('assets/images/Illustration.png'),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 55,
                      top: -18,
                      child: Image.asset(
                        'assets/images/Success.png',
                        height: 160,
                      ),
                    ),
                    Positioned(
                      bottom: MediaQuery.of(context).size.height * 0.16,
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              "Account Created",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "Gilroy Bold",
                                  color: notifire.getwhiteblackcolor),
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.90,
                            child: Text(
                              "Congratulations! your account already created. Enjoy the features",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "Gilroy Medium",
                                  color: notifire.getgreycolor),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const loginscreen()));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.45,
                            left: 20,
                            right: 20),
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Darkblue,
                        ),
                        child: Center(
                            child: GestureDetector(
                                child: Text("Login",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: WhiteColor,
                                        fontFamily: "Gilroy Bold")))),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }

  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifire.setIsDark = false;
    } else {
      notifire.setIsDark = previusstate;
    }
  }
}
