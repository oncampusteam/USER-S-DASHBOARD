import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecentlyViewedController extends GetxController {
  static const _key = '_recently_viewed';

  RxList<String> recentlyViewedIds = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadRecentlyViewed();
  }

  Future<void> loadRecentlyViewed() async {
    final prefs = await SharedPreferences.getInstance();
    recentlyViewedIds.value = prefs.getStringList(_key) ?? [];
  }

  Future<void> addRecentlyViewed(String hostelId) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];

    list.remove(hostelId);      
    list.insert(0, hostelId);  

    if (list.length > 20) {
      list.removeLast();
    }

    recentlyViewedIds.value = list;
    await prefs.setStringList(_key, list);
  }

  void clear() async {
    final prefs = await SharedPreferences.getInstance();
    recentlyViewedIds.clear();
    await prefs.remove(_key);
  }
}
