import 'dart:async';
import 'dart:developer';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ConnectiveRequestRetrier {
  final Dio dio;
  final Connectivity connectivity;

  ConnectiveRequestRetrier({required this.connectivity, required this.dio});

  Future<Response> scheduleRequestRetry(DioException e) async {
    StreamSubscription<ConnectivityResult>? streamSubscription;
    final responseCompleted = Completer<Response>();
    streamSubscription = connectivity.onConnectivityChanged.listen((event) {

      if (event != ConnectivityResult.none) {
        log("Network Connected");
        log(e.requestOptions.baseUrl+e.requestOptions.path);
        streamSubscription!.cancel();
        responseCompleted.complete(dio.request(
          e.requestOptions.path,
          data: e.requestOptions.data,
          onReceiveProgress: e.requestOptions.onReceiveProgress,
          onSendProgress: e.requestOptions.onSendProgress,
          queryParameters: e.requestOptions.queryParameters,
        ));
      }
    });
    return responseCompleted.future;
  }
}
