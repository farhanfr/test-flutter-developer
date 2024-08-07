import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:test_flutter_developer_enterkomputer/data/models/models.dart';
import 'package:test_flutter_developer_enterkomputer/data/repositories/repositories.dart';
import 'package:test_flutter_developer_enterkomputer/helper/api_provider.dart';
import 'package:test_flutter_developer_enterkomputer/main.dart';

class MovieRepository {
  final ApiProvider _api = ApiProvider();
  final gs = GetStorage();

  final String apiKey = Config.apiKey;

  final AuthRepository _authRepository = AuthRepository();

  
  Future<FetchMovieResponse> fetchDetailMovie(
      {required int movieId}) async {
    final response = await _api.get(
        "/movie/$movieId?api_key=$apiKey",
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
    Map<String, dynamic> data = {};

    if (response.statusCode == 200) {
      data = {"data": response.data};
    } else {
      throw "Something when wrong";
    }

    return FetchMovieResponse.fromJson(data);
  }

  Future<FetchMovieListResponse> fetchSimilarMovie(
      {required int movieId}) async {
    final response = await _api.get(
        "/movie/$movieId/similar?api_key=$apiKey",
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
    Map<String, dynamic> data = {};

    if (response.statusCode == 200) {
      data = {"data": response.data['results']};
    } else {
      throw "Something when wrong";
    }

    return FetchMovieListResponse.fromJson(data);
  }
  
  Future<FetchMovieListResponse> fetchWatchlistMovieUser(
      {required int currentPage}) async {
    final response = await _api.get(
        "/account/8927813/watchlist/movies?api_key=$apiKey&session_id=${_authRepository.getSession()}&page=$currentPage",
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
    Map<String, dynamic> data = {};

    if (response.statusCode == 200) {
      data = {"data": response.data['results']};
    } else {
      throw "Something when wrong";
    }

    return FetchMovieListResponse.fromJson(data);
  }

  Future<FetchMovieListResponse> fetcFavouriteMovieUser(
      {required int currentPage}) async {
    final response = await _api.get(
        "/account/8927813/favorite/movies?api_key=$apiKey&session_id=${_authRepository.getSession()}&page=$currentPage",
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
    Map<String, dynamic> data = {};

    if (response.statusCode == 200) {
      data = {"data": response.data['results']};
    } else {
      throw "Something when wrong";
    }

    return FetchMovieListResponse.fromJson(data);
  }

  Future<FetchMovieListResponse> fetchNowPlayingMovie(
      {required int currentPage}) async {
    final response = await _api.get(
        "/movie/now_playing?api_key=$apiKey&page=$currentPage",
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
    Map<String, dynamic> data = {};

    if (response.statusCode == 200) {
      data = {"data": response.data['results']};
    } else {
      throw "Something when wrong";
    }

    return FetchMovieListResponse.fromJson(data);
  }

  Future<FetchMovieListResponse> fetchPopularMovie(
      {required int currentPage}) async {
    final response = await _api.get(
        "/movie/popular?api_key=$apiKey&page=$currentPage",
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
    Map<String, dynamic> data = {};

    if (response.statusCode == 200) {
      data = {"data": response.data['results']};
    } else {
      throw "Something when wrong";
    }

    return FetchMovieListResponse.fromJson(data);
  }


}
