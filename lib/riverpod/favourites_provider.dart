import 'package:riverpod/legacy.dart';
import 'package:singapore_transport/Helpers/util.dart';

class FavouritesNotifier extends StateNotifier<List<int>> {
  FavouritesNotifier() : super(List.empty());

  fetchFavourites() async{
    state = await getFavoritesFromFile();
  }

  updateFavourites(ids) async {
    await saveFavoritesFile(ids);
    await fetchFavourites();
  }
}

final favouritesProvider = 
StateNotifierProvider<FavouritesNotifier, List<int>>((ref) {
  return FavouritesNotifier();
});