import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_testing_app/app/router/app_router.gr.dart';
import 'package:flutter_testing_app/login/login.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      // Condition: Listen only when the submit status changes.
      listenWhen: (previous, current) =>
          current.submitStatus != previous.submitStatus,
      listener: _submitListener,
      child: BlocSelector<LoginBloc, LoginState, SubmitStatus>(
        selector: (state) => state.submitStatus,
        builder: (context, submitStatus) {
          if (submitStatus == SubmitStatus.submitting) {
            return const CircularProgressIndicator();
          }

          return ElevatedButton(
            onPressed: () => context.read<LoginBloc>().add(LoginSubmitted()),
            child: const Text('Iniciar sesión'),
          );
        },
      ),
    );
  }
}


void _submitListener(BuildContext context, LoginState state) {
  if (state.submitStatus == SubmitStatus.success) {
    context.router.replace(const MainRoute());
  }

  if (state.submitStatus == SubmitStatus.failure) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Credenciales incorrectas'),
        ),
      );
  }
}
