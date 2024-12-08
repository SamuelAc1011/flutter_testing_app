import 'package:fpdart/fpdart.dart';
import 'package:testing_service/testing_service.dart';

// Class -> TestingRepository
/// A repository that provides testing utilities.
class TestingRepository {

  /// Constructor -> TestingRepository
  TestingRepository(String baseUrl) : _service = TestingService(baseUrl);

  // Attribute -> _service
  final TestingService _service;

  // Method -> login
  /// Logs in the user with the given data.
  Future<Either<AppException, LoginResponse>> login(LoginInterface data) async {
    return _service.login(data);
  }
}
