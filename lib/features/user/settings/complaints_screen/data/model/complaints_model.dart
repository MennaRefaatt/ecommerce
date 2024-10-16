import 'package:freezed_annotation/freezed_annotation.dart';
part 'complaints_model.g.dart';
@JsonSerializable()
class ComplaintsModel {
  bool? status;
  String? message;
  List<ComplaintsDataList>? data;

  ComplaintsModel(
      {required this.status, required this.message, required this.data});

  factory ComplaintsModel.fromJson(Map<String, dynamic> json) =>
      _$ComplaintsModelFromJson(json);
}

@JsonSerializable()
class ComplaintsDataList {
  String? name;
  String? email;
  String? message;
  String? phone;
  int? id;
 factory ComplaintsDataList.fromJson(Map<String, dynamic> json) =>
      _$ComplaintsDataListFromJson(json);

  ComplaintsDataList(
      {required this.name,
      required this.email,
      required this.message,
      required this.phone,
      required this.id});
}
