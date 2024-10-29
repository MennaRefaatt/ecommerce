import 'package:freezed_annotation/freezed_annotation.dart';
part 'change_pass_param.g.dart';
@JsonSerializable()
class ChangePassParam {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  ChangePassParam({required this.currentPassword, required this.newPassword, required this.confirmPassword});

  factory ChangePassParam.fromJson(Map<String, dynamic> json) => _$ChangePassParamFromJson(json);
  Map<String, dynamic> toJson() => _$ChangePassParamToJson(this);
}