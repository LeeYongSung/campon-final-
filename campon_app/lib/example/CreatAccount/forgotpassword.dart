// ignore_for_file: camel_case_types

import 'package:campon_app/example/CreatAccount/newpassword.dart';
import 'package:campon_app/example/Utils/customwidget%20.dart';
import 'package:campon_app/example/Utils/dark_lightmode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class forgotpassword extends StatefulWidget {
  const forgotpassword({super.key});

  @override
  State<forgotpassword> createState() => _forgotpasswordState();
}

class _forgotpasswordState extends State<forgotpassword> {
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Forgot Password",
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: "Gilroy Bold",
                  color: notifire.getwhiteblackcolor),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.016),
            Text("We’ve send verification code to",
                style: TextStyle(fontSize: 14, color: notifire.getgreycolor)),
          ]),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Text("Phone Number",
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Gilroy Medium",
                  color: notifire.getwhiteblackcolor)),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          textfield(
            feildcolor: notifire.getdarkmodecolor,
            hintcolor: notifire.getgreycolor,
            text: 'Enter your phone number',
            prefix: Image.asset("assets/images/call.png",
                height: 25, color: notifire.getgreycolor),
            suffix: null,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2.2,
          ),
          AppButton(
              buttontext: "Send Code",
              onclick: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const newpassword()));
              })
        ]),
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
