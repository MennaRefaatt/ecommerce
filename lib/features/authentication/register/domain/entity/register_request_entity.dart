import 'package:freezed_annotation/freezed_annotation.dart';
part 'register_request_entity.g.dart';
@JsonSerializable()
class RegisterRequestEntity {
  final String name;
  final String email;
  final String password;
  final String phone;

  RegisterRequestEntity({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
  });

  Map<String, dynamic> toJson() => _$RegisterRequestEntityToJson(this);
}