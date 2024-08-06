part of 'watchlist_favourite_movies_bloc.dart';

 class WatchlistFavouriteMoviesState extends Equatable {
  const WatchlistFavouriteMoviesState();
  
  @override
  List<Object> get props => [];
}

class WatchlistFavouriteMoviesInitial extends WatchlistFavouriteMoviesState {}

class WatchlistFavouriteMoviesLoading extends WatchlistFavouriteMoviesState {}

class WatchlistFavouriteMoviesSuccess extends WatchlistFavouriteMoviesState {
  WatchlistFavouriteMoviesSuccess(this.movie);

  final List<Movie> movie;

  @override
  List<Object> get props => [movie];
}

class WatchlistFavouriteMoviesFailure extends WatchlistFavouriteMoviesState {
  final String message;

  WatchlistFavouriteMoviesFailure(this.message);

  @override
  List<Object> get props => [message];
}

