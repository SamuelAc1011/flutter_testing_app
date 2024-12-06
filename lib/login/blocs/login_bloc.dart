import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_testing_app/utils/utils.dart';
import 'package:formz/formz.dart';
import 'package:logger/logger.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginInitiated>(_onLoginInitiated);

    on<UserInputEdited>(_onUserInputEdited);

    on<PasswordInputEdited>(_onPasswordInputEdited);

    on<LoginSubmitted>(_onLoginSubmitted);

    _init();
  }

  // Attribute: _logger
  /// Logger instance to log the events and states of the bloc.
  final Logger _logger = Logger();

  // Method: _init
  /// Method to initialize the login process.
  void _init() {
    add(LoginInitiated());
  }

  // Method: _onLoginInitiated
  /// Method to handle the [LoginInitiated] event.
  Future<void> _onLoginInitiated(
    LoginInitiated event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(initStatus: LoginInitStatus.loaded));
  }

  // Method: _onUserInputEdited
  /// Method to handle the [UserInputEdited] event.
  void _onUserInputEdited(
    UserInputEdited event,
    Emitter<LoginState> emit,
  ) {
    _logger.i('User input edited: ${event.user}');
    emit(state.copyWith(userInput: UserInput.dirty(event.user)));
  }

  // Method: _onPasswordInputEdited
  /// Method to handle the [PasswordInputEdited] event.
  void _onPasswordInputEdited(
    PasswordInputEdited event,
    Emitter<LoginState> emit,
  ) {
    _logger.i('Password input edited: ${event.password}');
    emit(state.copyWith(passwordInput: PasswordInput.dirty(event.password)));
  }

  // Method: _onLoginSubmitted
  /// Method to handle the [LoginSubmitted] event.
  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    _logger.f('Login submitted');
    emit(state.copyWith(submitStatus: SubmitStatus.submitting));

    try {
      if (Formz.validate([state.userInput, state.passwordInput]) != true) {
        _logger.e('Invalid form');
        throw Exception('Invalid form');
      }
      // Action -> Simulate submitting the login process.
      _logger.i('Login successful');
      emit(state.copyWith(submitStatus: SubmitStatus.success));
    } catch (exception) {
      _logger.e('Login failed');
      emit(state.copyWith(submitStatus: SubmitStatus.failure));
    }
  }
}
