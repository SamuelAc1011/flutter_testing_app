import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_testing_app/app/app.dart';
import 'package:flutter_testing_app/app/router/app_router.dart';
import 'package:flutter_testing_app/app/router/app_router.gr.dart';
import 'package:flutter_testing_app/auth/auth.dart';
import 'package:flutter_testing_app/auth/repository/activity_repository.dart';
import 'package:flutter_testing_app/l10n/l10n.dart';
import 'package:provider/provider.dart';
import 'package:testing_repository/testing_repository.dart';

class AppState extends StatelessWidget {
  const AppState({required this.serviceUrl, super.key});

  final String serviceUrl;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => TestingRepository(serviceUrl),
        ),
        RepositoryProvider(create: (context) => UserActivityMonitor()),
        ChangeNotifierProvider(
          create: (context) => AppRouter(),
        ),
      ],
      child: BlocProvider(
        create: (context) => ActivityMonitorBloc(
          context.read<UserActivityMonitor>(),
        ),
        child: BlocListener<ActivityMonitorBloc, ActivityMonitorState>(
          listener: (context, state) {
            if (state.status == ActivityStatus.inactive) {
              context.read<ActivityMonitorBloc>().add(LogOut());
              context.read<AppRouter>().replaceAll([const LoginRoute()]);
            }
          },
          listenWhen: (previous, current) => current.status != previous.status,
          child: const App(),
        ),
      ),
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: context.read<AppRouter>().config(),
    );
  }
}
