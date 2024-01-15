// import 'package:campon_app/example/ramatnupage.dart';
// ignore_for_file: camel_case_types

import 'package:campon_app/example/Utils/Colors.dart';
import 'package:campon_app/example/Utils/dark_lightmode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:table_calendar/table_calendar.dart';

class selectdate extends StatefulWidget {
  const selectdate({super.key});

  @override
  State<selectdate> createState() => _selectdateState();
}

class _selectdateState extends State<selectdate> {
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
      body: CalendarDatePicker(
          initialDate: DateTime.now(),
          onDateChanged: (DateTime value) {},
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(3167)),
      appBar: AppBar(
        leading: BackButton(
          color: BlackColor,
        ),
        actions: [
          Container(
              margin: const EdgeInsets.only(right: 14),
              child: Icon(
                Icons.more_vert,
                color: BlackColor,
              )),
        ],
        elevation: 0,
        backgroundColor: bgcolor,
        title: Text(
          "Select Dates",
          style: TextStyle(fontSize: 20, color: BlackColor),
        ),
        centerTitle: true,
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

// import 'package:flutter/material.dart';
//
// class selectdate extends StatefulWidget {
//   const selectdate({Key? key}) : super(key: key);
//
//   @override
//   State<selectdate> createState() => _selectdateState();
// }
//
// class _selectdateState extends State<selectdate> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//               height: 150,
//               // margin: EdgeInsets.only(top: 10),
//               width: double.infinity,
//               decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30),), color: Colors.cyanAccent,),
//             child: Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Icon(Icons.chat,size: 30,color: BlackColor),
//                       Text("KATHIRIYA YAGNIK RAJESHBHAI",style: TextStyle(fontSize:16,color: BlackColor )),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Stack(
//             children: [
//               Positioned(
//                 child: Container(
//                 height: 180,
//                 width: 140,
//                 color: Colors.amber,
//               ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

