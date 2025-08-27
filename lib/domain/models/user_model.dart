import 'package:hive/hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class User with _$User {
  @HiveType(typeId: 0, adapterName: 'UserAdapter')
  const factory User({
    @HiveField(0) required String firstName,
    @HiveField(1) required String lastName,
    @HiveField(2) required String email,
    @HiveField(3) required String password,
    @HiveField(4) required DateTime birthdate,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
