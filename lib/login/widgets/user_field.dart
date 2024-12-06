import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_testing_app/login/blocs/blocs.dart';
import 'package:flutter_testing_app/utils/user_formz.dart';

class UserTextField extends StatelessWidget {
  const UserTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) =>
          current.userInput != previous.userInput ||
          current.submitStatus != previous.submitStatus,
      builder: (context, state) {
        return TextField(
          onChanged: (value) {
            context.read<LoginBloc>().add(UserInputEdited(value));
          },
          decoration: InputDecoration(
            errorText: (state.submitStatus == SubmitStatus.failure)
                ? userErrorMessages[state.userInput.error]
                : null,
            labelText: 'Usuario',
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        );
      },
    );
  }
}
