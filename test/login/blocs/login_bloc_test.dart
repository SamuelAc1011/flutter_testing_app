import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_app/login/blocs/blocs.dart';

void main() {
  group('Login Bloc', () {
    test('Initial Status', () {
      expect(LoginBloc().state, equals(const LoginState()));
    });

    blocTest<LoginBloc, LoginState>(
      'emit [LoginInitStatus.loaded] when the login is initiated',
      build: LoginBloc.new,
      act: (bloc) => bloc.add(LoginInitiated()),
      wait: const Duration(seconds: 2),
      expect: () => [
        equals(const LoginState(initStatus: LoginInitStatus.loaded)),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'Emit a new state when the user is edited',
      build: LoginBloc.new,
      act: (bloc) => bloc.add(const UserInputEdited('Sam')),
      expect: () => [
        isA<LoginState>()
            .having(
              (state) => state.initStatus,
              'The init was loaded',
              LoginInitStatus.loaded,
            )
            .having(
              (state) => state.userInput.isPure,
              'The user input is pure',
              true,
            ),
        isA<LoginState>().having(
          (state) => state.userInput.value,
          'Username',
          'Sam',
        )
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'Emit a new state when the password is edited',
      build: LoginBloc.new,
      act: (bloc) => bloc.add(const PasswordInputEdited('jIrks!dsk2')),
      expect: () => [
        isA<LoginState>()
            .having(
              (state) => state.initStatus,
          'The init was loaded',
          LoginInitStatus.loaded,
        )
            .having(
              (state) => state.passwordInput.isPure,
          'The password input is pure',
          true,
        ),
        isA<LoginState>().having(
          (state) => state.passwordInput.value,
          'Password',
          'jIrks!dsk2',
        )
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'Emit [SubmitStatus.submitting, SubmitStatus.success] when login is submitted with valid credentials',
      build: LoginBloc.new,
      act: (bloc) => bloc
        ..add(const UserInputEdited('Sam'))
        ..add(const PasswordInputEdited('jIrks!dsk2'))
        ..add(LoginSubmitted()),
      expect: () => [
        isA<LoginState>().having(
          (state) => state.initStatus,
          'The init was loaded',
          LoginInitStatus.loaded,
        ),
        isA<LoginState>().having(
          (state) => state.userInput.value,
          'The user input was modified',
          'Sam',
        ),
        isA<LoginState>().having(
          (state) => state.passwordInput.value,
          'The password input was modified',
          'jIrks!dsk2',
        ),
        isA<LoginState>()
            .having(
              (state) => state.submitStatus,
              'The user submitted the form',
              SubmitStatus.submitting,
            )
            .having(
              (state) => state.userInput.value,
              'The user input is valid',
              'Sam',
            )
            .having(
              (state) => state.passwordInput.value,
              'The password input is valid',
              'jIrks!dsk2',
            ),
        isA<LoginState>().having(
          (state) => state.submitStatus,
          'The validation succeeded',
          SubmitStatus.success,
        )
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'Emit [SubmitStatus.submitting, SubmitStatus.failure] when the login is submitted with invalid credentials',
      build: LoginBloc.new,
      act: (bloc) => bloc
        ..add(const UserInputEdited('Sam1'))
        ..add(const PasswordInputEdited('jIrks!dsk2'))
        ..add(LoginSubmitted()),
      wait: const Duration(seconds: 3),
      expect: () => [
        isA<LoginState>().having(
          (state) => state.initStatus,
          'The init was loaded',
          LoginInitStatus.loaded,
        ),
        isA<LoginState>().having(
          (state) => state.userInput.value,
          'The user input was modified',
          'Sam1',
        ),
        isA<LoginState>().having(
          (state) => state.passwordInput.value,
          'The password input was modified',
          'jIrks!dsk2',
        ),
        isA<LoginState>()
            .having(
              (state) => state.submitStatus,
              'The user submitted the form',
              SubmitStatus.submitting,
            )
            .having(
              (state) => state.userInput.value,
              'The user input has invalid characters',
              'Sam1',
            )
            .having(
              (state) => state.passwordInput.value,
              'The password input is valid',
              'jIrks!dsk2',
            ),
        isA<LoginState>().having(
          (state) => state.submitStatus,
          'The validation failed',
          SubmitStatus.failure,
        )
      ],
    );
  });
}
