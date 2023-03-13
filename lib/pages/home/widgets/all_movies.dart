import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_movies/models/movie_model.dart';
import 'package:flutter_movies/widgets/movie_card.dart';

class AllMovies extends StatelessWidget {
  const AllMovies({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final columns = sqrt(movies.length).toInt();
    return SizedBox(
      width: columns * 320,
      child: Wrap(
          children: List.generate(
        movies.length,
        (index) => Transform.translate(
          offset: Offset(0, index.isEven ? 240 : 0),
          child: MovieCard(
            movie: movies[index],
          ),
        ),
      )),
    );
  }
}
