import 'package:auto_route/auto_route.dart';
import 'package:flutter_testing_app/app/router/app_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Provider|Screen,Route',
)
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, initial: true),
        AutoRoute(page: MainRoute.page),
      ];

  @override
  List<AutoRouteGuard> get guards => [AuthGuard()];
}

class AuthGuard extends AutoRouteGuard {
  final bool isAuthenticated = true;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    resolver.next(isAuthenticated);
  }
}
