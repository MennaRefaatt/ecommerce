import 'package:freezed_annotation/freezed_annotation.dart';
part 'search_param.g.dart';
@JsonSerializable()
class SearchParam {

  final String text;
  SearchParam({required this.text});

  Map<String, dynamic> toJson() => _$SearchParamToJson(this);
}