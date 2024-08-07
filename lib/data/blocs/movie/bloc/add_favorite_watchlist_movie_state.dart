part of 'add_favorite_watchlist_movie_bloc.dart';

class AddFavoriteWatchlistMovieState extends Equatable {
  const AddFavoriteWatchlistMovieState();

  @override
  List<Object> get props => [];
}

class AddFavoriteWatchlistMovieInitial extends AddFavoriteWatchlistMovieState {}

class AddFavoriteWatchlistMovieLoading extends AddFavoriteWatchlistMovieState {}

class AddFavoriteWatchlistMovieSuccess extends AddFavoriteWatchlistMovieState {
  final String message;

  AddFavoriteWatchlistMovieSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class AddFavoriteWatchlistMovieFailure extends AddFavoriteWatchlistMovieState {
  final String message;

  AddFavoriteWatchlistMovieFailure(this.message);

  @override
  List<Object> get props => [message];
}
