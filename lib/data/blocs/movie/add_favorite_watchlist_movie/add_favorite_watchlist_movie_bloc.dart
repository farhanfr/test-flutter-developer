import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_flutter_developer_enterkomputer/data/repositories/repositories.dart';

part 'add_favorite_watchlist_movie_event.dart';
part 'add_favorite_watchlist_movie_state.dart';

class AddFavoriteWatchlistMovieBloc extends Bloc<AddFavoriteWatchlistMovieEvent,
    AddFavoriteWatchlistMovieState> {
  AddFavoriteWatchlistMovieBloc() : super(AddFavoriteWatchlistMovieInitial()) {
    on<AddFavoriteWatchlistMovieEvent>((event, emit) async {

      /// melakukan instance pada userRepository
      final UserRepository userRepository = UserRepository();

      /// jika event OnAddFavorite dipanggil
      if (event is OnAddFavorite) {
        /// ubah state menjadi AddFavoriteWatchlistMovieLoading
        emit(AddFavoriteWatchlistMovieLoading());
        try {
          /// jalankan fungsi addFavoriteByUser
          await userRepository.addFavoriteByUser(movieId: event.movieId);
          /// jika berhasil maka ubag state menjadi AddFavoriteWatchlistMovieSuccess
          emit(AddFavoriteWatchlistMovieSuccess("Success add to favorite movie"));
        } catch (e) {
          emit(AddFavoriteWatchlistMovieFailure(e.toString()));
        }
      }

      /// jika event OnAddWatchlist dipanggil
      if (event is OnAddWatchlist) {
        /// ubah state menjadi AddFavoriteWatchlistMovieLoading
        emit(AddFavoriteWatchlistMovieLoading());
        try {
          /// jalankan fungsi addWatchlistByUser
          await userRepository.addWatchlistByUser(movieId: event.movieId);
          /// jika berhasil maka ubag state menjadi AddFavoriteWatchlistMovieSuccess
          emit(AddFavoriteWatchlistMovieSuccess("Success add to watchlist movie"));
        } catch (e) {
          /// jika gagal maka ubah state menjadi AddFavoriteWatchlistMovieFailure
          emit(AddFavoriteWatchlistMovieFailure(e.toString()));
        }
      }
    });
  }
}
