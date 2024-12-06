part of 'login_bloc.dart';

// Event: LoginEvent
sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

// Event: LoginInitiated
/// Event to initialize the login process.
class LoginInitiated extends LoginEvent {}

// Event: UserInputEdited
/// Event to handle the user input edited.
class UserInputEdited extends LoginEvent {
  const UserInputEdited(this.user);

  final String user;

  @override
  List<Object> get props => [user];
}

// Event: PasswordInputEdited
/// Event to handle the password input edited.
class PasswordInputEdited extends LoginEvent {
  const PasswordInputEdited(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

// Event: LoginSubmitted
/// Event to submit the login process.
class LoginSubmitted extends LoginEvent {}
