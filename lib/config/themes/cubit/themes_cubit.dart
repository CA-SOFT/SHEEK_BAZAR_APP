import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sheek_bazar/core/utils/cache_helper.dart';

part 'themes_state.dart';

class ThemesCubit extends Cubit<ThemesState> {
  ThemesCubit() : super(ThemesInitial());

  Future<void> knowMobileMode() async {
    var appMode = CacheHelper.getData(key: "Mode");
    if (appMode == null) {
      var darkMode = Brightness.dark;
      // WidgetsBinding.instance.platformDispatcher.platformBrightness;
      if (darkMode == Brightness.dark) {
        emit(state.copywith(mode: "dark"));
      } else {
        emit(state.copywith(mode: "light"));
      }
    } else {
      emit(state.copywith(mode: appMode));
    }
  }

  Future<void> changeMode(String value) async {
    await CacheHelper.saveData(key: "Mode", value: value);
    emit(state.copywith(mode: value));
  }
}
