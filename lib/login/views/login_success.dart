import 'package:flutter/material.dart';
import 'package:flutter_testing_app/login/login.dart';

class LoginSuccess extends StatelessWidget {
  const LoginSuccess({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 200,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 50),
                    child: Text(
                      'Login Screen',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  UserTextField(),
                  SizedBox(height: 30),
                  PasswordTextField(),
                ],
              ),
            ),
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 100,
                  maxWidth: 400,
                ),
                child: const LoginButton(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
