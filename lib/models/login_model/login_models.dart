export 'email.dart';
export 'password.dart';

class LoginRequest {
  String email;
  String password;
  String? realm;

  LoginRequest({
    required this.email,
    required this.password,
    this.realm,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "realm": "ctshippertest0001gmailcom26092022"
      };
}

class LoginResponse {
  int? code;
  String? message;
  Data? data;

  LoginResponse({
    this.code,
    this.message,
    this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        code: json["code"] ?? '',
        message: json["message"] ?? '',
        data: json['data'] != null ? Data.fromJson(json['data']) : null,
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data?.toMap(),
      };
}

class Data {
  String? accessToken;

  Data({
    this.accessToken,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        accessToken: json["access_token"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "access_token": accessToken,
      };
}
