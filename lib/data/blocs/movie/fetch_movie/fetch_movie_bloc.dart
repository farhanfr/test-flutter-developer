import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_flutter_developer_enterkomputer/data/models/models.dart';
import 'package:test_flutter_developer_enterkomputer/data/repositories/movie_repository.dart';

part 'fetch_movie_event.dart';
part 'fetch_movie_state.dart';

class FetchMovieBloc extends Bloc<FetchMovieEvent, FetchMovieState> {
  FetchMovieBloc() : super(FetchMovieInitial()) {
    final MovieRepository movieRepository = MovieRepository();
    on<FetchMovieEvent>((event, emit) async {
      if (event is OnNowPlayingMovie) {
        emit(FetchMovieNowPlayingLoading());
        final result =
            await movieRepository.fetchNowPlayingMovie(currentPage: event.page);
        emit(FetchMovieNowPlayingSuccess(result.data));
      }

      if (event is OnPopularMovie) {
        emit(FetchMoviePopularLoading());
        final result =
            await movieRepository.fetchPopularMovie(currentPage: event.page);
        emit(FetchMoviePopularSuccess(result.data));
      }
    });
  }
}
