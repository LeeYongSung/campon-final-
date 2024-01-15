// ignore_for_file: camel_case_types

import 'package:campon_app/example/Utils/Colors.dart';
import 'package:campon_app/example/Utils/customwidget%20.dart';
import 'package:campon_app/example/Utils/dark_lightmode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

class newpassword extends StatefulWidget {
  const newpassword({super.key});

  @override
  State<newpassword> createState() => _newpasswordState();
}

class _newpasswordState extends State<newpassword> {
  late ColorNotifire notifire;
  @override
  void initState() {
    getdarkmodepreviousstate();
    super.initState();
  }

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
              Text(
                "Create New Password",
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Gilroy Bold",
                    color: notifire.getwhiteblackcolor),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.016),
              Text("Enter the phone number, we’ll send the code",
                  style: TextStyle(fontSize: 14, color: notifire.getgreycolor)),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text("Password",
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Gilroy Medium",
                      color: notifire.getwhiteblackcolor)),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              textfield(
                feildcolor: notifire.getdarkmodecolor,
                hintcolor: notifire.getgreycolor,
                text: 'New Password',
                prefix: Image.asset(
                  "assets/images/password.png",
                  height: 25,
                ),
                suffix:
                    Icon(Icons.visibility_off, color: notifire.getgreycolor),
              ),
              const SizedBox(height: 20),
              Text("Confirm Password",
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Gilroy Medium",
                      color: notifire.getwhiteblackcolor)),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              textfield(
                feildcolor: notifire.getdarkmodecolor,
                hintcolor: notifire.getgreycolor,
                text: 'Confirm Password',
                prefix: Image.asset(
                  "assets/images/password.png",
                  height: 25,
                ),
                suffix:
                    Icon(Icons.visibility_off, color: notifire.getgreycolor),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 3),
              AppButton(
                buttontext: "Reset Password",
                onclick: bottomsheet,
              ),
            ],
          ),
        ),
      ),
    );
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
                      bottom: MediaQuery.of(context).size.height * 0.13,
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              "Change Password Success",
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
                              "We have update your password. Please remember your password, Thank you!",
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
                                child: Text("login",
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
