import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_flutter_developer_enterkomputer/data/models/models.dart';
import 'package:test_flutter_developer_enterkomputer/data/repositories/repositories.dart';

part 'fetch_movie_similar_state.dart';

class FetchMovieSimilarCubit extends Cubit<FetchMovieSimilarState> {
  FetchMovieSimilarCubit() : super(FetchMovieSimilarInitial());

  /// instansiasi movieRepository
  final MovieRepository _movieRepository = MovieRepository();

  /// Fungsi untuk mengambil data similar film
  Future<void> load({required int movieId}) async {
    /// ubah state menjadi FetchMovieSimilarLoading
    emit(FetchMovieSimilarLoading());
    try {
      final response =
          await _movieRepository.fetchSimilarMovie(movieId: movieId);
      emit(FetchMovieSimilarSuccess(response.data));
    } catch (error) {
      emit(FetchMovieSimilarFailure(error.toString()));
    }
  }
}
