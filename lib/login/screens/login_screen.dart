import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_testing_app/login/login.dart';
import 'package:lottie/lottie.dart';
import 'package:testing_repository/testing_repository.dart';

@RoutePage()
class LoginProvider extends StatelessWidget {
  const LoginProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        context.read<TestingRepository>(),
      ),
      child: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: LoginSuccess(),
      body: BlocSelector<LoginBloc, LoginState, LoginInitStatus>(
        selector: (state) => state.initStatus,
        builder: (context, status) {
          return views[status]!(context);
        },
      ),
    );
  }
}

final Map<LoginInitStatus, Widget Function(BuildContext)> views = {
  LoginInitStatus.loading: (_) =>
      const Center(child: CircularProgressIndicator()),
  LoginInitStatus.loaded: (_) => const LoginSuccess(),
  LoginInitStatus.error: (context) =>
      BlocSelector<LoginBloc, LoginState, String>(
        selector: (state) => state.errorMessage!,
        builder: (context, message) {
          return ErrorView(message);
        },
      ),
};

class ErrorView extends StatelessWidget {
  const ErrorView(
    this.message, {
    super.key,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Error',
          style: TextStyle(
            color: Colors.red,
            fontSize: 34,
            fontWeight: FontWeight.bold,
          ),
        ),
        Lottie.asset(
          'assets/lotties/error.json',
          height: MediaQuery.of(context).size.height * 0.2,
        ),
        Text(
          message,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 45),
          child: ElevatedButton(
            onPressed: () => context.read<LoginBloc>().add(RetryLogin()),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade200,
            ),
            child: const Text('Retry', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    ));
  }
}
