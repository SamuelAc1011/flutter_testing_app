// Class -> LoginInterface
/// An interface for logging in used by TestingService to log in a user.
abstract class LoginInterface {
  /// Creates an instance of [LoginInterface] with the given [user] and
  /// [password].
  LoginInterface({required this.user, required this.password});

  // Attribute -> user
  /// The user's username.
  final String user;

  // Attribute -> password
  /// The user's password.
  final String password;
}

// Class -> LoginData
/// A data class for logging in used by TestingService to log in a user.
class LoginData implements LoginInterface {
  /// Creates an instance of [LoginData] with the given [user] and [password].
  LoginData({required this.user, required this.password});

  @override
  final String user;
  @override
  final String password;
}
