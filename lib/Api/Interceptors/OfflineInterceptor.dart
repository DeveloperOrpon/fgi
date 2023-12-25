import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/helper/helperFunction.dart';
import '../../features/cache_stroage/localStroage.dart';
import '../../features/wishProduct/controller/WishController.dart';

class DataCacheService {
  DataCacheService({required this.apiEndPoint});

  final String apiEndPoint;

  Future<Map<String, dynamic>?> getData() async {
    String endpointValueKey = '$apiEndPoint/value';
    int? saveTime = await getValueTime();
    if (saveTime == null) {
      return null;
    }
    if (saveTime > DateTime.now().microsecondsSinceEpoch) {
      setValueTime(expiryTimeInSeconds: 0);
      return null;
    }

    final localBD = await SharedPreferences.getInstance();
    printLog("${localBD.getString(endpointValueKey)}");
    String? savedStringJSON = localBD.getString(endpointValueKey);
    if (savedStringJSON == null) {
      return null;
    }
    Map<String, dynamic> savedJSON = json.decode(savedStringJSON);
    return savedJSON;
  }

  Future<int?> getValueTime() async {
    String endpointDateKey = '$apiEndPoint/date';
    final localBD = await SharedPreferences.getInstance();
    int? savedValueTime = localBD.getInt(endpointDateKey);
    return savedValueTime;
  }

  Future<bool> setValueTime({int expiryTimeInSeconds = 2}) async {
    String endpointDateKey = '$apiEndPoint/date';
    final localBD = await SharedPreferences.getInstance();
    DateTime now = DateTime.now();
    log("getAllCategories:endpointDateKey: $endpointDateKey : value : ${now.add(Duration(hours: expiryTimeInSeconds)).millisecondsSinceEpoch}");
    return await localBD.setInt(endpointDateKey,
        now.add(Duration(hours: expiryTimeInSeconds)).millisecondsSinceEpoch);
  }

  Future setData(Map<String, dynamic> map) async {
    String endpointDateKey = '$apiEndPoint/value';
    final localBD = await SharedPreferences.getInstance();
    String jsonString = json.encode(map);
    bool result = await localBD.setString(endpointDateKey, jsonString);
    result = await setValueTime();
    log("setData: ${result}");
   return result;

  }
  static removeAllLocalData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userMapString=await LocalStorage.getUserInformation();
    String? jwt=await LocalStorage.getJWT();
    LocalStorage.savedUserInformation(userMapString??"");
    LocalStorage.savedJWT(jwt??"");
    String? wishMapString=preferences.getString(WishController.wishProduct);
    await preferences.clear();
    preferences.setString(WishController.wishProduct,wishMapString??"");
  }
}
