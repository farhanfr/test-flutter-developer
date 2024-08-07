class FetchMovieListResponse {
  List<Movie> data;

  FetchMovieListResponse({
    required this.data,
  });

  factory FetchMovieListResponse.fromJson(Map<String, dynamic> json) =>
      FetchMovieListResponse(
        data: List<Movie>.from(json["data"].map((x) => Movie.fromJson(x))),
      );
}

class FetchMovieResponse {
  Movie data;

  FetchMovieResponse({
    required this.data,
  });

  factory FetchMovieResponse.fromJson(Map<String, dynamic> json) =>
      FetchMovieResponse(
        data: Movie.fromJson(json["data"]),
      );
}

class Movie {
  bool adult;
  String backdropPath;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  Movie({
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        adult: json["adult"],
        backdropPath: json["backdrop_path"] ?? "-",
        id: json["id"],
        originalLanguage: json["original_language"] ?? "-",
        originalTitle: json["original_title"] ?? "-",
        overview: json["overview"] ?? "-",
        popularity: json["popularity"] != null ? json["popularity"].toDouble() : 0.0,
        posterPath: json["poster_path"] ?? "-",
        releaseDate: json["release_date"] ?? "-",
        title: json["title"] ?? "-",
        video: json["video"] ?? false,
        voteAverage: json["vote_average"] != null ? json["vote_average"].toDouble() : 0.0,
        voteCount: json["vote_count"] ?? 0,
      );
}
