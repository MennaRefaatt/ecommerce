import 'package:freezed_annotation/freezed_annotation.dart';
part 'search_model.g.dart';

@JsonSerializable()
class SearchModel {
  bool? status;
  SearchData? data;

  SearchModel(
      {
      required this. status,
      required this. data,});

 factory SearchModel.fromJson(Map<String, dynamic> map) => _$SearchModelFromJson(map);
}

 @JsonSerializable()
class SearchData {
  List<SearchDataList>? searchDataList;
  SearchData({required this. searchDataList,});

 factory SearchData.fromJson(Map<String, dynamic> map) => _$SearchDataFromJson(map);
}

@JsonSerializable()
class SearchDataList {
  int? id;
  String? name;
  String? image;
  int? price;
  @JsonKey(name: 'in_favorites')
  bool? inFavourite;
  @JsonKey(name: 'in_cart')
  bool? inCart;
  String? description;

  SearchDataList({
    required this. id,
    required this. name,
    required this. image,
    required this. price,
    required this. inFavourite,
    required this. inCart,
    required this. description,
  });

 factory SearchDataList.fromJson(Map<String, dynamic> map) =>
      _$SearchDataListFromJson(map);
}
