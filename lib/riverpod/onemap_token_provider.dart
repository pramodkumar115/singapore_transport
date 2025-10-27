

import 'dart:convert';

import 'package:http/http.dart';
import 'package:riverpod/legacy.dart';
import 'package:singapore_transport/OneMap/one_map_service.dart';

class OneMapTokenModel {
  String? accessToken;
  DateTime? expiry;

  OneMapTokenModel({this.accessToken, this.expiry});
}

class OneMapTokenNotifier extends StateNotifier<OneMapTokenModel> {
  OneMapTokenNotifier(): super(OneMapTokenModel(accessToken: "", expiry: DateTime.now()));
  
  Future<void> fetchOneMapToken() async {
    Response tokenData = await getOneMapToken();
    if (tokenData.statusCode == 200) {
      var data = jsonDecode(tokenData.body);
      
      var expiry = DateTime.fromMillisecondsSinceEpoch(int.parse(data['expiry_timestamp']) * 1000);
      state = OneMapTokenModel(accessToken: data["access_token"], expiry: expiry);
    }
  }
}

final oneMapTokenProvider =
    StateNotifierProvider<OneMapTokenNotifier, OneMapTokenModel>((ref) {
      return OneMapTokenNotifier();
    });