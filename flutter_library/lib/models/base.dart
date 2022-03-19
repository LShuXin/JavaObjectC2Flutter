import 'package:json_annotation/json_annotation.dart';
part 'base.g.dart';

@JsonSerializable()
class UserModel {
    int id;
    String? username;

    UserModel({required this.id, this.username});
    factory UserModel.fromJson(Map<String, dynamic> srcJson) => _$UserModelFromJson(srcJson);
    Map<String, dynamic> toJson() => _$UserModelToJson(this);
}