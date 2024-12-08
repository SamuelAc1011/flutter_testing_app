import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_testing_app/app/router/app_router.gr.dart';
import 'package:flutter_testing_app/auth/auth.dart';

import '../../auth/repository/activity_repository.dart';

@RoutePage()
class MainProvider extends StatelessWidget {
  const MainProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainScreen();
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Screen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => context.router.replace(const LoginRoute()),
          ),
        ],
      ),
      body: const Center(
        child: Text('Main Screen'),
      ),
    );
  }
}
