// ignore_for_file: non_constant_identifier_names, sized_box_for_whitespace, camel_case_types

import 'package:campon_app/example/Login&ExtraDesign/Calander.dart';
import 'package:campon_app/example/Login&ExtraDesign/homepage.dart';
import 'package:campon_app/example/Profile/MyCupon.dart';
import 'package:campon_app/example/Utils/Colors.dart';
import 'package:campon_app/example/Utils/customwidget%20.dart';
import 'package:campon_app/example/Utils/dark_lightmode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class chackout extends StatefulWidget {
  const chackout({super.key});

  @override
  State<chackout> createState() => _chackoutState();
}

class _chackoutState extends State<chackout> {
  int _counter = 0;
  int _counter1 = 0;
  int _counter2 = 0;

  bool isChecked = false;
  bool isChecked1 = false;
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
              centertext: "Checkout",
              ActionIcon: Icons.more_vert,
              bgcolor: notifire.getbgcolor,
              actioniconcolor: notifire.getwhiteblackcolor,
              leadingiconcolor: notifire.getwhiteblackcolor,
              titlecolor: notifire.getwhiteblackcolor)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: notifire.getdarkmodecolor,
                ),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      height: 75,
                      width: 75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: notifire.getdarkmodecolor,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child:
                            Image.asset("assets/images/Confidiantehotel.png"),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Diamond Heart Hotel",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Gilroy Bold",
                              color: notifire.getwhiteblackcolor),
                        ),
                        // const SizedBox(height: 6),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.006),
                        Text(
                          "Purwokerto, Karang Lewas",
                          style: TextStyle(
                              fontSize: 13,
                              color: notifire.getgreycolor,
                              fontFamily: "Gilroy Medium"),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Row(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "\$46 /",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: notifire.getdarkbluecolor,
                                      fontFamily: "Gilroy Bold"),
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  "Night",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: notifire.getgreycolor,
                                      fontFamily: "Gilroy Medium"),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 12,
                                ),
                                Image.asset(
                                  "assets/images/star.png",
                                  height: 20,
                                ),
                                const SizedBox(width: 2),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Row(
                                    children: [
                                      Text(
                                        "4.6",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: notifire.getdarkbluecolor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "(142 Reviews)",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: notifire.getgreycolor),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              selectdetail(
                heding: "Dates",
                image: "assets/images/calendar.png",
                text: "Select Dates",
                icon: Icons.keyboard_arrow_down,
                onclick: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Calander(),
                  ));
                },
              ),
              const SizedBox(height: 10),
              selectdetail(
                  heding: "Guests",
                  image: "assets/images/guest.png",
                  text: "Select Guest",
                  icon: Icons.keyboard_arrow_down,
                  onclick: guestbottomsheet),
              const SizedBox(height: 10),
              selectdetail(
                  heding: "Promo",
                  image: "assets/images/promo.png",
                  text: "Promo Used",
                  icon: Icons.keyboard_arrow_right,
                  onclick: promomodelbottomsheet),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              Divider(
                color: notifire.getgreycolor,
                thickness: 1,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Payment Details",
                      style: TextStyle(
                          fontSize: 16,
                          color: notifire.getwhiteblackcolor,
                          fontFamily: "Gilroy Bold")),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$46 x 3 Nights",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Gilroy Medium",
                            color: notifire.getgreycolor),
                      ),
                      Text(
                        "\$138",
                        style: TextStyle(
                            fontSize: 14,
                            color: notifire.getgreycolor,
                            fontFamily: "Gilroy Medium"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Cleaning Fee",
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Gilroy Medium",
                              color: notifire.getgreycolor)),
                      Text("\$4",
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Gilroy Medium",
                              color: notifire.getgreycolor)),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total (USD)",
                          style: TextStyle(
                              fontFamily: "Gilroy Bold",
                              color: notifire.getwhiteblackcolor)),
                      Text("\$142",
                          style: TextStyle(
                              fontFamily: "Gilroy Bold",
                              color: notifire.getwhiteblackcolor)),
                    ],
                  ),
                  const SizedBox(height: 40),
                  InkWell(
                    onTap: paymentmodelbottomsheet,
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Darkblue),
                      child: Center(
                        child: Text("Select Payment",
                            style: TextStyle(
                                fontSize: 16,
                                color: WhiteColor,
                                fontFamily: "Gilroy Bold")),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget selectdetail({heding, image, text, icon, onclick}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(heding!,
            style: TextStyle(
                fontSize: 16,
                color: notifire.getwhiteblackcolor,
                fontFamily: "Gilroy Bold")),
        const SizedBox(height: 8),
        InkWell(
          onTap: onclick,
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: notifire.getdarkmodecolor),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        image,
                        height: 25,
                        color: notifire.getdarkbluecolor,
                      ),
                      const SizedBox(width: 15),
                      Text(
                        text,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Gilroy Medium",
                            color: notifire.getwhiteblackcolor),
                      ),
                    ],
                  ),
                  Icon(icon, color: notifire.getgreycolor)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  guestbottomsheet() {
    return showModalBottomSheet(
        backgroundColor: notifire.getbgcolor,
        isScrollControlled: true,
        context: context,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.60,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Room and Guests",
                          style: TextStyle(
                              fontFamily: "Gilroy Bold",
                              fontSize: 18,
                              color: notifire.getwhiteblackcolor),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.close,
                              color: notifire.getwhiteblackcolor,
                            ))
                      ],
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025),
                    Room(
                        text: "Room",
                        titletext: "Minimum contains 4 people",
                        onclick1: () {
                          setState(() {
                            _counter--;
                          });
                        },
                        middeltext: "$_counter",
                        onclick2: () {
                          setState(() {
                            _counter++;
                          });
                        }),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025),
                    Room(
                        text: "Adults",
                        titletext: "Age 15+",
                        onclick1: () {
                          setState(() {
                            _counter1--;
                          });
                        },
                        middeltext: "$_counter1",
                        onclick2: () {
                          setState(() {
                            _counter1++;
                          });
                        }),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025),
                    Room(
                        text: "Childern",
                        titletext: "Age 2 - 12",
                        onclick1: () {
                          setState(() {
                            _counter2--;
                          });
                        },
                        middeltext: "$_counter2",
                        onclick2: () {
                          setState(() {
                            _counter2++;
                          });
                        }),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.085,
                    ),
                    AppButton(
                        buttontext: "Save",
                        onclick: () {
                          Navigator.pop(context);
                        })
                  ],
                ),
              ),
            );
          });
        });
  }

  Room({text, titletext, onclick1, onclick2, middeltext}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text,
                style: TextStyle(
                    fontSize: 16,
                    color: notifire.getwhiteblackcolor,
                    fontFamily: "Gilroy Bold")),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  InkWell(
                    onTap: onclick1,
                    child: CircleAvatar(
                      backgroundColor: notifire.getblackgreycolor,
                      radius: 12,
                      child: Icon(Icons.remove,
                          color: notifire.getdarkwhitecolor, size: 20),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    middeltext,
                    style: TextStyle(color: notifire.getwhiteblackcolor),
                  ),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: onclick2,
                    child: CircleAvatar(
                      backgroundColor: notifire.getdarkbluecolor,
                      radius: 12,
                      child: Icon(Icons.add,
                          color: notifire.getdarkwhitecolor, size: 20),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        Text(
          titletext,
          style: TextStyle(
              fontSize: 14,
              color: notifire.getgreycolor,
              fontFamily: "Gilroy Medium"),
        ),
      ],
    );
  }

  promomodelbottomsheet() {
    return showModalBottomSheet(
        backgroundColor: notifire.getbgcolor,
        context: context,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "My Cupon",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "Gilroy Bold",
                                  color: notifire.getwhiteblackcolor),
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Icon(
                                  Icons.close,
                                  color: notifire.getwhiteblackcolor,
                                ))
                          ],
                        ),
                        const SizedBox(height: 20),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: 10,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 8),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const MyCupon()));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(top: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: notifire.getdarkmodecolor,
                                    ),
                                    height: 80,
                                    child: ListTile(
                                      leading: Image.asset(
                                          "assets/images/promo.png",
                                          height: 35),
                                      title: Text(
                                        '50% Cashback',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Gilroy Bold",
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
                                                  color:
                                                      notifire.getdarkbluecolor,
                                                  fontFamily: "Gilroy Medium")),
                                        ],
                                      ),
                                      trailing: Icon(
                                        Icons.check_outlined,
                                        color: notifire.getdarkbluecolor,
                                      ),
                                      isThreeLine: true,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    // left: 100,
                    top: MediaQuery.of(context).size.height / 2.33,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const MyCupon()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Darkblue,
                        ),
                        height: 60,
                        width: MediaQuery.of(context).size.width * 0.93,
                        child: Center(
                            child: Text(
                          "Use Cupon",
                          style: TextStyle(
                              fontSize: 16,
                              color: WhiteColor,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }

  paymentmodelbottomsheet() {
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: notifire.getbgcolor,
        context: context,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.65,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Payment Method",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "Gilroy Bold",
                                  color: notifire.getwhiteblackcolor),
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Icon(
                                  Icons.close,
                                  color: notifire.getwhiteblackcolor,
                                ))
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: notifire.getdarkmodecolor),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/images/mastercard.png",
                                  height: 25,
                                ),
                                const SizedBox(width: 25),
                                Text(
                                  "Master Card",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: "Gilroy Bold",
                                      color: notifire.getwhiteblackcolor),
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width /
                                        2.82),
                                Theme(
                                  data: ThemeData(
                                      unselectedWidgetColor:
                                          notifire.getdarkwhitecolor),
                                  child: Checkbox(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    value: isChecked,
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
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03),
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: notifire.getdarkmodecolor),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/images/Visa.png",
                                  height: 25,
                                ),
                                const SizedBox(width: 27),
                                Text(
                                  "Visa",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: "Gilroy Bold",
                                      color: notifire.getwhiteblackcolor),
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width /
                                        1.98),
                                Theme(
                                  data: ThemeData(
                                      unselectedWidgetColor:
                                          notifire.getdarkwhitecolor),
                                  child: Checkbox(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    value: isChecked1,
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
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03),
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: notifire.getdarkmodecolor),
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: notifire.getgreycolor),
                                child: Center(
                                  child: CircleAvatar(
                                      backgroundColor:
                                          notifire.getdarkbluecolor,
                                      radius: 14,
                                      child: Image.asset(
                                          "assets/images/add.png",
                                          height: 25)),
                                ),
                              ),
                              const SizedBox(width: 33),
                              Text("Add Debit Card",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: "Gilroy Bold",
                                      color: notifire.getwhiteblackcolor)),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.12),
                        AppButton(
                            buttontext: "Confirm and Pay",
                            onclick: BookingSuccessfull)
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  BookingSuccessfull() {
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: notifire.getbgcolor,
        context: context,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.60,
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Positioned(
                        top: 20,
                        child: CircleAvatar(
                          radius: 70,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(200),
                            child: Image.asset(
                                'assets/images/BookingSuccessfull.png'),
                          ),
                        ),
                      ),
                      Positioned(
                        top: -28,
                        right: 50,
                        child: Image.asset(
                          'assets/images/Success.png',
                          height: 160,
                        ),
                      ),
                      Positioned(
                        bottom: 100,
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                "Booking Successfull",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "Gilroy Bold",
                                    color: notifire.getwhiteblackcolor),
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 1,
                              child: Text(
                                "Congratulations! Please check in on the appropriate date. Enjoy your trip!",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: notifire.getgreycolor,
                                    fontFamily: "Gilroy Medium"),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          selectedIndex = 0;
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const homepage()));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 300, left: 20, right: 20),
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Darkblue,
                          ),
                          child: Center(
                              child: Text("Close",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: WhiteColor,
                                      fontFamily: "Gilroy Bold"))),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          });
        });
  }

  // PaymentCard(
  //     {Function(bool?)? OnChage, String? image, CardName, bool? check}) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children: [
  //           Image.asset(
  //             image!,
  //             height: 25,
  //           ),
  //           Text(
  //             CardName,
  //             style: TextStyle(fontSize: 15, fontFamily: "Gilroy Bold"),
  //           ),
  //         ],
  //       ),
  //       SizedBox(width: 25),

  //       // SizedBox(width: MediaQuery.of(context).size.width / 2.61),
  //       Row(
  //         children: [
  //           Checkbox(
  //               shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(5)),
  //               value: check,
  //               activeColor: Darkblue,
  //               onChanged: OnChage!),
  //         ],
  //       ),
  //     ],
  //   );
  // }
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
