import 'dart:convert';

import 'package:campon_app/models/user.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserProvider extends ChangeNotifier {
  // 로그인 정보
  late Users _userInfo;
  // 로그인 상태
  bool _loginStat = false;

  // getter
  // get : getter 메소드를 정의하는 키워드
  Users get userInfo => _userInfo; // 전역변수
  bool get isLogin => _loginStat; // 전역변수

  // 🔒 안전한 저장소
  final storage = const FlutterSecureStorage();
  // 읽기 : storage.read(key: key)
  // 쓰기 : storage.write(key: key, value: value)
  // 삭제 : storage.delete(key: key)

  /// 🔐 로그인 요청
  /// 1. 요청 및 응답
  /// ➡ username, password
  /// ⬅ jwt token
  ///
  /// 2. jwt 토큰을 SecureStorage 에 저장
  Future<void> login(String username, String password) async {
    // TODO: 로그인 경로 수정
    const url = 'http://10.0.2.2:8081/login'; // 로그인 경로
    final requestUrl = Uri.parse('$url?username=$username&password=$password');
    try {
      // 로그인 요청
      final response = await http.get(requestUrl);

      if (response.statusCode == 200) {
        print('로그인 성공...');

        // HTTP 요청이 성공했을 때
        final authorizationHeader = response.headers['authorization'];

        if (authorizationHeader != null) {
          // Authorization 헤더에서 "Bearer "를 제거하고 JWT 토큰 값을 추출
          final jwtToken = authorizationHeader.replaceFirst('Bearer ', '');

          // 여기서 jwtToken을 사용하면 됩니다.
          print('JWT Token: $jwtToken');
          //eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJleHAiOjE3MDY5NTEzMTgsInVubyI6IjI0IiwidWlkIjoiY2h1eWoyIiwicm9sIjpbIlJPTEVfU0VMTCJdfQ.RavcKqDokDQrWU2oK4yRGV1paoGWsQrQ7gUb4WhgNgFaOxtOjp35YMY58lZWuZV4zbJzEIfN1LQtstUG9ztntg

          // jwt 저장
          await storage.write(key: 'jwtToken', value: jwtToken);
          _loginStat = true;
        } else {
          // Authorization 헤더가 없는 경우 처리
          print('Authorization 헤더가 없습니다.');
        }
      } else if (response.statusCode == 403) {
        print('아이디 또는 비밀번호가 일치하지 않습니다...');
      } else {
        print('네트워크 오류 또는 알 수 없는 오류로 로그인에 실패하였습니다...');
      }
    } catch (error) {
      print("로그인 실패 $error");
    }
    // 공유된 상태를 가진 위젯 다시 빌드
    notifyListeners();
  }

  /// 👩‍💼👨‍💼 사용자 정보 가져오기
  /// 1. 💍 jwt ➡ 서버
  /// 2. 클라이언트 ⬅ 👩‍💼👨‍💼
  /// 3. 👩‍💼👨‍💼(userInfo) ➡ _userInfo [provider] 저장
  Future<void> getUserInfo() async {
    final url = 'http://10.0.2.2:8081/api/user/info'; // 사용자 정보 요청 경로
    try {
      // 저장된 jwt 가져오기
      String? token = await storage.read(key: 'jwtToken');
      print('사용자 정보 요청 전: jwt - $token');
//jwt - eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJleHAiOjE3MDY5NTEzMTgsInVubyI6IjI0IiwidWlkIjoiY2h1eWoyIiwicm9sIjpbIlJPTEVfU0VMTCJdfQ.RavcKqDokDQrWU2oK4yRGV1paoGWsQrQ7gUb4WhgNgFaOxtOjp35YMY58lZWuZV4zbJzEIfN1LQtstUG9ztntg
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // 성공적으로 데이터를 받아왔을 때의 처리
        var utf8Decoded = utf8.decode(response.bodyBytes);
        var result = json.decode(utf8Decoded);
        final userInfo = result;
        print('Users Info: $userInfo');
        // {userNo: 24, userId: chuyj2, userPw: null, userPwCheck: null, userName: 추윤주, userTel: 01034716517, userEmail: dfj@aver.com, userAddress: dsfakjsd;f, companyName: 기업명입니다. , companyNumber: 123456789, regDate: 2024-01-22T05:11:25.000+00:00, updDate: 2024-01-22T05:11:25.000+00:00, auth: ROLE_SELL, authList: [{authNo: 0, userId: chuyj2, auth: ROLE_SELL}]}

        // provider 에 사용자 정보 저장
        // userInfo ➡ _userInfo 로 저장
        // provider  등록
        _userInfo = Users.fromJson(userInfo);
        print(_userInfo);
      } else {
        // HTTP 요청이 실패했을 때의 처리
        print('HTTP 요청 실패: ${response.statusCode}');

        print('사용자 정보 요청 성공');
      }
    } catch (error) {
      print('사용자 정보 요청 실패 $error');
    }
    notifyListeners();
  }

  // 로그아웃
  Future<void> logout() async {
    try {
      // ⬅👨‍💼 로그아웃 처리
      // jwt 토큰 삭제
      await storage.delete(key: 'jwtToken');
      // 사용자 정보 초기화
      _userInfo = Users();
      // 로그인 상태 초기화
      _loginStat = false;

      print('로그아웃 성공');
    } catch (error) {
      print('로그아웃 실패');
    }
    notifyListeners();
  }
}
