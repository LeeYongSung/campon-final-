import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class ProductUpdate extends StatefulWidget {
  const ProductUpdate({Key? key}) : super(key: key);

  @override
  State<ProductUpdate> createState() => _ProductUpdateState();
}

class _ProductUpdateState extends State<ProductUpdate> {
  final _formKey = GlobalKey<FormState>();

  String? productName;
  File? productThmFile;
  String? productCategory;
  String? productPrice;
  String? productIntro;
  File? productConFile;
  List<File>? productImgs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('렌탈샵 상품 수정/삭제'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 상품 이름
                TextFormField(
                  decoration: InputDecoration(labelText: '상품 이름'),
                  onSaved: (value) => productName = value,
                ),

                // 썸네일 이미지
                Text('상품 썸네일'),
                ElevatedButton(
                  onPressed: () {
                    _pickImage();
                  },
                  child: Text('이미지 선택'),
                ),

                // 카테고리
                Text('카테고리'),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: RadioListTile(
                            title: Text(
                              '텐트',
                              style: TextStyle(fontSize: 14),
                            ),
                            value: '텐트',
                            groupValue: productCategory,
                            onChanged: (value) {
                              setState(() {
                                productCategory = value as String?;
                              });
                            },
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: -10),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: RadioListTile(
                            title: Text(
                              '테이블',
                              style: TextStyle(fontSize: 14),
                            ),
                            value: '테이블',
                            groupValue: productCategory,
                            onChanged: (value) {
                              setState(() {
                                productCategory = value as String?;
                              });
                            },
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: -10),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: RadioListTile(
                            title: Text(
                              '체어',
                              style: TextStyle(fontSize: 14),
                            ),
                            value: '체어',
                            groupValue: productCategory,
                            onChanged: (value) {
                              setState(() {
                                productCategory = value as String?;
                              });
                            },
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: -10),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: RadioListTile(
                            title: Text('매트', style: TextStyle(fontSize: 14)),
                            value: '매트',
                            groupValue: productCategory,
                            onChanged: (value) {
                              setState(() {
                                productCategory = value as String?;
                              });
                            },
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: -10),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: RadioListTile(
                            title: Text('조명', style: TextStyle(fontSize: 14)),
                            value: '조명',
                            groupValue: productCategory,
                            onChanged: (value) {
                              setState(() {
                                productCategory = value as String?;
                              });
                            },
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: -10),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: RadioListTile(
                            title: Text('화로대', style: TextStyle(fontSize: 14)),
                            value: '화로대',
                            groupValue: productCategory,
                            onChanged: (value) {
                              setState(() {
                                productCategory = value as String?;
                              });
                            },
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: -10),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: RadioListTile(
                            title: Text('타프', style: TextStyle(fontSize: 14)),
                            value: '타프',
                            groupValue: productCategory,
                            onChanged: (value) {
                              setState(() {
                                productCategory = value as String?;
                              });
                            },
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: -10),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: RadioListTile(
                            title: Text('수납', style: TextStyle(fontSize: 14)),
                            value: '수납',
                            groupValue: productCategory,
                            onChanged: (value) {
                              setState(() {
                                productCategory = value as String?;
                              });
                            },
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: -10),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: RadioListTile(
                            title: Text('캠핑가전', style: TextStyle(fontSize: 14)),
                            value: '캠핑가전',
                            groupValue: productCategory,
                            onChanged: (value) {
                              setState(() {
                                productCategory = value as String?;
                              });
                            },
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: -10),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: RadioListTile(
                            title: Text('주방용품', style: TextStyle(fontSize: 14)),
                            value: '주방용품',
                            groupValue: productCategory,
                            onChanged: (value) {
                              setState(() {
                                productCategory = value as String?;
                              });
                            },
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: -10),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // 1일 대여금액
                TextFormField(
                  decoration: InputDecoration(labelText: '1일 대여금액'),
                  onSaved: (value) => productPrice = value,
                ),

                // 상품 기본내용
                TextFormField(
                  decoration: InputDecoration(labelText: '상품 기본내용'),
                  onSaved: (value) => productIntro = value,
                ),

                // 상품 상세설명 이미지
                Text('상품 상세설명(이미지)'),
                ElevatedButton(
                  onPressed: () {
                    _pickImage();
                  },
                  child: Text('이미지 선택'),
                ),

                // 상품 이미지 (여러장)
                Text('상품 이미지(여러장)'),
                ElevatedButton(
                  onPressed: () {
                    _pickMultipleImages();
                  },
                  child: Text('이미지 선택'),
                ),

                // 상품 수정 버튼
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        child: Text('상품수정'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 16), // 버튼 사이의 간격 조정을 위한 SizedBox 추가
                    Expanded(
                      child: ElevatedButton(
                        child: Text('상품삭제'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red, // 배경색 빨갛게
                        ),
                        onPressed: () {
                          // 삭제 로직
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<File?> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      return File(pickedImage.path);
    }
    return null;
  }

  Future<List<File>?> _pickMultipleImages() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();
    if (pickedImages != null) {
      return pickedImages.map((image) => File(image.path)).toList();
    }
    return null;
  }
}
