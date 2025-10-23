import 'package:riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesNotifier extends StateNotifier<Map<String, dynamic>> {
  PreferencesNotifier() : super({});

  Future<void> fetchSharedPreferences() async {
    var prefs = await SharedPreferences.getInstance();
    state = convertToMap(prefs);
  }

  Map<String, dynamic> convertToMap(SharedPreferences prefs) {
    Map<String, dynamic> prefMap = {};
    for (var key in prefs.getKeys()) {
      prefMap[key] = prefs.get(key);
    }
    return prefMap;
  }

  updatePreferences(String key, String value) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    state = convertToMap(prefs);
  }
}

final preferencesProvider =
    StateNotifierProvider<PreferencesNotifier, Map<String, dynamic>>((ref) {
      return PreferencesNotifier();
    });
