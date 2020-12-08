import 'package:online_shop/model/profile.dart';
import 'package:online_shop/repository/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin Cache {
  static String _token = "TOKEN";
  static String _user = "USER";
  static SharedPreferences _pref;

  Future<SharedPreferences> get shared async {
    if (_pref == null) _pref = await SharedPreferences.getInstance();
    return _pref;
  }

  Future<bool> saveUserToken(String token) async {
    var cache = await shared;
    bool status = await cache.setString("$_token", token);
    return status;
  }

  Future<bool> removeUserToken() async {
    var cache = await shared;
    bool status = await cache.setString("$_token", null);
    return status;
  }

  Future<bool> saveUser(Profile profile) async {
    var cache = await shared;
    bool status = await cache.setString("$_user", profile.toRawJson());
    return status;
  }

  Future<bool> removeUser() async {
    var cache = await shared;
    bool status = await cache.setString("$_user", null);
    return status;
  }

  Future<Profile> getUser() async {
    var prefs = await shared;
    Profile value = Profile.fromRawJson(prefs.getString("$_user"));

    return value;
  }

  Future<bool> isRegisteredUser() async {
    var value = await getUserToken();

    if (value == null || value.isEmpty)
      return false;
    else
      return true;
  }

  Future<String> getUserToken() async {
    var prefs = await shared;
    String value = prefs.getString("$_token");

    return value;
  }

  Future<String> getLocale() async {
    var cache = await shared;
    String locale = cache.getString('locale');
    print(locale);
    return locale;
  }
}
