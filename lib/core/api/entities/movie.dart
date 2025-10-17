import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  final int id;
  final String title;
  final String posterPath;
  final double voteAverage;

  const MovieEntity({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.voteAverage,
  });

  factory MovieEntity.fromJson(Map<String, dynamic> json) {
    return MovieEntity(
      id: json["id"],
      title: json["title"],
      posterPath: "https://image.tmdb.org/t/p/w500${json["poster_path"]}",
      voteAverage: json["vote_average"],
    );
  }

  @override
  List<Object?> get props => [id, title, posterPath, voteAverage];
}

class MoviesPage extends Equatable{
  final List<MovieEntity> movies;
  final int total;

  const MoviesPage({required this.movies, required this.total});

  @override
  List<Object?> get props => [movies, total];
}