import 'package:shared_preferences/shared_preferences.dart';

Future<bool> setLoginStatus(bool status) async {
  final prefsObject = await SharedPreferences.getInstance();
  return prefsObject.setBool('isLogedIn', status);
}

Future<bool> getLoginStatus() async {
  final prefsObject = await SharedPreferences.getInstance();
  return prefsObject.getBool('isLogedIn')?? false;// if null then return false
}
