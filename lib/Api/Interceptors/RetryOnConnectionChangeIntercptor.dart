import 'dart:developer';
import 'dart:io';
import 'package:async_button_builder/async_button_builder.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as DIO;
import 'package:fgi_y2j/features/authentication/controller/AuthenticationController.dart';
import 'package:get/get.dart';
import '../../features/Dialog/Authentication_Message.dart';
import '../../features/cache_stroage/localStroage.dart';
import 'ConnectivityRequestRetrier.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final ConnectiveRequestRetrier requestRetrier;

  RetryOnConnectionChangeInterceptor({required this.requestRetrier});

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    final authenticationController=Get.put(AuthenticationController());
    authenticationController.loginButtonState.value=const ButtonState.idle();
    if (_shouldRetry(err)) {
      authenticationErrorDialog('Warning', "No Internet Connection. Turn On Connection.");
      DIO.Response response = await requestRetrier.scheduleRequestRetry(err);
      log("Solved : ${response.data}");
      handler.resolve(response);
    } else {
      log("message : No Network Error ${err.type == DioErrorType.connectionError}");
      if(err.response==null){
        authenticationErrorDialog('Warning', "Server Busy. Try Again.");

      }else{
        Map<String, dynamic> messageRes = err.response!.data;
        String message=messageRes['message'];
        authenticationErrorDialog('Warning', message.isEmpty?"Unknown Error Try Again":message);
      }

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
    options.headers['Accept'] = 'application/json';
    super.onRequest(options, handler);
  }
}
