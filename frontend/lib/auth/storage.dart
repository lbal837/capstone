import 'dart:convert';

import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Extend CognitoStorage with Shared Preferences to persist account
/// login sessions
class Storage extends CognitoStorage {
  final SharedPreferences _prefs;

  Storage(this._prefs);

  @override
  Future getItem(String key) async {
    try {
      final item = _prefs.getString(key);
      if (item == null) {
        return null;
      }

      return json.decode(item);
    } on Object catch (e) {
      debugPrint(e as String?);

      return null;
    }
  }

  @override
  Future setItem(String key, dynamic value) async {
    await _prefs.setString(key, json.encode(value));

    return getItem(key);
  }

  @override
  Future removeItem(String key) async {
    final item = await getItem(key);
    if (item != null) {
      await _prefs.remove(key);

      return item;
    }

    return null;
  }

  @override
  Future<void> clear() async {
    await _prefs.clear();
  }
}

class MemoryStorage extends CognitoStorage {
  @override
  Future<dynamic> setItem(String key, dynamic value) async {
    _dataMemory[key] = value;

    return _dataMemory[key];
  }

  @override
  Future<dynamic> getItem(String key) async {
    final item = _dataMemory[key];
    if (item != null) {
      return item;
    }

    return null;
  }

  @override
  Future<dynamic> removeItem(String key) async {
    return _dataMemory.remove(key);
  }

  @override
  Future<void> clear() async {
    _dataMemory = {};
  }
}

Map<String, dynamic> _dataMemory = {};
