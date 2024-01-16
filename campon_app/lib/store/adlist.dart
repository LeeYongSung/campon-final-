// class AdListPage extends StatelessWidget {
//   // 광고 리스트 데이터
//   final List<Ad> adList;

//   AdListPage({required this.adList});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("광고 리스트"),
//       ),
//       body: ListView.builder(
//           itemCount: adList.length,
//           itemBuilder: (context, index) {
//             var ad = adList[index];

//             return Card(
//               child: Column(
//                 children: [
//                   Image.network(ad.adImg),
//                   ListTile(
//                     title: Text("${ad.campNo} / ${ad.campName}"),
//                     subtitle: Text(
//                       "광고기간: ${ad.adStart.toString()} ~ ${ad.adEnd.toString()}",
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () {
//                           // 수정 로직
//                         },
//                         child: Text("수정"),
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           // 승인 로직
//                         },
//                         child: Text(
//                           ad.adCheck ? "승인됨" : "승인",
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           }),
//     );
//   }
// }
