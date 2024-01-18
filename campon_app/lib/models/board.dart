import 'package:http/http.dart';

class Board{
  int? reviewNo;
  int? userNo;
  int? campNo;
  int? reservationNo;
  int? orderNo;
  String? reviewTitle;
  MultipartFile? reviewImgfile;
  String? reviewImg;
  String? reviewCon;
  DateTime? regDate;
  DateTime? updDate;
  int? cpdtNo;

  String? campName;
  String? cpdtName;
  String? userName;
  String? userId;

  int? prNo;
  String? prTitle;
  String? prCon;
  String? prImg;
  MultipartFile? prImgfile;

  int? productNo;
  String? productName;
  String? productCategory;

  DateTime? reservationStart;
  DateTime? reservationEnd;
  DateTime? startDate;
  DateTime? endDate;


  int? page;
  int? start;
  int? end;

  Board({
      this.reviewNo,
      this.userNo,
      this.campNo,
      this.reservationNo,
      this.orderNo,
      this.reviewTitle,
      this.reviewImgfile,
      this.reviewImg,
      this.reviewCon,
      this.regDate,
      this.updDate,
      this.cpdtNo,
      this.campName,
      this.cpdtName,
      this.userName,
      this.userId,
      this.prNo,
      this.prTitle,
      this.prCon,
      this.prImg,
      this.prImgfile,
      this.productNo,
      this.productName,
      this.productCategory,
      this.reservationStart,
      this.reservationEnd,
      this.startDate,
      this.endDate,
      this.page,
      this.start,
      this.end,
  });

    factory Board.fromJson(Map<String, dynamic> json) {
    return Board(
      reviewNo: json['reviewNo'],
      userNo: json['userNo'],
      campNo: json['campNo'],
      reservationNo: json['reservationNo'],
      orderNo: json['orderNo'],
      reviewTitle: json['reviewTitle'],
      reviewImgfile: json['reviewImgfile'],
      reviewImg: json['reviewImg'],
      reviewCon: json['reviewCon'],
      regDate: parseDateTime(json['regDate']),
      updDate: parseDateTime(json['updDate']),
      cpdtNo: json['cpdtNo'],      
      campName: json['campName'],      
      cpdtName: json['cpdtName'],      
      userName: json['userName'],      
      userId: json['userId'],      
      prNo: json['prNo'],      
      prTitle: json['prTitle'],      
      prCon: json['prCon'],      
      prImg: json['prImg'],      
      prImgfile: json['prImgfile'],      
      productNo: json['productNo'],      
      productName: json['productName'],      
      productCategory: json['productCategory'],      
      page: json['page'],      
      start: json['start'],      
      end: json['end'],      
      reservationStart: parseDateTime(json['reservationStart']),
      reservationEnd: parseDateTime(json['reservationEnd']),
      startDate: parseDateTime(json['startDate']),
      endDate: parseDateTime(json['endDate']),
    );
  }

}

  DateTime? parseDateTime(String? dateString) {
    if (dateString == null) {
      return null;
    }
    return DateTime.parse(dateString);
  }