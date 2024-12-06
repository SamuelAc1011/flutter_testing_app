import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_testing_app/login/login.dart';
import 'package:flutter_testing_app/utils/utils.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) =>
          current.passwordInput != previous.passwordInput ||
          current.submitStatus != previous.submitStatus,
      builder: (context, state) {
        return TextField(
          obscureText: true,
          onChanged: (value) {
            context.read<LoginBloc>().add(PasswordInputEdited(value));
          },
          decoration: InputDecoration(
            errorText: (state.submitStatus == SubmitStatus.failure)
                ? passwordErrorMessages[state.passwordInput.error]
                : null,
            labelText: 'Contraseña',
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        );
      },
    );
  }
}
