import 'dart:convert';
import 'package:clean_arc_flutter/app/infrastructure/encrypter.dart';
import 'package:clean_arc_flutter/app/infrastructure/endpoints.dart';
import 'package:clean_arc_flutter/app/infrastructure/persistences/api_service.dart';
import 'package:clean_arc_flutter/app/misc/user_data.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:dio/dio.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injector/injector.dart';

// Commonly here to declare dependency injection
class RootModule {
  static void init(Injector injector) {
    injector.registerSingleton<Endpoints>(
        (_) => Endpoints(DotEnv().env['BASE_URL']));
    injector.registerSingleton<UserData>((Injector injector) => UserData(
      injector.getDependency<Encrypter>()
    ));

    injector.registerDependency<Dio>((Injector injector) {
      var dio = Dio();
      dio.options.connectTimeout = 60000;
      dio.options.receiveTimeout = 60000;

      var userData = injector.getDependency<UserData>();
      var endpoints = injector.getDependency<Endpoints>();

      // use for log response and request data
      dio.interceptors.add(LogInterceptor(
          requestBody: false,
          responseBody: false,
          requestHeader: false,
          responseHeader: false,
          request: false));
      dio.interceptors.add(
          DioCacheManager(CacheConfig(baseUrl: endpoints.baseUrl)).interceptor);

      if (userData.token != null && userData.token.isNotEmpty)
        dio.options.headers["Authorization"] = "Bearer " + userData.token;
      dio.options.baseUrl = endpoints.baseUrl;

      (dio.transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
      return dio;
    });

    injector.registerSingleton<EventBus>((Injector injector) {
      return EventBus();
    });

    injector.registerDependency<ApiService>((Injector injector) {
      return ApiService(
          injector.getDependency<Dio>(), injector.getDependency<EventBus>());
    });



    injector.registerDependency<Encrypter>((Injector injector) {
      return Encrypter();
    });
  }

  static parseAndDecode(String response) {
    return jsonDecode(response);
  }

  static parseJson(String text) {
    return compute(parseAndDecode, text);
  }
}
