import 'package:hive_flutter/hive_flutter.dart';
import 'package:singapore_transport/data_models/one_map_bus_station.dart';

const String favBox="favouritesBox";

class FavHiveFunctions {
  // Box which will use to store the things
  static final userBox = Hive.box(favBox);

  static createFavourites(Map data) {
        userBox.add(data);
    }
    
    // Create or add multiple data in hive
    static addAllFavourites(List data) {
        userBox.addAll(data);
    }
    
    // Get All data  stored in hive
    static List getAllFavourites() {
        final data =
        userBox.keys.map((key) {
            return userBox.get(key);
        }).toList();
        
        return data.reversed.toList();
    }
    
    // Get data for particular user in hive
    static Map getFavourites(int key) {
        return userBox.get(key);
    }
    
    // update data for particular user in hive
    static updateFavourite(int key, Map data) {
        userBox.put(key, data);
    }
    
    // delete data for particular user in hive
    static deleteFavourite(int key) {
        return userBox.deleteAt(key);
    }
    
    // delete data for particular user in hive
    static deleteAllFavourites() {
        return userBox.deleteAll(userBox.keys);
    }

}

