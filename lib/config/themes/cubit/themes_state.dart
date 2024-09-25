// ignore_for_file: must_be_immutable

part of 'themes_cubit.dart';

class ThemesState extends Equatable {
  ThemesState({this.mode});
  String? mode;

  @override
  List<Object?> get props => [mode];

  ThemesState copywith({String? mode}) => ThemesState(mode: mode ?? this.mode);
}

final class ThemesInitial extends ThemesState {}
