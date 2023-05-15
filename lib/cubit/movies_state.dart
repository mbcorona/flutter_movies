part of 'movies_cubit.dart';

enum MoviesStatus {
  initial,
  loading,
  loaded,
  booked;

  bool get isInitial => this == MoviesStatus.initial;
  bool get isLoading => this == MoviesStatus.loading;
  bool get isLoaded => this == MoviesStatus.loaded;
  bool get isBooked => this == MoviesStatus.booked;
}

class MoviesState {
  MoviesState({
    this.status = MoviesStatus.initial,
    this.seats = 0,
    this.empty = const [],
    this.busy = const [],
    this.selected = const [],
  });
  final MoviesStatus status;
  final int seats;
  final List<int> empty;
  final List<int> busy;
  final List<int> selected;

  int get totalSelected => selected.length;
  int get totalPrice => totalSelected * 8;

  MoviesState copyWith({
    MoviesStatus? status,
    int? seats,
    List<int>? empty,
    List<int>? busy,
    List<int>? selected,
  }) {
    return MoviesState(
      status: status ?? this.status,
      seats: seats ?? this.seats,
      empty: empty ?? this.empty,
      busy: busy ?? this.busy,
      selected: selected ?? this.selected,
    );
  }
}
