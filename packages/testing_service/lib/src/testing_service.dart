import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';
import 'package:testing_service/src/exceptions/exceptions.dart';
import 'package:testing_service/src/interfaces/interfaces.dart';
import 'package:testing_service/src/models/models.dart';

// Class -> TestingService
/// A service that provides testing utilities.
class TestingService {
  /// Constructor for [TestingService].
  TestingService(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  // Attribute -> _dio
  /// The [Dio] instance used to make HTTP requests.
  final Dio _dio = Dio();

  // Attribute -> _logger
  /// The logger used to log messages.
  final Logger _logger = Logger();

  // Method -> login
  /// Logs in the user with the given [loginData].
  Future<Either<AppException, LoginResponse>> login(
    LoginInterface loginData,
  ) async {
    try {
      _logger.i('Logging in user: ${loginData.user}');
      final response = await _dio.post<Map<String, dynamic>>(
        'login',
        data: {
          'user': loginData.user,
          'password': loginData.password,
        },
      );
      _logger.i('User logged in successfully');
      return right(LoginResponse.fromJson(response.data!));
    } on DioException catch (error) {
      _logger.e('DioException occurred: $error');
      return left(AppException.fromDioError(error));
    } catch (error) {
      _logger.e('An error occurred: $error');
      return left(AppException(error.toString()));
    }
  }
}
