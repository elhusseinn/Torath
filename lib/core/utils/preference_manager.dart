import 'package:shared_preferences/shared_preferences.dart';
import 'package:torath/core/utils/key_catalog.dart';

class PreferenceManager {
  static late SharedPreferences sharedPreferencesStorage; //TODO: sala7

  PreferenceManager() {
    initializeSharedPreferenceManager();
  }
  initializeSharedPreferenceManager() async {
    sharedPreferencesStorage = await SharedPreferences.getInstance();
    setNewUser();
  }

  static bool? isNewUser() {
    return sharedPreferencesStorage.getBool(KeysCatalog.isNewUser);
  }

  void setNewUser() {
    sharedPreferencesStorage.setBool(KeysCatalog.isNewUser, true);
  }

  void invalidateNewUser() {
    sharedPreferencesStorage.setBool(KeysCatalog.isNewUser, false);
  }
}
