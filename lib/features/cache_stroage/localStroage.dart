import 'package:fgi_y2j/config/helper/helperFunction.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String USER_INFO='USER_INFO';
const String USER_JWT='USER_JWT';

class LocalStorage{
  ///saved user Information
 static Future<bool> savedUserInformation(String value) async {
    final localBD=await SharedPreferences.getInstance();
    return localBD.setString(USER_INFO, value);
  }
  static Future<String?> getUserInformation() async {
    final localBD=await SharedPreferences.getInstance();
    printLog("${localBD.getString(USER_INFO)}");
    return localBD.getString(USER_INFO);
  }
  ///saved jwt
 static Future<bool> savedJWT(String value) async {
    final localBD=await SharedPreferences.getInstance();
    return localBD.setString(USER_JWT, value);
  }
 static Future<String?> getJWT() async {
    final localBD=await SharedPreferences.getInstance();
    printLog("${localBD.getString(USER_JWT)}");
    return localBD.getString(USER_JWT);
  }

}