import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class LocaleResource {
  final int companyId;
  final String locale;
  final String category;
  final String typeGroup;
  final String key;
  final String value;

  LocaleResource({this.companyId, this.locale, this.category, this.typeGroup, this.key, this.value});

  factory LocaleResource.fromJson(Map<String, dynamic> json) => _$LocaleResourceFromJson(json);
  Map<String, dynamic> toJson() => _$LocaleResourceToJson(this);
}
