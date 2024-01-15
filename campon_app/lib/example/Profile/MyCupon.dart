// ignore_for_file: file_names

import 'package:campon_app/example/Utils/customwidget%20.dart';
import 'package:campon_app/example/Utils/dark_lightmode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCupon extends StatefulWidget {
  const MyCupon({super.key});

  @override
  State<MyCupon> createState() => _MyCuponState();
}

class _MyCuponState extends State<MyCupon> {
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
          "Cupon",
          style: TextStyle(
              color: notifire.getwhiteblackcolor, fontFamily: "Gilroy Bold"),
        ),
      ),
      backgroundColor: notifire.getbgcolor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("4 Ready to Use",
                  style: TextStyle(
                      fontSize: 16,
                      color: notifire.getwhiteblackcolor,
                      fontFamily: "Gilroy Bold")),
              const SizedBox(height: 10),
              SizedBox(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: notifire.getdarkmodecolor),
                          child: Column(
                            children: [
                              ListTile(
                                leading: Image.asset("assets/images/promo.png",
                                    height: 35),
                                title: Text(
                                  '50% Cashback',
                                  style: TextStyle(
                                      fontFamily: "Gilroy Bold",
                                      fontSize: 16,
                                      color: notifire.getwhiteblackcolor),
                                ),
                                subtitle: Row(
                                  children: [
                                    Text(
                                      "Expired in 2 days",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: notifire.getgreycolor,
                                          fontFamily: "Gilroy Medium"),
                                    ),
                                    const SizedBox(width: 4),
                                    Text("See Detail",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: notifire.getdarkbluecolor,
                                            fontFamily: "Gilroy Medium")),
                                  ],
                                ),
                                isThreeLine: true,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 14),
                                child: cupon(
                                    text1: "Voucher Code",
                                    text2: "48WF093XF",
                                    buttontext: "Use",
                                    onClick: () {
                                      // Navigator.of(context).push(
                                      //     MaterialPageRoute(builder: (context) => Favourite()));
                                    }),
                              )
                            ],
                          ),
                        ));
                  },
                ),
              ),
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
