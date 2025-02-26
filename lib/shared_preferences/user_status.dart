import 'package:shared_preferences/shared_preferences.dart';

class UserStatus {
  /// ✅ Check if user is logged in
  Future<bool> isLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool('isLoggedIn') ?? false;
  }

  /// ✅ Set login status dynamically
  Future<void> setLoggedIn(bool isLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('isLoggedIn', isLoggedIn); // ✅ Fix
  }

  /// ✅ Delete a specific key
  Future<void> deleteLoggedIn(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(key); // ✅ Added await for consistency
  }

  /// ✅ Save user phone number
  Future<void> setPhoneNumber(String phone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('phoneNumber', phone);
  }

  /// ✅ Retrieve user phone number
  Future<String?> getPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('phoneNumber');
  }

  /// ✅ Save student ID (New addition)
  Future<void> setStudentId(String studentId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('studentId', studentId);
  }

  /// ✅ Retrieve student ID (New addition)
  Future<String?> getStudentId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('studentId');
  }
}
