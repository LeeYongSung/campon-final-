import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:campon_app/example/Utils/customwidget%20.dart';
import 'package:campon_app/example/Utils/dark_lightmode.dart';
class JoinUser extends StatefulWidget {
  const JoinUser({super.key});

  @override
  State<JoinUser> createState() => _JoinUserState();
}

class _JoinUserState extends State<JoinUser> {
  late ColorNotifire notifire;


  @override
  Widget build(BuildContext context) {
     notifire = Provider.of<ColorNotifire>(context, listen: true);
    return SafeArea(
      child: 
      Scaffold(
         backgroundColor: notifire.getbgcolor,
        body:   SingleChildScrollView(
        
        child: Column(
          children: [
                SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    print('닫기 버튼 클릭');
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red), // 배경색 설정
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // 모서리 radius 조절
                      ),
                    ),
                  ),
                  child: Text(
                    "닫기",
                    style: TextStyle(
                        fontSize: 15,
                        color: notifire.getwhiteblackcolor,
                        fontFamily: "Gilroy Bold"),
                  ),
                ),
            SizedBox(width: 10,),
              ],
            ),
          ],
        ),
      ),

      ),
    
    );
  }
}
