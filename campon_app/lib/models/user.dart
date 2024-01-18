class Users{
    int? userNo;
    String? userId; 
    String? userPw; 
    String? userPwCheck;
    String? userName; 
    String? userTel;
    String? userEmail;
    String? userAddress;

    String? companyName;
    int? companyNumber;

    DateTime? regDate;
    DateTime? updDate;

    String? auth;

  Users({
      this.userNo,
      this.userId,
      this.userPw,
      this.userPwCheck,
      this.userName,
      this.userTel,
      this.userEmail,
      this.userAddress,
      this.companyName,
      this.companyNumber,
      this.regDate,
      this.updDate,
      this.auth,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      userNo: json['userNo'],
      userId: json['userId'],
      userPw: json['userPw'],
      userPwCheck: json['userPwCheck'],
      userName: json['userName'],
      userTel: json['userTel'],
      userEmail: json['userEmail'],
      userAddress: json['userAddress'],
      companyName: json['companyName'],
      companyNumber: json['companyNumber'],
      regDate: parseDateTime(json['regDate']),
      updDate: parseDateTime(json['updDate']),
      auth: json['auth'],      
    );
  }

}

  DateTime? parseDateTime(String? dateString) {
    if (dateString == null) {
      return null;
    }
    return DateTime.parse(dateString);
  }