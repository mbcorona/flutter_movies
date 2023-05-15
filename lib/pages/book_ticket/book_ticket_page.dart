import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies/cubit/movies_cubit.dart';
import 'package:flutter_movies/models/movie_model.dart';
import 'package:flutter_movies/pages/book_ticket/widgets/day_selector.dart';
import 'package:flutter_movies/pages/book_ticket/widgets/screen.dart';
import 'package:flutter_movies/pages/book_ticket/widgets/seat_selector.dart';
import 'package:flutter_movies/widgets/glass_icon_button.dart';
import 'package:flutter_movies/widgets/scaleup_animation.dart';

class BookTicketPage extends StatelessWidget {
  const BookTicketPage({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MoviesCubit(),
      child: BookTicketView(movie: movie),
    );
  }
}

class BookTicketView extends StatelessWidget {
  const BookTicketView({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    context.read<MoviesCubit>().loadSeats();
    return BlocListener<MoviesCubit, MoviesState>(
      listener: (context, state) {
        if (state.status.isBooked) {
          Navigator.pop(context, true);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              _getHeader(context),
              DateDaySelector(
                onChanged: (value) => context.read<MoviesCubit>().loadSeats(),
              ),
              const SizedBox(height: 30),
              const Screen(),
              const SeatSelector(),
            ],
          ),
        ),
        bottomNavigationBar: const BuyButton(),
      ),
    );
  }

  Padding _getHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          GlassIconButton(
            onTap: () => Navigator.pop(context),
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: RichText(
              textAlign: TextAlign.end,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: movie.name,
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                  ),
                  const TextSpan(
                    text: '\n8:00',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BuyButton extends StatelessWidget {
  const BuyButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleUpAnimation(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ElevatedButton(
            onPressed: () => context.read<MoviesCubit>().book(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            ),
            child: BlocBuilder<MoviesCubit, MoviesState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Buy ${state.totalSelected > 0 ? '${state.totalSelected} tickets' : ''}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      '\$${state.totalPrice}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
