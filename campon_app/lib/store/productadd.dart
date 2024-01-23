import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductAdd extends StatefulWidget {
  @override
  _ProductAddState createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  final _formKey = GlobalKey<FormState>();
  String? productCategory;
  String? productPrice;
  String? productIntro;
  String? productName;
  List<XFile>? thumbnail = []; // image_picker 0.8.5+3 이상에서 XFile 사용
  List<XFile>? detailedImages = [];
  List<XFile>? productImages = [];

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
                Text('썸네일(여러장)'),
                ElevatedButton(
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    final List<XFile>? pickedFiles =
                        await picker.pickMultiImage();
                    if (pickedFiles != null && pickedFiles.isNotEmpty) {
                      setState(() {
                        thumbnail = pickedFiles;
                      });
                    }
                  },
                  child: Text('이미지 선택'),
                ),
                SizedBox(height: 16),
                // 첨부한 이미지를 보여주는 GridView
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                  ),
                  itemCount: thumbnail?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return Image.file(
                      File(thumbnail![index].path),
                      width: 100,
                      height: 100,
                    );
                  },
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
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    final List<XFile>? pickedFiles =
                        await picker.pickMultiImage();
                    if (pickedFiles != null && pickedFiles.isNotEmpty) {
                      setState(() {
                        detailedImages = pickedFiles;
                      });
                    }
                  },
                  child: Text('이미지 선택'),
                ),
                SizedBox(height: 16),
                // 첨부한 이미지를 보여주는 GridView
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                  ),
                  itemCount: detailedImages?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return Image.file(
                      File(detailedImages![index].path),
                      width: 100,
                      height: 100,
                    );
                  },
                ),
                Text('상품 이미지(여러장)'),
                ElevatedButton(
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    final List<XFile>? pickedFiles =
                        await picker.pickMultiImage();
                    if (pickedFiles != null && pickedFiles.isNotEmpty) {
                      setState(() {
                        productImages = pickedFiles;
                      });
                    }
                  },
                  child: Text('이미지 선택'),
                ),
                SizedBox(height: 16),
                // 첨부한 이미지를 보여주는 GridView
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                  ),
                  itemCount: productImages?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return Image.file(
                      File(productImages![index].path),
                      width: 100,
                      height: 100,
                    );
                  },
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

  Future<List<File>> _pickImages() async {
    List<File> files = [];

    try {
      final picker = ImagePicker();
      int maxImages = 5;
      int selectedImages = 0;

      while (selectedImages < maxImages) {
        final imageFile = await picker.pickImage(source: ImageSource.gallery);
        if (imageFile != null) {
          final file = File(imageFile.path);
          files.add(file);
          selectedImages++;
        } else {
          // 사용자가 이미지 선택을 취소했거나 최대 개수에 도달했을 때
          break;
        }
      }
    } catch (e) {
      // 에러 처리
    }

    return files;
  }
}
