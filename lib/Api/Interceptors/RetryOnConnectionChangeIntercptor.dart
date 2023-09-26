import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as DIO;
import '../../features/Dialog/Authentication_Message.dart';
import '../../features/cache_stroage/localStroage.dart';
import 'ConnectivityRequestRetrier.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final ConnectiveRequestRetrier requestRetrier;

  RetryOnConnectionChangeInterceptor({required this.requestRetrier});

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    // log("RetryOnConnectionChangeIntercptor eror ${err.type}-- ${err.error}");
    // log("RetryOnConnectionChangeIntercptor eror ${err.type == DioErrorType.connectionError}-- ${err.error is SocketException}");
    if (_shouldRetry(err)) {
      authenticationErrorDialog('Warning', "Something Error");
      DIO.Response response = await requestRetrier.scheduleRequestRetry(err);
      log("Solved : ${response.data}");
      handler.resolve(response);
    } else {
      authenticationErrorDialog('Warning', "${err.message}");
      log("message : No Network Error ${err.type == DioErrorType.connectionError}");
    }
    // if(err.response!.statusCode==301)
    handler.next(err);
    super.onError(err, handler);
  }

  bool _shouldRetry(DioError err) {
    return err.type == DioErrorType.connectionError ||
        err.error is SocketException;
  }
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await LocalStorage.getJWT();
    if (token != null && token.isNotEmpty) {
      options.headers["Authorization"] = "Bearer $token";
    }
    options.headers['Content-Type'] = 'application/json';
    super.onRequest(options, handler);
  }
}
