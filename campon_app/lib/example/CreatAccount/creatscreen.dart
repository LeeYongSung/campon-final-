// ignore_for_file: camel_case_types

import 'package:campon_app/example/Utils/Colors.dart';
import 'package:campon_app/example/Utils/customwidget%20.dart';
import 'package:campon_app/example/CreatAccount/login.dart';
import 'package:campon_app/example/CreatAccount/verifyaccount.dart';
import 'package:campon_app/example/Utils/dark_lightmode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class creatscreen extends StatefulWidget {
  const creatscreen({super.key});

  @override
  State<creatscreen> createState() => _creatscreenState();
}

class _creatscreenState extends State<creatscreen> {
  bool isvisibal = false;
  @override
  void initState() {
    getdarkmodepreviousstate();
    super.initState();
  }

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
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome to GoHotel",
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: "Gilroy Bold",
                        color: notifire.getwhiteblackcolor),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Let’s create your account first",
                      style: TextStyle(
                          fontSize: 14,
                          color: notifire.getgreycolor,
                          fontFamily: "Gilroy Medium")),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Text("Full Name",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Gilroy Medium",
                          color: notifire.getwhiteblackcolor)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  textfield(
                      feildcolor: notifire.getdarkmodecolor,
                      hintcolor: notifire.getgreycolor,
                      text: 'Enter your username',
                      prefix: Image.asset(
                        "assets/images/profile.png",
                        height: 25,
                        color: notifire.getgreycolor,
                      ),
                      suffix: null),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                  Text(
                    "Phone Nmuber",
                    style: TextStyle(
                        fontFamily: "Gilroy Medium",
                        fontSize: 16,
                        color: notifire.getwhiteblackcolor),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  textfield(
                      feildcolor: notifire.getdarkmodecolor,
                      hintcolor: notifire.getgreycolor,
                      text: 'Enter your number',
                      prefix: Image.asset(
                        "assets/images/call.png",
                        height: 25,
                        color: notifire.getgreycolor,
                      ),
                      suffix: null),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                  Text("Password",
                      style: TextStyle(
                          fontFamily: "Gilroy Medium",
                          fontSize: 16,
                          color: notifire.getwhiteblackcolor)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  textfield(
                      feildcolor: notifire.getdarkmodecolor,
                      hintcolor: notifire.getgreycolor,
                      text: 'Enter your password',
                      prefix: Image.asset(
                        "assets/images/password.png",
                        height: 25,
                        color: notifire.getgreycolor,
                      ),
                      suffix: InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.visibility_off,
                          color: notifire.getgreycolor,
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 5.5,
              ),
              Column(
                children: [
                  AppButton(
                    onclick: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const verifyaccount()));
                    },
                    buttontext: "Agree and Continue",
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text("Have an account?",
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: "Gilroy Medium",
                            color: notifire.getwhiteblackcolor)),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const loginscreen()));
                      },
                      child: Text("Login",
                          style: TextStyle(
                              fontSize: 15,
                              color: Darkblue,
                              fontFamily: "Gilroy Medium")),
                    )
                  ])
                ],
              )
            ],
          ),
        ),
      ),
    );
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
