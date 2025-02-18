import 'package:shared_preferences/shared_preferences.dart';

class UserStatus {
  Future<bool> isLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool isLoggedIn = preferences.getBool('isLoggedIn') ?? false;

    return isLoggedIn;
  }

  Future<void> setLoggedIn(bool isLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('isLoggedIn', true);
  }

  Future<void> deleteLoggedIn(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(key);
  }

  Future<void> setPhoneNumber(String phone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('phoneNumber', phone);
  }

  Future<String?> getPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('phoneNumber');
  }
}
