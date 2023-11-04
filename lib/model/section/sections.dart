import 'package:json_annotation/json_annotation.dart';

part 'sections.g.dart';

@JsonSerializable()
class SectionsModel {
  String? section;
  String? displayName;

  SectionsModel({
    this.section,
    this.displayName,
  });
  factory SectionsModel.fromJSon(Map<String, dynamic> json) =>
      _$SectionsModelFromJson(json);
}
