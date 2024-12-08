import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_testing_app/utils/utils.dart';
import 'package:formz/formz.dart';
import 'package:logger/logger.dart';
import 'package:testing_repository/testing_repository.dart';
import 'package:testing_service/testing_service.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(
    this._repository,
  ) : super(const LoginState()) {
    on<LoginInitiated>(_onLoginInitiated);

    on<UserInputEdited>(_onUserInputEdited);

    on<PasswordInputEdited>(_onPasswordInputEdited);

    on<LoginSubmitted>(_onLoginSubmitted);

    on<RetryLogin>(_onRetryLogin);

    _init();
  }

  // Attribute: _logger
  /// Logger instance to log the events and states of the bloc.
  final Logger _logger = Logger();

  // Attribute: _service
  /// Repository instance to interact with the backend.
  final TestingRepository _repository;

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
    if (Formz.validate([state.userInput, state.passwordInput]) != true) {
      _logger.e('Invalid form');
      emit(state.copyWith(submitStatus: SubmitStatus.failure));
      return;
    }

    _logger.f('Login submitted');
    emit(state.copyWith(submitStatus: SubmitStatus.submitting));

    final result = await _repository.login(
      LoginData(
        user: state.userInput.value,
        password: state.passwordInput.value,
      ),
    );

    result.fold(
      (error) {
        _logger.e('Login failed');
        emit(
          state.copyWith(
            submitStatus: SubmitStatus.failure,
            initStatus: LoginInitStatus.error,
            errorMessage: error.message,
          ),
        );
      },
      (response) {
        _logger.i('Login successful');
        emit(state.copyWith(submitStatus: SubmitStatus.success));
      },
    );
  }

  // Method: _onRetryLogin
  /// Method to handle the [RetryLogin] event.
  void _onRetryLogin(
    RetryLogin event,
    Emitter<LoginState> emit,
  ) =>
      emit(
        state.copyWith(
          submitStatus: SubmitStatus.standby,
          initStatus: LoginInitStatus.loaded,
        ),
      );
}
