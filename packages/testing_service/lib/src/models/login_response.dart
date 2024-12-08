import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_response.freezed.dart';

part 'login_response.g.dart';

// Class -> LoginResponse
/// A model representing a user.
@freezed
class LoginResponse with _$LoginResponse {
  /// Constructor -> UserModel
  const factory LoginResponse({
    required String name,
    required String email,
  }) = _LoginResponse;

  // Method -> fromJson
  /// Creates an instance of [LoginResponse] from a JSON object.
  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}
