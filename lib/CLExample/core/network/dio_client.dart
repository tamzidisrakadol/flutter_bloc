import 'package:dio/dio.dart';
import '../error/failure.dart';
import 'api_result.dart';

final token = "eyJhbGciOiJSUzI1NiIsImtpZCI6IjFEMjFEM0I0MjlFMkEwQzMyQTE5QUY5NERGN0E0RTlDQjcxQTYyNkNSUzI1NiIsInR5cCI6ImF0K2p3dCIsIng1dCI6IkhTSFR0Q25pb01NcUdhLVUzM3BPbkxjYVltdyJ9.eyJuYmYiOjE3NTM0ODYzMDMsImV4cCI6MTc1MzQ4OTkwMywiaXNzIjoiaHR0cHM6Ly9hY2NvdW50LmJkLWNhc3QuY29tIiwiYXVkIjoiaHR0cHM6Ly9hY2NvdW50LmJkLWNhc3QuY29tL3Byb2ZpbGUiLCJjbGllbnRfaWQiOiJjb20uemVwaHlyLmJkY2FzdC5kcm9pZCIsInN1YiI6IjJlMTE0ZTRlMGQ5MTQ2MTNhMmRlMWY1ZmMxYzI3NzczIiwiYXV0aF90aW1lIjoxNzUyNzcyODU1LCJpZHAiOiJHb29nbGUiLCJuYW1lIjoiVGFtemlkIElzcmFrIEFkb2wiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiVGFtemlkIElzcmFrIEFkb2wiLCJlbWFpbCI6InRhbXppZGlzcmFrMTJAZ21haWwuY29tIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiQWRtaW4iLCJzdWJzY3JpcHRpb24iOiJBQ1RJVkUiLCJqdGkiOiJFNTRFMkI0MTc1MzVEOENDQTExNEVBRUJDQ0U3Qzk3NiIsImlhdCI6MTc1MzQ4NjMwMywic2NvcGUiOlsib3BlbmlkIiwiZW1haWwiLCJhdXRoLnByb2ZpbGUucmVhZCIsImNsaWVudF9kZXZpY2U6cUdKdlUyZEJibVJ5YjJsa1pHMWhhMlZtV0dsaGIyMXBaRzVoYldWdFVtVmtiV2tnVG05MFpTQXhNV1ZwWkdsdmJXVndhRzl1WldWdGIyUmxiR2t5TWpBeE1URTNWRWRtWmtOTlgxSlVlSTVqTXpSR1VUTnllVkZRVXkxUWVDMW5iMUV3YjBWUE9rRlFRVGt4WWtkVVkweG1Vamx3YUdoTllqSTFUMDVDTFZFelQydFBZMFJsYmkxa09GTk1Wakp0WlVZNWNESkZOVXA2ZFZrNFlrTnZPVlZxUWtsR1UxUkJSRmxYU0VvdFFVZFdVMnBRV0dsVVNHMXpVVE5sTTNSdGIwNWZZM28zVFVNd2NUVkplalJ6ZEdOV1ZFRkdNVFZ6VHpKR01GbEpaMlpEVFY5SlNVUjJZek0wUmxFemNubFJVRk10VUhndFoyOVJNRzlGVDJwaGNIQldaWEp6YVc5dVl6RTBPUT09Iiwib2ZmbGluZV9hY2Nlc3MiXSwiYW1yIjpbImV4dGVybmFsIl19.Z1Pwk28KK7IamT2UwhVPeBlmN1H6uSVnwB0q-HESSsnjScupddoyElWe3RiXcGK7fXndVkQooIOSFl6wHIv0xyHOKpkpLXVwvyNGkhYVHPusgikGQRCkG5n-HgpaRGC3bLjNcovRYtfdJvNOar3mVzQafKrqMXkGeskuQ-yKcYeCq3QYkUn3R2AUpDf886FXzSQqgd1FMcfju8KGoQw2V_BlSfl1ehXYTMkppON_dzjN-SWo4hG8cI9Kov1ihfQI5EpPaoPNfACIqdAG_GuDNOAs7Jypf3iKUznuacV0o0qnH7F0NDsybT92Jvy_NcIWigjHgI9S6XyuWTVBvoqrcBUOobhwSotZ38rWxVKX7n87zYtttS629rvce4sNJ0rYd-ijC23GFWVd2HdmvP6l6UBOASxEsUqZ53KNKFKyolB0QA3yRzOVZ4we5Um-V-U4Q4zyb3qeoe47DD0m5aLXmSCc4yAuLiZg7Tk8SE4r5lDrUcsl8jPRvGMj1vfSYVJzQq-rGcYNKip7WqGb_iHebvdObo_rpu9vjjuh3BVk4TECo1B13OzHRR8xFmuLMbzb1Bq4azc1KMurqHNcjKCkzz_ggGfrdaF4k-LouVtU7WYMJagK_T9yZ37F4EV2GyidnEFQ-167GqisYNAHXFXFNJs5UEkeqK7nNxCc5xATiR8";

