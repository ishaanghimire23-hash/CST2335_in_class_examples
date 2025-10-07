import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

class DataRepository {
  // If running on web → use SharedPreferences
  // Else (Android/Windows) → use EncryptedSharedPreferences
  static final bool _isWeb = kIsWeb;
  static SharedPreferences? _prefs;
  static final EncryptedSharedPreferences _securePrefs =
  EncryptedSharedPreferences();

  static String loginName = "";
  static String firstName = "";
  static String lastName = "";
  static String phoneNumber = "";
  static String email = "";

  static Future<void> loadData() async {
    if (loginName.isEmpty) return;

    if (_isWeb) {
      _prefs ??= await SharedPreferences.getInstance();
      firstName = _prefs!.getString("firstName_$loginName") ?? "";
      lastName = _prefs!.getString("lastName_$loginName") ?? "";
      phoneNumber = _prefs!.getString("phoneNumber_$loginName") ?? "";
      email = _prefs!.getString("email_$loginName") ?? "";
    } else {
      firstName = await _securePrefs.getString("firstName_$loginName") ?? "";
      lastName = await _securePrefs.getString("lastName_$loginName") ?? "";
      phoneNumber =
          await _securePrefs.getString("phoneNumber_$loginName") ?? "";
      email = await _securePrefs.getString("email_$loginName") ?? "";
    }
  }

  static Future<void> saveData() async {
    if (loginName.isEmpty) return;

    if (_isWeb) {
      _prefs ??= await SharedPreferences.getInstance();
      await _prefs!.setString("firstName_$loginName", firstName);
      await _prefs!.setString("lastName_$loginName", lastName);
      await _prefs!.setString("phoneNumber_$loginName", phoneNumber);
      await _prefs!.setString("email_$loginName", email);
    } else {
      await _securePrefs.setString("firstName_$loginName", firstName);
      await _securePrefs.setString("lastName_$loginName", lastName);
      await _securePrefs.setString("phoneNumber_$loginName", phoneNumber);
      await _securePrefs.setString("email_$loginName", email);
    }
  }
}
