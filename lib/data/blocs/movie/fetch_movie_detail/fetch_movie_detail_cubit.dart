import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_flutter_developer_enterkomputer/data/models/models.dart';
import 'package:test_flutter_developer_enterkomputer/data/repositories/repositories.dart';

part 'fetch_movie_detail_state.dart';

class FetchMovieDetailCubit extends Cubit<FetchMovieDetailState> {
  FetchMovieDetailCubit() : super(FetchMovieDetailInitial());

  final MovieRepository _movieRepository = MovieRepository();

  Future<void> load({required int movieId}) async {
    emit(FetchMovieDetailLoading());
    try {
      final response = await _movieRepository.fetchDetailMovie(movieId: movieId);
      emit(FetchMovieDetailSuccess(response.data));
    } catch (error) {
      emit(FetchMovieDetailFailure(error.toString()));
    }
  }

}
