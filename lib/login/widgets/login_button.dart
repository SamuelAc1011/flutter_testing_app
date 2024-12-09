import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_testing_app/login/login.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginBloc, LoginState, SubmitStatus>(
      selector: (state) => state.submitStatus,
      builder: (context, submitStatus) {
        if (submitStatus == SubmitStatus.submitting) {
          return const CircularProgressIndicator();
        }

        if (submitStatus == SubmitStatus.success) {
          return const SuccessLoginAnimation();
        }

        return ElasticIn(
          child: ElevatedButton(
            onPressed: () => context.read<LoginBloc>().add(LoginSubmitted()),
            child: const Text('Iniciar sesión'),
          ),
        );
      },
    );
  }
}
