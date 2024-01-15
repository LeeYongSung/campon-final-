// ignore_for_file: file_names

import 'package:campon_app/example/CreatAccount/newpassword.dart';
import 'package:campon_app/example/Utils/Colors.dart';
import 'package:campon_app/example/Utils/customwidget%20.dart';
import 'package:campon_app/example/Utils/dark_lightmode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
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
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: notifire.getbgcolor,
        leading: BackButton(color: notifire.getwhiteblackcolor),
        title: Text(
          "My Profile",
          style: TextStyle(
              color: notifire.getwhiteblackcolor, fontFamily: "Gilroy Bold"),
        ),
      ),
      backgroundColor: notifire.getbgcolor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 200,
                color: notifire.getbgcolor,
                child: Stack(
                  children: [
                    const Positioned(
                      top: 25,
                      left: 30,
                      child: CircleAvatar(
                        radius: 68,
                        backgroundImage:
                            AssetImage("assets/images/person5.jpg"),
                        // child: Image.asset("assets/images/person1.jpeg"),
                      ),
                    ),
                    Positioned(
                      top: 85,
                      // bottom: 20,
                      right: 20,
                      // left: 20,
                      child: CircleAvatar(
                        radius: 37,
                        backgroundColor: WhiteColor,
                        child: CircleAvatar(
                          radius: 35,
                          child: Image.asset(
                            'assets/images/camera.png',
                            height: 40,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Full Name",
                    style: TextStyle(
                        fontSize: 16,
                        color: notifire.getwhiteblackcolor,
                        fontFamily: "Gilroy Bold"),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  textfield(
                      feildcolor: notifire.getdarkmodecolor,
                      hintcolor: notifire.getgreycolor,
                      text: 'Enter your Name',
                      prefix: Image.asset("assets/images/profile.png",
                          height: 25, color: notifire.getgreycolor),
                      suffix: null),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  Text(
                    "Phone Number",
                    style: TextStyle(
                        fontSize: 16,
                        color: notifire.getwhiteblackcolor,
                        fontFamily: "Gilroy Bold"),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  textfield(
                      feildcolor: notifire.getdarkmodecolor,
                      hintcolor: notifire.getgreycolor,
                      text: 'Enter your Number',
                      prefix: Image.asset(
                        "assets/images/call.png",
                        color: notifire.getgreycolor,
                        height: 25,
                      ),
                      suffix: null),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.22),
              AppButton(
                  buttontext: "Save Changes",
                  onclick: () {
                    // Navigator.of(context)
                    //     .push(MaterialPageRoute(builder: (context) => home()));
                  }),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const newpassword(),
                    ));
                  },
                  child: Text("Change Password?",
                      style: TextStyle(
                          fontSize: 16,
                          color: Darkblue,
                          fontFamily: "Gilroy Bold")),
                ),
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