class DioClient {
  final Dio dio;

  DioClient(this.dio) {
    // Optional: Configure Dio instance
   // dio.options.baseUrl = 'https://api.escuelajs.co/'; // Base URL for all requests
    dio.options.baseUrl = 'https://api.bd-cast.com/'; // Base URL for all requests
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);
    dio.interceptors.add(
      InterceptorsWrapper(onRequest: (options, handler) {
        options.headers['Authorization'] = 'Bearer $token';
        handler.next(options);
      }),
    );
  }

  Future<ApiResult<T>> apiResponseHandler<T>(
      String path, {
        required T Function(dynamic json) parser,
        String method = 'GET',
        Map<String, dynamic>? queryParameters,
        dynamic data,
        Options? options,
      }) async {
    try {
      Response response;
      switch (method.toUpperCase()) {
        case 'GET':
          response = await dio.get(
            path,
            queryParameters: queryParameters,
            options: options,
          );
          break;
        case 'POST':
          response = await dio.post(
            path,
            data: data,
            queryParameters: queryParameters,
            options: options,
          );
          break;
        case 'PUT':
          response = await dio.put(
            path,
            data: data,
            queryParameters: queryParameters,
            options: options,
          );
          break;
        case 'DELETE':
          response = await dio.delete(
            path,
            queryParameters: queryParameters,
            options: options,
          );
          break;
        default:
          throw ArgumentError('Unsupported HTTP method: $method');
      }

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        if (response.data == null && T != dynamic) {
          return ApiSuccess(null as T, statusCode: response.statusCode);
        }
        return ApiSuccess(parser(response.data), statusCode: response.statusCode);
      } else {
        return ApiFailure(
          _mapStatusCodeToFailure(response.statusCode!, response.statusMessage),
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      // Dio-specific error handling
      return ApiFailure(_mapDioExceptionToFailure(e));
    } catch (e) {
      // General unexpected errors
      return ApiFailure(const ServerFailure(message: 'An unexpected error occurred.'));
    }
  }

  Failure _mapDioExceptionToFailure(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return const NetworkFailure(message: 'Connection timed out.');
    } else if (e.type == DioExceptionType.badResponse) {
      final statusCode = e.response?.statusCode;
      final errorMessage = e.response?.data['message'] as String? ?? e.message;
      return _mapStatusCodeToFailure(statusCode, errorMessage);
    } else if (e.type == DioExceptionType.cancel) {
      return const ServerFailure(message: 'Request cancelled.');
    } else if (e.type == DioExceptionType.unknown) {
      if (e.message != null && e.message!.contains('SocketException')) {
        return const NetworkFailure(message: 'No internet connection.');
      }
      return const ServerFailure(message: 'An unknown network error occurred.');
    }
    return ServerFailure(message: e.message ?? 'An unexpected Dio error occurred.');
  }

  Failure _mapStatusCodeToFailure(int? statusCode, String? message) {
    switch (statusCode) {
      case 400:
        return ServerFailure(message: message ?? 'Bad Request.');
      case 401:
        return ServerFailure(message: message ?? 'Unauthorized.');
      case 403:
        return ServerFailure(message: message ?? 'Forbidden.');
      case 404:
        return ServerFailure(message: message ?? 'Not Found.');
      case 409:
        return ServerFailure(message: message ?? 'Conflict.');
      case 422:
        return ServerFailure(message: message ?? 'Unprocessable Entity (Validation Failed).');
      case 500:
        return ServerFailure(message: message ?? 'Internal Server Error.');
      case 502:
        return ServerFailure(message: message ?? 'Bad Gateway.');
      case 503:
        return ServerFailure(message: message ?? 'Service Unavailable.');
      default:
        return ServerFailure(message: message ?? 'Received invalid status code: $statusCode');
    }
  }
}


// Extension to add .when() or .fold() for sealed classes
extension ApiResultExtension<T> on ApiResult<T> {
  R when<R>(
      R Function(T data, int? statusCode) onSuccess,
      R Function(Failure failure, int? statusCode) onFailure,
      ) {
    if (this is ApiSuccess<T>) {
      final success = this as ApiSuccess<T>;
      return onSuccess(success.data, success.statusCode);
    } else if (this is ApiFailure<T>) {
      final failure = this as ApiFailure<T>;
      return onFailure(failure.failure, failure.statusCode);
    }
    throw StateError('Unknown ApiResult type');
  }
}