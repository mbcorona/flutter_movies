import 'package:flutter/material.dart';
import 'package:flutter_movies/models/movie_model.dart';
import 'package:flutter_movies/pages/book_ticket/book_ticket_page.dart';
import 'package:flutter_movies/pages/ticket/ticket_page.dart';
import 'package:flutter_movies/widgets/app_chip.dart';
import 'package:flutter_movies/widgets/glass_icon_button.dart';
import 'package:flutter_movies/widgets/scaleup_animation.dart';
import 'package:flutter_movies/widgets/translateup_animation.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0,
            child: Hero(
              tag: movie.name,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  movie.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ScaleUpAnimation(
                      child: GlassIconButton(
                        onTap: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const ScaleUpAnimation(
                      child: GlassIconButton(
                          icon: Icon(
                        Icons.favorite_outline,
                        color: Colors.white,
                      )),
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TranslateUpAnimation(
                          child: Text(
                            movie.name,
                            style: const TextStyle(
                              shadows: [
                                Shadow(
                                  color: Colors.black54,
                                  offset: Offset(0, 1),
                                  blurRadius: 10,
                                ),
                              ],
                              color: Colors.white,
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        TranslateUpAnimation(
                          duration: const Duration(milliseconds: 2000),
                          child: _getMovieChips(),
                        ),
                        const SizedBox(height: 15),
                        TranslateUpAnimation(
                          duration: const Duration(milliseconds: 2400),
                          child: ElevatedButton(
                            onPressed: () => _bookTicket(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                            ),
                            child: const Text(
                              'Book ticket',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _bookTicket(BuildContext context) {
    Navigator.of(context)
        .push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 1800),
        reverseTransitionDuration: const Duration(milliseconds: 700),
        pageBuilder: (context, animation, _) {
          const begin = Offset(0, 1);
          const end = Offset.zero;
          const curve = Curves.fastEaseInToSlowEaseOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: BookTicketPage(movie: movie),
          );
        },
      ),
    )
        .then((value) async {
      if (value) {
        await Future.delayed(const Duration(milliseconds: 500));
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: ((context, animation, secondaryAnimation) => FadeTransition(
                  opacity: animation,
                  child: TicketPage(
                    movie: movie,
                  ),
                )),
          ),
        );
      }
    });
  }

  Row _getMovieChips() {
    return Row(
      children: [
        AppChip(
          text: 'IMDB 8.1',
          color: Colors.yellow,
          textColor: Colors.black,
        ),
        const SizedBox(width: 9),
        AppChip(text: 'Text1'),
        const SizedBox(width: 9),
        AppChip(text: 'Text2'),
      ],
    );
  }
}
