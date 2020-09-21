// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) {
  return LoginResponse(
    userId: json['userId'] as int,
    username: json['username'] as String,
    lastName: json['lastName'] as String,
    firstName: json['firstName'] as String,
    loginResult: json['loginResult'] as String,
    token: json['token'] as String,
    lastLocaleLanguage: json['lastLocaleLanguage'] as String,
    theme: json['theme'] as String,
    alpha: json['alpha'] as num,
    companyId: json['companyId'] as int,
  );
}

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'username': instance.username,
      'lastName': instance.lastName,
      'firstName': instance.firstName,
      'loginResult': instance.loginResult,
      'token': instance.token,
      'lastLocaleLanguage': instance.lastLocaleLanguage,
      'theme': instance.theme,
      'alpha': instance.alpha,
      'companyId': instance.companyId,
    };
