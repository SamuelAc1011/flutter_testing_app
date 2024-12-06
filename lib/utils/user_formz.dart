import 'package:formz/formz.dart';

enum UserInputError {
  empty,
  hasSpecialChar,
  hasNumbers,
}

class UserInput extends FormzInput<String, UserInputError> {
  const UserInput.pure() : super.pure('');

  const UserInput.dirty([super.value = '']) : super.dirty();

  @override
  UserInputError? validator(String value) {
    if (value.isEmpty) {
      return UserInputError.empty;
    } else if (value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return UserInputError.hasSpecialChar;
    } else if (value.contains(RegExp('[0-9]'))) {
      return UserInputError.hasNumbers;
    }
    return null;
  }
}

final _errorMessages = {
  UserInputError.empty: 'Este campo no puede estar vacío',
  UserInputError.hasNumbers: 'El usuario no puede contener números',
  UserInputError.hasSpecialChar:
      'El usuario no puede contener caracteres especiales',
};

Map<UserInputError, String> get userErrorMessages => _errorMessages;
