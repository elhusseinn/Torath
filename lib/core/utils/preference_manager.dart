import 'package:shared_preferences/shared_preferences.dart';
import 'package:torath/core/utils/key_catalog.dart';

class PreferenceManager {
  static late SharedPreferences sharedPreferencesStorage; //TODO: sala7
  // static bool isNewUser = true;

  PreferenceManager() {
    initializeSharedPreferenceManager();
  }
  initializeSharedPreferenceManager() async {
    sharedPreferencesStorage = await SharedPreferences.getInstance();

  }

  static void setNewUser(bool isNewUser) {
    sharedPreferencesStorage.setBool(KeysCatalog.isNewUser, isNewUser);
  }
  static bool? isNewUser() {
    return sharedPreferencesStorage.getBool(KeysCatalog.isNewUser);
  }


}
