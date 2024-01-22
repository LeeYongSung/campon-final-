import 'dart:core';

import 'package:http/http.dart';

class Camp {
  int? campNo;
  int? regionNo;
  String? campName;
  String? campAddress;
  String? campTel;
  String? campLocation;
  String? campOpen;
  String? campClose;
  String? campPeriod;
  String? campCaution;
  String? campIntroduction;
  String? campLayout;

  DateTime? regDate;
  DateTime? updDate;

  int? cpdtNo;
  String? cpdtName;
  String? cpdtIntroduction;
  int? cpdtNop;
  String? cpdtSize;
  int? cpdtPrice;
  String? cpdtPriceStr;

  int? campTypeNo;
  String? campTypeName;
  String? campTypeImg;

  int? environmentNo;

  int? environmentTypeNo;
  String? environmentTypeName;

  int? cpiNo;
  String? cpiUrl;
  String? cpdiUrl;

  int? favoritesNo;

  String? startDate;
  String? endDate;

  int? facilitytypeNo;
  String? facilitytypeName;
  String? facilitytypeImg;

  List<String>? facilityTypeNoList;

  int? reservationNo;
  int? reservationNop;
  DateTime? reservationStart;
  DateTime? reservationEnd;
  int? reservationDate;
  int? userNo;
  String? userName;
  String? campPaymentType;
  String? userTel;

  List<MultipartFile>? cpdiFiles;
  List<MultipartFile>? file;
  MultipartFile? layoutFile;

  List<Camp>? detailsList;

  String? keyword;

  DateTime? searchDate;

  List<String>? checkBoxList;

  String? campLatitude;
  String? campLongitude;

  Camp({
      this.campNo,
      this.regionNo,
      this.campName,
      this.campAddress,
      this.campTel,
      this.campLocation,
      this.campOpen,
      this.campClose,
      this.campPeriod,
      this.campCaution,
      this.campIntroduction,
      this.campLayout,
      this.regDate,
      this.updDate,
      this.cpdtNo,
      this.cpdtName,
      this.cpdtIntroduction,
      this.cpdtNop,
      this.cpdtSize,
      this.cpdtPrice,
      this.cpdtPriceStr,
      this.campTypeNo,
      this.campTypeName,
      this.campTypeImg,
      this.environmentNo,
      this.environmentTypeNo,
      this.environmentTypeName,
      this.cpiNo,
      this.cpiUrl,
      this.cpdiUrl,
      this.favoritesNo,
      this.startDate,
      this.endDate,
      this.facilitytypeNo,
      this.facilitytypeName,
      this.facilitytypeImg,
      this.facilityTypeNoList,
      this.reservationNo,
      this.reservationNop,
      this.reservationStart,
      this.reservationEnd,
      this.reservationDate,
      this.userNo,
      this.userName,
      this.campPaymentType,
      this.userTel,
      this.cpdiFiles,
      this.file,
      this.layoutFile,
      this.detailsList,
      this.keyword,
      this.searchDate,
      this.checkBoxList,
      this.campLatitude,
      this.campLongitude,
  });

  factory Camp.fromJson(Map<String, dynamic> json) {
    return Camp(
      campNo: json['campNo'],
      regionNo: json['regionNo'],
      campName: json['campName'],
      campAddress: json['campAddress'],
      campTel: json['campTel'],
      campLocation: json['campLocation'],
      campOpen: json['campOpen'],
      campClose: json['campClose'],
      campPeriod: json['campPeriod'],
      campCaution: json['campCaution'],
      campIntroduction: json['campIntroduction'],
      campLayout: json['campLayout'],
      regDate: parseDateTime(json['regDate']),
      updDate: parseDateTime(json['updDate']),
      cpdtNo: json['cpdtNo'],
      cpdtName: json['cpdtName'],
      cpdtIntroduction: json['cpdtIntroduction'],
      cpdtNop: json['cpdtNop'],
      cpdtSize: json['cpdtSize'],
      cpdtPrice: json['cpdtPrice'],
      cpdtPriceStr: json['cpdtPriceStr'],
      campTypeNo: json['campTypeNo'],
      campTypeName: json['campTypeName'],
      campTypeImg: json['campTypeImg'],
      environmentNo: json['environmentNo'],
      environmentTypeNo: json['environmentTypeNo'],
      environmentTypeName: json['environmentTypeName'],
      cpiNo: json['cpiNo'],
      cpiUrl: json['cpiUrl'],
      cpdiUrl: json['cpdiUrl'],
      favoritesNo: json['favoritesNo'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      facilitytypeNo: json['facilitytypeNo'],
      facilitytypeName: json['facilitytypeName'],
      facilitytypeImg: json['facilitytypeImg'],
      facilityTypeNoList: json['facilityTypeNoList'],
      reservationNo: json['reservationNo'],
      reservationNop: json['reservationNop'],
      reservationStart: parseDateTime(json['reservationStart']),
      reservationEnd: parseDateTime(json['reservationEnd']),
      reservationDate: json['reservationDate'],
      userNo: json['userNo'],
      userName: json['userName'],
      campPaymentType: json['campPaymentType'],
      userTel: json['userTel'],
      cpdiFiles: json['cpdiFiles'],
      file: json['file'],
      layoutFile: json['layoutFile'],
      detailsList: json['detailsList'],
      keyword: json['keyword'],
      searchDate: parseDateTime(json['searchDate']),
      checkBoxList: json['seacheckBoxListrchDate'],
      campLatitude: json['campLatitude'],
      campLongitude: json['campLongitude'],
      
    );
  }

}
  DateTime? parseDateTime(String? dateString) {
    if (dateString == null) {
      return null;
    }
    return DateTime.parse(dateString);
  }