import 'package:shared_preferences/shared_preferences.dart';

//* Storage keys for SharedPreferences

class StorageKeys {
  StorageKeys._();

  static const String accessToken = 'access_token';
  static const String userName = 'user_name';
  static const String userEmail = 'user_email';
  static const String userAge = 'user_age';
  static const String isRegistered = 'is_registered';
  static const String registeredUser = 'registered_user';
}

abstract class AppStorageService {
  Future<String?> getAccessToken();
  Future<void> setAccessToken(String? token);

  Future<String?> getUserName();
  Future<void> setUserName(String? name);

  Future<String?> getUserEmail();
  Future<void> setUserEmail(String? email);

  Future<int?> getUserAge();
  Future<void> setUserAge(int? age);

  Future<bool> isRegistered();
  Future<void> setRegistered(bool value);

  Future<void> saveRegisteredUser(String json);
  Future<String?> getRegisteredUser();

  Future<void> clearAll();
}

//? SharedPreferences implementation of AppStorageService
//* this class is responsible for storing and retrieving data from SharedPreferences.

class SharedPreferencesStorageService implements AppStorageService {
  final SharedPreferences _prefs;
  
  SharedPreferencesStorageService(this._prefs);



  @override
  Future<String?> getAccessToken() async {
    return _prefs.getString(StorageKeys.accessToken);
  }
  
  @override
  Future<void> setAccessToken(String? token) async {
    if (token == null || token.isEmpty) {
      await _prefs.remove(StorageKeys.accessToken);
    } else {
      await _prefs.setString(StorageKeys.accessToken, token);
    }
  }

  @override
  Future<String?> getUserName() async {
    return _prefs.getString(StorageKeys.userName);
  }
  
  @override
  Future<void> setUserName(String? name) async {
    if (name == null || name.isEmpty) {
      await _prefs.remove(StorageKeys.userName);
    } else {
      await _prefs.setString(StorageKeys.userName, name);
    }
  }

  @override
  Future<String?> getUserEmail() async {
    return _prefs.getString(StorageKeys.userEmail);
  }

  @override
  Future<void> setUserEmail(String? email) async {
    if (email == null || email.isEmpty) {
      await _prefs.remove(StorageKeys.userEmail);
    } else {
      await _prefs.setString(StorageKeys.userEmail, email);
    }
  }

  @override
  Future<int?> getUserAge() async {
    return _prefs.getInt(StorageKeys.userAge);
  }

  @override
  Future<void> setUserAge(int? age) async {
    if (age == null) {
      await _prefs.remove(StorageKeys.userAge);
    } else {
      await _prefs.setInt(StorageKeys.userAge, age);
    }
  }

  @override
  Future<bool> isRegistered() async {
    return _prefs.getBool(StorageKeys.isRegistered) ?? false;
  }

  @override
  Future<void> setRegistered(bool value) async {
    await _prefs.setBool(StorageKeys.isRegistered, value);
  }

  @override
  Future<void> saveRegisteredUser(String json) async {
    await _prefs.setString(StorageKeys.registeredUser, json);
  }

  @override
  Future<String?> getRegisteredUser() async {
    return _prefs.getString(StorageKeys.registeredUser);
  }

  @override
  Future<void> clearAll() async {
    await _prefs.clear();
  }
}

