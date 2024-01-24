import 'package:campon_app/board/board_main.dart';
import 'package:campon_app/camp/reservation.dart';
import 'package:campon_app/common/footer_screen.dart';
import 'package:campon_app/models/board.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductReviewAdd extends StatefulWidget {
  final int? productNo;
  final int? orderNo;
  final int? userNo;

  const ProductReviewAdd(
      {super.key,
      required this.productNo,
      required this.orderNo,
      required this.userNo});

  @override
  State<ProductReviewAdd> createState() => _ProductReviewAddState();
}

class _ProductReviewAddState extends State<ProductReviewAdd> {
  final picker = ImagePicker();
  XFile? image; // 카메라로 촬영한 이미지를 저장할 변수
  List<XFile?> multiImage = []; // 갤러리에서 여러 장의 사진을 선택해서 저장할 변수
  List<XFile?> images = []; // 가져온 사진들을 보여주기 위한 변수

  String? reviewTitle;

  Board board = Board();

  @override
  void initState() {
    super.initState();
  }

  File? _selectedFile;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _writerController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  Future<void> _pickFile() async {
    print("pickFIle...");
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  Future _reviewInsert() async {
    print(reviewTitle);
    print(images[0]!.path);
    print(_selectedFile!.path);

    int productNo = widget.productNo!;
    int userNo = widget.userNo!;
    int orderNo = widget.orderNo!;

    if (_selectedFile == null) {
      return;
    }
    var url = Uri.parse("http://10.0.2.2:8081/api/board/prinsert");
    var request = http.MultipartRequest('POST', url);

    var filefield =
        await http.MultipartFile.fromPath('prImgfile', _selectedFile!.path);
    request.files.add(filefield);

    request.fields['userNo'] = userNo.toString();
    request.fields['orderNo'] = orderNo.toString();
    request.fields['productNo'] = productNo.toString();
    request.fields['prTitle'] = _titleController.text;
    request.fields['prCon'] = _contentController.text;
    try {
      // 업로드 요청 보내기
      var response = await request.send();

      // 응답 확인
      if (response.statusCode == 201) {
        print('File uploaded successfully');
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Reservation()));
      } else {
        print('File upload failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error uploading file: $error');
    }
    // final response = await http.post(url,
    //     headers: {'Content-Type': 'application/json'},
    //     body: jsonEncode({

    //     }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/images/logo2.png",
          width: 110,
          height: 60,
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 10.0,
          ),
          Column(
            children: [
              Text(
                "상품 리뷰 등록",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20.0, left: 10.0),
                child: Text(
                  "제목",
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    controller: _titleController,
                    decoration: InputDecoration(hintText: "리뷰 제목"),
                    onChanged: (value) {
                      reviewTitle = value;
                      print(reviewTitle);
                    },
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30.0, left: 10.0),
                child: Text(
                  "사진",
                ),
              ),
            ],
          ),
          Row(
            children: [
              //카메라로 촬영하기
              Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.yellow.shade600,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0.5,
                          blurRadius: 5)
                    ],
                  ),
                  child: IconButton(
                      onPressed: () async {
                        image =
                            await picker.pickImage(source: ImageSource.camera);
                        //카메라로 촬영하지 않고 뒤로가기 버튼을 누를 경우, null값이 저장되므로 if문을 통해 null이 아닐 경우에만 images변수로 저장하도록 합니다
                        if (image != null) {
                          setState(() {
                            images.add(image);
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.add_a_photo,
                        size: 30,
                        color: Colors.white,
                      ))),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.yellow.shade600,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0.5,
                        blurRadius: 5)
                  ],
                ),
                child: IconButton(
                  onPressed: () async {
                    _pickFile();
                    multiImage = await picker.pickMultiImage();
                    setState(() {
                      //multiImage를 통해 갤러리에서 가지고 온 사진들은 리스트 변수에 저장되므로 addAll()을 사용해서 images와 multiImage 리스트를 합쳐줍니다.
                      images.addAll(multiImage);
                    });
                  },
                  icon: const Icon(
                    Icons.add_photo_alternate_outlined,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: GridView.builder(
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
              itemCount:
                  images.length, //보여줄 item 개수. images 리스트 변수에 담겨있는 사진 수 만큼.
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, //1 개의 행에 보여줄 사진 개수
                childAspectRatio: 1 / 1, //사진 의 가로 세로의 비율
                mainAxisSpacing: 10, //수평 Padding
                crossAxisSpacing: 10, //수직 Padding
              ),
              itemBuilder: (BuildContext context, int index) {
                // 사진 오른 쪽 위 삭제 버튼을 표시하기 위해 Stack을 사용함
                return Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              fit: BoxFit.cover, //사진 크기를 Container 크기에 맞게 조절
                              image: FileImage(File(images[index]!
                                      .path // images 리스트 변수 안에 있는 사진들을 순서대로 표시함
                                  )))),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      //삭제 버튼
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        icon: Icon(Icons.close, color: Colors.white, size: 15),
                        onPressed: () {
                          //버튼을 누르면 해당 이미지가 삭제됨
                          setState(() {
                            images.remove(images[index]);
                          });
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30.0, left: 10.0, bottom: 10.0),
                child: Text(
                  "내용",
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  height: 300, // 높이를 원하는 값으로 조정하세요.
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blueGrey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextField(
                    controller: _contentController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "리뷰 내용을 입력해주세요."),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "취소",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            minimumSize: Size(double.infinity, 50),
                            backgroundColor: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          _reviewInsert();
                        },
                        child: Text(
                          "등록",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            minimumSize: Size(double.infinity, 50),
                            backgroundColor: Colors.green),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
          Divider(
            color: Colors.grey,
            height: 30,
          ),
          FooterScreen(),
        ],
      ),
    );
  }
}
