import 'package:dio/dio.dart';
import 'package:dio_logger/dio_logger.dart';

class _DioHttpClientImpl {
  Dio? _dio;

  Dio of() {
    if (_dio == null) {
      BaseOptions baseOptions = BaseOptions(
        baseUrl: "https://restaurant-api.dicoding.dev"
      );
      _dio = Dio(baseOptions);
      _dio?.interceptors.add(dioLoggerInterceptor);
    }

    return _dio ?? (throw NullThrownError());
  }
}

class _DioHttpClientOptionsImpl {
  Map<String, dynamic> createTokenHeader(String tokenWithBearer) {
    return <String, dynamic> {"Authorization": tokenWithBearer};
  }

  Options createOptionsWithTokenHeader(String tokenWithBearer) {
    return Options(headers: createTokenHeader(tokenWithBearer));
  }
}

// ignore: non_constant_identifier_names
var DioHttpClient = _DioHttpClientImpl();

// ignore: non_constant_identifier_names
var DioHttpClientOptions = _DioHttpClientOptionsImpl();