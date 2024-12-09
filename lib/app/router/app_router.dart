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
        AutoRoute(page: ProfileRoute.page),
      ];
}
