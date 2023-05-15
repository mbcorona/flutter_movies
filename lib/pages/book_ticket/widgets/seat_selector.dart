import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies/cubit/movies_cubit.dart';

class SeatSelector extends StatefulWidget {
  const SeatSelector({
    super.key,
  });

  @override
  State<SeatSelector> createState() => _SeatSelectorState();
}

class _SeatSelectorState extends State<SeatSelector> {
  int columns = 7;

  void select(int index) {
    context.read<MoviesCubit>().select(index);
  }

  SeatStatus getStatus(int index) {
    final cubit = context.read<MoviesCubit>().state;
    if (cubit.empty.contains(index)) {
      return SeatStatus.empty;
    }
    if (cubit.selected.contains(index)) {
      return SeatStatus.selected;
    }
    if (cubit.busy.contains(index)) {
      return SeatStatus.busy;
    }
    return SeatStatus.free;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesCubit, MoviesState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.width / columns * state.seats / columns,
          child: Stack(
            children: [
              GridView.count(
                crossAxisCount: columns,
                children: List.generate(
                  state.seats,
                  (index) => Seat(
                    status: getStatus(index),
                    onTap: () => select(index),
                  ),
                ),
              ),
              if (state.status.isLoading)
                ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.width / columns * state.seats / columns,
                    ),
                  ),
                ),
              if (state.status.isLoading)
                const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: .5,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

enum SeatStatus { empty, free, busy, selected }

class Seat extends StatelessWidget {
  const Seat({super.key, required this.status, this.onTap});

  final SeatStatus status;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    if (status == SeatStatus.empty) {
      return const SizedBox.shrink();
    }
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: status == SeatStatus.selected
            ? Colors.white
            : status == SeatStatus.busy
                ? Colors.white24
                : null,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white24, width: 1),
      ),
      child: InkWell(
        onTap: status == SeatStatus.busy ? null : onTap,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
