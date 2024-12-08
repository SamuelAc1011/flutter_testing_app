import 'package:flutter_testing_app/app/app.dart';
import 'package:flutter_testing_app/bootstrap.dart';
import 'package:provider/provider.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  const serviceUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://staging:3000/',
  );

  bootstrap(() => const AppState(serviceUrl: serviceUrl));
}
