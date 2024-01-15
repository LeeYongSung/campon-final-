// ignore_for_file: file_names

// ignore: unused_import
import 'package:campon_app/example/Profile/Favourite.dart';
import 'package:campon_app/example/Utils/customwidget%20.dart';
import 'package:campon_app/example/Utils/dark_lightmode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({super.key});

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
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
          "Transaction History",
          style: TextStyle(
              color: notifire.getwhiteblackcolor, fontFamily: "Gilroy Bold"),
        ),
      ),
      backgroundColor: notifire.getbgcolor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("My Bookings",
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
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: notifire.getdarkmodecolor),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("28 Mar 2022, Thu",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: notifire.getgreycolor)),
                                  Container(
                                    height: 40,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.amber[50]),
                                    child: const Center(
                                      child: Text(
                                        "Waiting",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xffFFBA55),
                                            fontFamily: "Gilroy Bold"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/images/Confidiantehotel.png",
                                    height: 75,
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Hyatt Washington Hotel",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color:
                                                  notifire.getwhiteblackcolor,
                                              fontFamily: "Gilroy Bold")),
                                      const SizedBox(height: 6),
                                      Text("4 Guests, 2 Room",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: notifire.getgreycolor,
                                              fontFamily: "Gilroy Medium")),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 8),
                              cupon(
                                text1: "Total Price",
                                text2: "\$274",
                                buttontext: "Check In",
                                onClick: () {
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (context) => Favourite()));
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Text("Past Transaction",
                  style: TextStyle(
                      fontSize: 16,
                      color: notifire.getwhiteblackcolor,
                      fontWeight: FontWeight.bold)),
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("28 Mar 2022, Thu",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: notifire.getgreycolor,
                                          fontFamily: "Gilroy Medium")),
                                  Container(
                                    height: 40,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.green[50]),
                                    child: const Center(
                                      child: Text(
                                        "Finished",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xff13B97D),
                                            fontFamily: "Gilroy Bold"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/images/Rimuru.png",
                                    height: 75,
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Hyatt Washington Hotel",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color:
                                                  notifire.getwhiteblackcolor,
                                              fontFamily: "Gilroy Bold")),
                                      const SizedBox(height: 6),
                                      Text("4 Guests, 2 Room",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: notifire.getgreycolor)),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 8),
                              cupon(
                                text1: "Total Price",
                                text2: "\$274",
                                buttontext: "Ratings",
                                onClick: () {
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (context) => Favourite()));
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
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
