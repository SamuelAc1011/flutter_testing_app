import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_testing_app/login/login.dart';

@RoutePage()
class LoginProvider extends StatelessWidget {
  const LoginProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
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
          return views[status]!;
        },
      ),
    );
  }
}

final Map<LoginInitStatus, Widget> views = {
  LoginInitStatus.loading: const Center(child: CircularProgressIndicator()),
  LoginInitStatus.loaded: const LoginSuccess(),
  LoginInitStatus.error: const LoginSuccess(),
};
