import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesController extends GetxController {
  static const _key = 'favorite_hostels';

  RxSet<String> favoriteIds = <String>{}.obs; // reactive set

  @override
  void onInit() {
    super.onInit();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];
    favoriteIds.value = list.toSet();
  }

  Future<void> toggleFavorite(String hostelId) async {
    final prefs = await SharedPreferences.getInstance();
    final favs = favoriteIds.toSet();

    if (favs.contains(hostelId)) {
      favs.remove(hostelId);
    } else {
      favs.add(hostelId);
    }

    favoriteIds.value = favs;
    await prefs.setStringList(_key, favs.toList());
  }

  bool isFavorite(String hostelId) {
    return favoriteIds.contains(hostelId);
  }
}
