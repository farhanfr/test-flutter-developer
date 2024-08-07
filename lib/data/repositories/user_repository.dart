import 'dart:io';

import 'package:test_flutter_developer_enterkomputer/data/repositories/repositories.dart';
import 'package:test_flutter_developer_enterkomputer/helper/helper.dart';
import 'package:test_flutter_developer_enterkomputer/main.dart';

class UserRepository{

  final ApiProvider _api = ApiProvider();
  final String apiKey = Config.apiKey;

  final AuthRepository _authRepository = AuthRepository();


   Future<void> addFavoriteByUser({required int movieId}) async {
   await _api.post(
        "/account/8927813/favorite?api_key=$apiKey&session_id=${_authRepository.getSession()}",
        body: {
          'media_type':'movie',
          'media_id':movieId,
          'favorite':true
        },
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
  }

  Future<void> addWatchlistByUser({required int movieId}) async {
   await _api.post(
        "/account/8927813/watchlist?api_key=$apiKey&session_id=${_authRepository.getSession()}",
        body: {
          'media_type':'movie',
          'media_id':movieId,
          'watchlist':true
        },
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
  }

}