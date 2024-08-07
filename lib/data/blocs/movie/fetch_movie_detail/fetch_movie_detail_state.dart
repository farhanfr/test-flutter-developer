part of 'fetch_movie_detail_cubit.dart';

 class FetchMovieDetailState extends Equatable {
  const FetchMovieDetailState();

  @override
  List<Object> get props => [];
}

 class FetchMovieDetailInitial extends FetchMovieDetailState {}

 class FetchMovieDetailLoading extends FetchMovieDetailState {}

class FetchMovieDetailSuccess extends FetchMovieDetailState {
  FetchMovieDetailSuccess(this.movie);

  final Movie movie;

  @override
  List<Object> get props => [movie];
}

class FetchMovieDetailFailure extends FetchMovieDetailState {
  final String message;

  FetchMovieDetailFailure(this.message);

  @override
  List<Object> get props => [message];
}

