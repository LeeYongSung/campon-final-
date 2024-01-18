import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductAdd extends StatefulWidget {
  @override
  _ProductAddState createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  // form key
  final _formKey = GlobalKey<FormState>();

  // values
  late String name;
  late String category;
  late int price;

  File? thumbnail;
  File? detailImage;
  List<File> images = [];

  // image picker
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("상품등록")),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: "상품명"),
              onSaved: (value) => name = value!,
            ),
            RadioListTile(
              title: Text("텐트"),
              value: "텐트",
              groupValue: category,
              onChanged: (value) {
                setState(() {
                  category = value!;
                });
              },
            ),
            RadioListTile(
              title: Text("테이블"),
              value: "테이블",
              groupValue: category,
              onChanged: (value) {
                setState(() {
                  category = value!;
                });
              },
            ),
            RadioListTile(
              title: Text("의자"),
              value: "의자",
              groupValue: category,
              onChanged: (value) {
                setState(() {
                  category = value!;
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "금액"),
              keyboardType: TextInputType.number,
              onSaved: (value) => price = int.parse(value!),
            ),
            // 이미지 관련 UI 및 로직 생략

            ElevatedButton(
              child: Text("등록"),
              onPressed: () {
                _formKey.currentState!.save();
                // 제출 로직
              },
            ),
          ],
        ),
      ),
    );
  }
}
