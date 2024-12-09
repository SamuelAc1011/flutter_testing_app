import 'package:flutter_testing_app/app/app.dart';
import 'package:flutter_testing_app/bootstrap.dart';

void main() {
  const serviceUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://192.168.100.21:8080/',
  );

  bootstrap(() => const AppState(serviceUrl: serviceUrl));
}
