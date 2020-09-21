// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocaleResource _$LocaleResourceFromJson(Map<String, dynamic> json) {
  return LocaleResource(
    companyId: json['companyId'] as int,
    locale: json['locale'] as String,
    category: json['category'] as String,
    typeGroup: json['typeGroup'] as String,
    key: json['key'] as String,
    value: json['value'] as String,
  );
}

Map<String, dynamic> _$LocaleResourceToJson(LocaleResource instance) =>
    <String, dynamic>{
      'companyId': instance.companyId,
      'locale': instance.locale,
      'category': instance.category,
      'typeGroup': instance.typeGroup,
      'key': instance.key,
      'value': instance.value,
    };
