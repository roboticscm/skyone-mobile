import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class LoginResponse {
  final int userId;
  final String username;
  final String lastName;
  final String firstName;
  final String loginResult;
  final String token;
  final String lastLocaleLanguage;
  final String theme;
  final num alpha;
  final int companyId;

  LoginResponse(
      {this.userId,
      this.username,
      this.lastName,
      this.firstName,
      this.loginResult,
      this.token,
      this.lastLocaleLanguage,
      this.theme,
      this.alpha,
      this.companyId});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}


