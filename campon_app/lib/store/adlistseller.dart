// class AdListSellerPage extends StatelessWidget {
//   // 판매자 광고 리스트
//   final List<Ad> adList;

//   AdListSellerPage({required this.adList});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("내 광고 리스트"),
//       ),
//       body: ListView.builder(
//         itemCount: adList.length,
//         itemBuilder: (context, index) {
//           var ad = adList[index];

//           return Card(
//             child: Column(
//               children: [
//                 Image.network(ad.adImg),
//                 ListTile(
//                   title: Text("${ad.campNo} / ${ad.campName}"),
//                   subtitle: Text(
//                     "광고기간: ${ad.adStart} ~ ${ad.adEnd}",
//                   ),
//                 ),
//                 ButtonBar(
//                   children: [
//                     TextButton(
//                       child: Text("수정"),
//                       onPressed: () {
//                         // 수정 로직
//                       },
//                     )
//                   ],
//                 )
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
