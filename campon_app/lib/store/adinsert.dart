// class AdRegisterPage extends StatefulWidget {
//   @override
//   _AdRegisterPageState createState() => _AdRegisterPageState();
// }

// class _AdRegisterPageState extends State<AdRegisterPage> {
//   // 파일 업로드 관련
//   File _imageFile;
//   final _picker = ImagePicker();

//   // 날짜 선택
//   DateTime _startDate;
//   DateTime _endDate;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("광고등록"),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // 이미지 미리보기
//             _imageFile != null ? Image.file(_imageFile) : Placeholder(),

//             // 이미지 업로드 버튼
//             ElevatedButton(
//               onPressed: () async {
//                 final pickedFile =
//                     await _picker.pickImage(source: ImageSource.gallery);

//                 setState(() {
//                   _imageFile = File(pickedFile.path);
//                 });
//               },
//               child: Text("이미지 업로드"),
//             ),

//             // 날짜 피커
//             TextField(
//               controller: TextEditingController(
//                   text: _startDate != null
//                       ? DateFormat('yyyy-MM-dd').format(_startDate)
//                       : ''),
//               readOnly: true,
//               onTap: () async {
//                 var date = await showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime(1900),
//                   lastDate: DateTime(2100),
//                 );

//                 setState(() {
//                   _startDate = date;
//                 });
//               },
//             ),

//             ElevatedButton(
//               child: Text("광고등록"),
//               onPressed: () {
//                 // API 호출 로직
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
