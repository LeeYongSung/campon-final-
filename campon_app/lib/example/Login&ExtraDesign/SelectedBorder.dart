// ignore_for_file: file_names

import 'package:campon_app/example/Utils/Colors.dart';
import 'package:campon_app/example/Utils/dark_lightmode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectBorder extends StatefulWidget {
  const SelectBorder({super.key});

  @override
  State<SelectBorder> createState() => _SelectBorderState();
}

class _SelectBorderState extends State<SelectBorder> {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 80),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "My Cupon",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.close)
                    ],
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: 8,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          const SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: WhiteColor,
                            ),
                            height: 70,
                            child: ListTile(
                              leading: Image.asset("assets/images/promo.png",
                                  height: 35),
                              title: const Text('50% Cashback'),
                              subtitle: Row(
                                children: [
                                  Text(
                                    "Expired in 2 days",
                                    style: TextStyle(
                                        fontSize: 14, color: greyColor),
                                  ),
                                  const SizedBox(width: 4),
                                  Text("See Detail",
                                      style: TextStyle(
                                          fontSize: 15, color: Darkblue)),
                                ],
                              ),
                              trailing: Icon(
                                Icons.check_outlined,
                                color: Darkblue,
                              ),
                              isThreeLine: true,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              Positioned(
                // left: 100,
                top: 250,
                child: Container(
                  height: 50,
                  width: 500,
                  color: Colors.amber,
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 170, vertical: 18),
                    child: Text("data"),
                  ),
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
