import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper {
  static late final SharedPreferences _pref;

  static get historyKey => 'history';

  static init() async {
    _pref = await SharedPreferences.getInstance();
  }

  static const String _isLoggedIn = 'isLoggedIn';

  static bool getIsLoggedIn() {
    return _pref.getBool(_isLoggedIn) ?? false;
  }

  static void setIsLoggedIn(bool value) {
    _pref.setBool(_isLoggedIn, value);
  }

  static List<String> getHistory() {
    return _pref.getStringList(historyKey) ?? [];
  }


  Future<void> addHistory(String value) async {
    List<String> history = getHistory();
    if (!history.contains(value)) {
      history.add(value);
      await _pref.setStringList(historyKey, history);
    }
  }

}


