// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class Ad {
//   final String adImg;
//   final String campNo;
//   final String campName;
//   final DateTime adStart;
//   final DateTime adEnd;
//   final int adCheck;
//   final DateTime regDate;
//   final DateTime updDate;

//   Ad(this.adImg, this.campNo, this.campName, this.adStart, this.adEnd,
//       this.adCheck, this.regDate, this.updDate);
// }

// class AdList extends StatelessWidget {
//   final List<Ad> ads; // 데이터를 담을 List

//   AdList({Key? key, required this.ads}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('광고 리스트'),
//       ),
//       body: ListView.builder(
//         itemCount: ads.length,
//         itemBuilder: (context, index) {
//           return Card(
//             child: Column(
//               children: <Widget>[
//                 Image.network(ads[index].adImg),
//                 ListTile(
//                   title: Text('${ads[index].campNo} / ${ads[index].campName}'),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text('광고기간 : 2021-01-01 ~ 2021-02-30'),
//                       Text('상태 : ${ads[index].adCheck == 0 ? "미승인" : "승인"}'),
//                       Text('등록일자 : 2021-01-01 ~ 2021-02-30'),
//                     ],
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     TextButton(
//                       onPressed: () {
//                         /* 수정 기능 구현 */
//                       },
//                       child: Text('수정'),
//                     ),
//                     if (ads[index].adCheck == 0)
//                       TextButton(
//                         onPressed: () {
//                           /* 승인 기능 구현 */
//                         },
//                         child: Text('승인'),
//                       )
//                   ],
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
