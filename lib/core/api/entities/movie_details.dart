import 'movie.dart';

class MovieDetailsEntity extends MovieEntity {
  final String releaseDate;
  final String overview;

  const MovieDetailsEntity({
    required super.id,
    required super.title,
    required super.posterPath,
    required super.voteAverage,
    required this.releaseDate,
    required this.overview,
  });

  factory MovieDetailsEntity.fromJson(Map<String, dynamic> json) {
    return MovieDetailsEntity(
      id: json["id"],
      title: json["title"],
      posterPath: "https://image.tmdb.org/t/p/w500${json["poster_path"]}",
      voteAverage: json["vote_average"],
      releaseDate: json["release_date"],
      overview: json["overview"],
    );
  }

  @override
  List<Object?> get props => [...super.props, releaseDate, overview];
}
