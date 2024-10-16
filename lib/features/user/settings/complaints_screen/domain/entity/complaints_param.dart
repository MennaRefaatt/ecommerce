import 'package:freezed_annotation/freezed_annotation.dart';
part 'complaints_param.g.dart';
@JsonSerializable()
class ComplaintsParam {
  String name;
  String email;
  String phone;
  String message;
  ComplaintsParam({required this.name, required this.email, required this.phone, required this.message});

  Map<String, dynamic> toJson() => _$ComplaintsParamToJson(this);
}