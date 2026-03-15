import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//* Storage keys for SharedPreferences

class StorageKeys {
  StorageKeys._();

  static const String accessToken = 'access_token';
  static const String userName = 'user_name';
}

abstract class AppStorageService {


  Future<String?> getAccessToken();

  Future<void> setAccessToken(String? token);

  Future<String?> getUserName();

  Future<void> setUserName(String? name);

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
  Future<void> clearAll() async {
    await _prefs.clear();
  }

}

