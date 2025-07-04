import 'package:dio/dio.dart';

class DioErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      if (err.response!.statusCode! >= 300) {
        String errorMessage = 'Something went wrong'; 
        
        if (err.response!.data is Map && err.response!.data.containsKey('message')) {
          errorMessage = err.response!.data['message'];
        } else if (err.response!.statusMessage != null) {
          errorMessage = err.response!.statusMessage!;
        }

        err = DioException(
          requestOptions: err.requestOptions,
          response: err.response,
          error: errorMessage,
          type: err.type,
        );
      } else {
        err = DioException(
          requestOptions: err.requestOptions,
          response: err.response,
          error: 'Something went wrong',
          type: err.type,
        );
      }
    } else {
      // Handle connection errors
      err = DioException(
        requestOptions: err.requestOptions,
        error: 'Connection error',
        type: err.type,
      );
    }
    super.onError(err, handler);
  }
}

