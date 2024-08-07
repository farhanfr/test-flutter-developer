import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_flutter_developer_enterkomputer/data/repositories/repositories.dart';

part 'add_favorite_watchlist_movie_event.dart';
part 'add_favorite_watchlist_movie_state.dart';

class AddFavoriteWatchlistMovieBloc extends Bloc<AddFavoriteWatchlistMovieEvent,
    AddFavoriteWatchlistMovieState> {
  AddFavoriteWatchlistMovieBloc() : super(AddFavoriteWatchlistMovieInitial()) {
    on<AddFavoriteWatchlistMovieEvent>((event, emit) async {
      final UserRepository userRepository = UserRepository();

      if (event is OnAddFavorite) {
        emit(AddFavoriteWatchlistMovieLoading());
        try {
          await userRepository.addFavoriteByUser(movieId: event.movieId);
          emit(AddFavoriteWatchlistMovieSuccess("Success add to favorite movie"));
        } catch (e) {
          emit(AddFavoriteWatchlistMovieFailure(e.toString()));
        }
      }

      if (event is OnAddWatchlist) {
        emit(AddFavoriteWatchlistMovieLoading());
        try {
          await userRepository.addWatchlistByUser(movieId: event.movieId);
          emit(AddFavoriteWatchlistMovieSuccess("Success add to watchlist movie"));
        } catch (e) {
          emit(AddFavoriteWatchlistMovieFailure(e.toString()));
        }
      }
    });
  }
}
