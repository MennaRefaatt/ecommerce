import 'package:freezed_annotation/freezed_annotation.dart';
part 'update_acc_param.g.dart';
@JsonSerializable()
class UpdateAccParam {
  final String name;
  final String phone;
  final String email;
  UpdateAccParam({required this.name, required this.phone, required this.email});

  factory UpdateAccParam.fromJson(Map<String, dynamic> json) => _$UpdateAccParamFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateAccParamToJson(this);
}