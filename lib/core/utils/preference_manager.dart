import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:torath/core/utils/key_catalog.dart';
import 'package:torath/core/utils/properties.dart';

class PreferenceManager {
  static late SharedPreferences sharedPreferencesStorage; //TODO: sala7
  late FlutterSecureStorage secureStorage;
  // static bool isNewUser = true;
  static final _prefrenceManager = PreferenceManager._internal();

  initializeSharedPreferenceManager() async {
    sharedPreferencesStorage = await SharedPreferences.getInstance();
  }

  PreferenceManager._internal() {
    secureStorage = FlutterSecureStorage(aOptions: _getAndroidOptions());
    initializeSharedPreferenceManager();
  }

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
      keyCipherAlgorithm: KeyCipherAlgorithm.RSA_ECB_PKCS1Padding,
      storageCipherAlgorithm: StorageCipherAlgorithm.AES_GCM_NoPadding);

  factory PreferenceManager() {
    return _prefrenceManager;
  }

  static void setNewUser(bool isNewUser) {
    sharedPreferencesStorage.setBool(KeysCatalog.isNewUser, isNewUser);
  }

  static bool? isNewUser() {
    return sharedPreferencesStorage.getBool(KeysCatalog.isNewUser);
  }


}
