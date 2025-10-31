import 'package:riverpod/legacy.dart';
import 'package:singapore_transport/HiveFunctions/fav_hive_functions.dart';

class FavouritesNotifier extends StateNotifier<List> {
  FavouritesNotifier() : super(List.empty());

  fetchFavourites(){
    state = FavHiveFunctions.getAllFavourites();
  }

  updateFavourites(Map station) {
    FavHiveFunctions.createFavourites(station);
    fetchFavourites();
  }

  deleteFavourite(int key) {
    FavHiveFunctions.deleteFavourite(key);
    fetchFavourites();
  }

  deleteAllFavourites() {
    FavHiveFunctions.deleteAllFavourites();
    fetchFavourites();
  }
}

final favouritesProvider = 
StateNotifierProvider<FavouritesNotifier, List>((ref) {
  return FavouritesNotifier();
});