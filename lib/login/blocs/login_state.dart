part of 'login_bloc.dart';

// Variable -> LoginInitStatus
/// Enum for the status of the login initialization.
/// [loading] - the loading status is shown when the login is being initialized
/// and the AuthStatus is not yet determined.
/// [loaded] - the loaded status is shown when the login is initialized and
/// the AuthStatus is determined.
/// [error] - the error status is shown when the login initialization fails.
enum LoginInitStatus {
  loading,
  loaded,
  error,
}

enum SubmitStatus {
  standby,
  submitting,
  success,
  failure,
}

// State: LoginState
class LoginState extends Equatable {
  const LoginState({
    this.initStatus = LoginInitStatus.loading,
    this.submitStatus = SubmitStatus.standby,
    this.userInput = const UserInput.pure(),
    this.passwordInput = const PasswordInput.pure(),
  });

  // Attribute: initStatus
  /// The status of the login initialization.
  final LoginInitStatus initStatus;

  // Attribute: submitStatus
  /// The status of the login submission.
  final SubmitStatus submitStatus;

  // Attribute: userInput
  /// The user input for the login process.
  final UserInput userInput;

  // Attribute: passwordInput
  /// The password input for the login process.
  final PasswordInput passwordInput;

  // Getter -> isFormValid
  /// Getter to check if the form is valid.
  bool get isFormValid => Formz.validate([userInput, passwordInput]);

  @override
  List<Object> get props => [
        initStatus,
        userInput,
        passwordInput,
        submitStatus,
      ];

  // Method: copyWith
  /// Method to create a new instance of [LoginState] with the provided
  /// parameters.
  LoginState copyWith({
    LoginInitStatus? initStatus,
    SubmitStatus? submitStatus,
    UserInput? userInput,
    PasswordInput? passwordInput,
  }) =>
      LoginState(
        initStatus: initStatus ?? this.initStatus,
        submitStatus: submitStatus ?? this.submitStatus,
        userInput: userInput ?? this.userInput,
        passwordInput: passwordInput ?? this.passwordInput,
      );
}
