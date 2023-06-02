import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _prefs;

  static Future<void> initializeSharedPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static SharedPreferences get prefs {
    assert(
        _prefs != null, 'Call initializeSharedPrefs() before accessing prefs!');
    return _prefs!;
  }

  static String userType() {
    return prefs.getString(USERTYPE) ?? TYPEBUYER;
  }

  static Future<void> setUserType(String type) async {
    await prefs.setString(USERTYPE, type);
  }

  static String userId() {
    return prefs.getString(USERID) ?? "1111";
  }

  static Future<void> setUserId(String id) async {
    await prefs.setString(USERID, id);
  }

  static bool isUserFirstTime() {
    return prefs.getBool(FIRST_TIME) ?? false;
  }

  static Future<void> setUserFirstTimeStatus(bool status) async {
    await prefs.setBool(FIRST_TIME, status);
  }

  static bool isUserVerified() {
    return prefs.getBool(IS_VERIFIED) ?? false;
  }

  static Future<void> setVerificationStatus(bool status) async {
    await prefs.setBool(IS_VERIFIED, status);
  }
}

const USERTYPE = "usertype";
const TYPEBUYER = "Buyer";
const TYPESELLER = "Seller";
const USERID = "uid";
const FIRST_TIME = "firsttime";
const IS_VERIFIED = "false";
