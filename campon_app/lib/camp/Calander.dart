// ignore_for_file: file_names, use_key_in_widget_constructors, unused_field

import 'package:campon_app/camp/reservate.dart';
import 'package:campon_app/example/Login&ExtraDesign/chackout.dart';
import 'package:campon_app/example/Utils/Colors.dart';
import 'package:campon_app/example/Utils/customwidget%20.dart';
import 'package:campon_app/example/Utils/dark_lightmode.dart';
import 'package:campon_app/models/camp.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Calander extends StatefulWidget {
  int? no;
  Calander({required this.no});
  @override
  CalanderState createState() => CalanderState();
}

class CalanderState extends State<Calander> {
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  Camp date = Camp( reservationStart: DateTime.now(), reservationEnd: DateTime.now() );

  /// The method for [DateRangePickerSelectionChanged] callback, which will be
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('yyyy-MM-dd').format(args.value.startDate)} -'
            // ignore: lines_longer_than_80_chars
            ' ${DateFormat('yyyy-MM-dd').format(args.value.endDate ?? args.value.startDate)}';
        // _range에 저장된 시작 날짜와 종료 날짜
        DateTime startDate = args.value.startDate;
        DateTime endDate = args.value.endDate ?? args.value.startDate; // 종료 날짜가 없는 경우 시작 날짜 사용

        print("시작날짜 : $startDate");
        print("끝날짜 : $endDate");
        // 날짜 차이 계산
        Duration difference = endDate.difference(startDate);

        // 차이 일수 출력
        int dayDifference = difference.inDays;
        print("날짜 차이 (일수): $dayDifference");

        date = Camp(
          reservationStart: startDate,
          reservationEnd: endDate,
          reservationDate: dayDifference
        );

      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
        print("일수 : $_rangeCount");
      }
    });
  }

  @override
  void initState() {
    getdarkmodepreviousstate();
    super.initState();
  }

  late ColorNotifire notifire;

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: CustomAppbar(
                    centertext: "Calander",
                    bgcolor: notifire.getbgcolor,
                    actioniconcolor: notifire.getwhiteblackcolor,
                    leadingiconcolor: notifire.getwhiteblackcolor,
                    titlecolor: notifire.getwhiteblackcolor)),
            backgroundColor: notifire.getbgcolor,
            // ignore: sized_box_for_whitespace
            bottomNavigationBar: Container(
              height: 80,
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: 
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Reservate(cpdtNo: widget.no, date: date)));
                        },
                        child: Container(
                          height: 70,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color.fromARGB(255, 241, 158, 64),
                          ),
                          child: Center(
                            child: Text(
                              "선택하기",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: WhiteColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                  )),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                  Stack(
                    children: <Widget>[
                      const Positioned(
                        height: 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                      SfDateRangePicker(
                        rangeTextStyle: TextStyle(color: WhiteColor),
                        toggleDaySelection: true,
                        endRangeSelectionColor: yelloColor,
                        startRangeSelectionColor: yelloColor,
                        monthCellStyle: DateRangePickerMonthCellStyle(
                            blackoutDateTextStyle: TextStyle(color: Darkblue)),
                        backgroundColor: notifire.getbgcolor,
                        onSelectionChanged: _onSelectionChanged,
                        selectionMode: DateRangePickerSelectionMode.range,
                        initialSelectedRange: PickerDateRange(
                            DateTime.now().subtract(const Duration(days: 0)),
                            DateTime.now().add(const Duration(days: 1))),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 2.22),
                ],
              ),
            )));
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
