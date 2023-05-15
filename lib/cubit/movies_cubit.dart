import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  MoviesCubit() : super(MoviesState());

  var selected = <int>[];

  Future<void> loadSeats() async {
    int seats = 35;
    selected = [];
    emit(MoviesState(status: MoviesStatus.loading, seats: seats));
    await Future.delayed(const Duration(seconds: 1));
    final busy = <int>[];
    for (var i = 0; i < 15; i++) {
      final x = Random().nextInt(seats);
      busy.add(x);
    }
    emit(MoviesState(
      status: MoviesStatus.loaded,
      seats: seats,
      empty: [0, 6],
      selected: selected,
      busy: busy,
    ));
  }

  Future<void> select(int index) async {
    if (selected.contains(index)) {
      selected.remove(index);
    } else {
      selected.add(index);
    }
    emit(state.copyWith(selected: selected));
  }

  Future<void> book() async {
    emit(state.copyWith(status: MoviesStatus.booked));
  }
}
