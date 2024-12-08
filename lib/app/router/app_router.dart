import 'package:auto_route/auto_route.dart';
import 'package:flutter_testing_app/app/router/app_router.gr.dart';
import 'package:flutter_testing_app/auth/repository/activity_repository.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Provider|Screen,Route',
)
class AppRouter extends RootStackRouter {
  final bool isActive;

  AppRouter(this.isActive);

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, initial: true),
        AutoRoute(
          page: MainRoute.page,
          // guards: [AuthGuard()],
        ),
        AutoRoute(
          page: ProfileRoute.page,
          // guards: [
          //   AuthGuard(),
          // ],
        ),
      ];

  @override
  List<AutoRouteGuard> get guards => [AuthGuard(isActive)];
}

class AuthGuard extends AutoRouteGuard {
  AuthGuard(this.isActive);

  final bool isActive;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (resolver.route.name == LoginRoute.name) {
      resolver.next();
      return;
    }

    if (!isActive) {
      router.replaceAll([const LoginRoute()]);
      return;
    }

    resolver.next();
  }
}
