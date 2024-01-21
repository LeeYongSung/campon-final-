import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:campon_app/common/footer_screen.dart';

class ProductAdd extends StatefulWidget {
  const ProductAdd({Key? key}) : super(key: key);

  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  final _formKey = GlobalKey<FormState>();

  String? productName;
  late File productThmFile;
  String? productCategory;
  String? productPrice;
  String? productIntro;
  late File productConFile;
  late List<File> productImgs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('렌탈샵 상품 등록'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: '상품 이름'),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return '상품 이름을 입력해주세요.';
                    }
                    return null;
                  },
                  onSaved: (value) => productName = value,
                ),
                SizedBox(height: 16),
                Text('상품 썸네일'),
                ElevatedButton(
                  onPressed: () {
                    _pickImage(ImageSource.gallery).then((file) {
                      if (file != null) {
                        setState(() {
                          productThmFile = file;
                        });
                      }
                    });
                  },
                  child: Text('이미지 선택'),
                ),
                SizedBox(height: 16),
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
                TextFormField(
                  decoration: InputDecoration(labelText: '1일 대여금액'),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return '1일 대여금액을 입력해주세요.';
                    }
                    return null;
                  },
                  onSaved: (value) => productPrice = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: '상품 기본내용'),
                  onSaved: (value) => productIntro = value,
                ),
                Text('상품 상세설명(이미지)'),
                ElevatedButton(
                  onPressed: () {
                    _pickImage(ImageSource.gallery).then((file) {
                      if (file != null) {
                        setState(() {
                          productConFile = file;
                        });
                      }
                    });
                  },
                  child: Text('이미지 선택'),
                ),
                Text('상품 이미지(여러장)'),
                ElevatedButton(
                  onPressed: () {
                    _pickMultipleImages().then((files) {
                      if (files != null) {
                        setState(() {
                          productImgs = files;
                        });
                      }
                    });
                  },
                  child: Text('이미지 선택'),
                ),
                SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text('상품등록'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        // Submit form
                        // 상품 등록 로직 추가
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<File?> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: source);
    if (pickedImage != null) {
      return File(pickedImage.path);
    }
    return null;
  }

  Future<List<File>?> _pickMultipleImages() async {
    final picker = ImagePicker();
    final pickedImages = await picker.getMultiImage();
    if (pickedImages != null) {
      return pickedImages.map((pickedImage) => File(pickedImage.path)).toList();
    }
    return null;
  }
}
