import 'package:formz/formz.dart';

enum PasswordInputError { empty, tooShort, tooLong, hasSpecialCharacters }

class PasswordInput extends FormzInput<String, PasswordInputError> {
  const PasswordInput.pure() : super.pure('');

  const PasswordInput.dirty([super.value = '']) : super.dirty();

  @override
  PasswordInputError? validator(String value) {
    if (value.isEmpty) {
      return PasswordInputError.empty;
    } else if (value.length < 8) {
      return PasswordInputError.tooShort;
    } else if (value.length > 10) {
      return PasswordInputError.tooLong;
    } else if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return PasswordInputError.hasSpecialCharacters;
    } else {
      return null;
    }
  }
}

final _errorMessages = {
  PasswordInputError.empty: 'El campo no puede estar vacío',
  PasswordInputError.tooShort: 'La contraseña debe tener al menos 8 caracteres',
  PasswordInputError.tooLong:
      'La contraseña no puede tener más de 10 caracteres',
  PasswordInputError.hasSpecialCharacters:
      'La contraseña debe tener al menos un caracter especial',
};

Map<PasswordInputError, String> get passwordErrorMessages => _errorMessages;
