import 'package:freezed_annotation/freezed_annotation.dart';
part 'confirm_param.g.dart';
@JsonSerializable()
class ConfirmParam {
  ConfirmParam({
    required this.addressId,
    required this.paymentMethod,
  });
  int addressId;
  int paymentMethod;

  factory ConfirmParam.fromJson(Map<String, dynamic> json) => _$ConfirmParamFromJson(json);
  Map<String, dynamic> toJson() => _$ConfirmParamToJson(this);
}