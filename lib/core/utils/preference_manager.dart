import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:torath/core/utils/key_catalog.dart';
import 'package:torath/cubits/audioManagementCubit/audio_management_cubit.dart';
import 'package:torath/cubits/miniPlayerManagementCubit/mini_player_management_cubit.dart';

class PreferenceManager {
  static late SharedPreferences sharedPreferencesStorage; //TODO: sala7
  late FlutterSecureStorage secureStorage;
  // static bool isNewUser = true;
  static final _prefrenceManager = PreferenceManager._internal();
  final audioManagementCubit = AudioManagementCubit();
  final miniPlayerManagementCubit = MiniPlayerManagementCubit();

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
