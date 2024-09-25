import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:sheek_bazar/Locale/language_cache_helper.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<ChangeLocaleState> {
  LocaleCubit() : super(const ChangeLocaleState(Locale('en')));
  Future<void> getSavedLAnguage() async {
    final String chachedLangugeCode =
        await LanguageCacheHelper().getCachedLanguageCode();
    emit(ChangeLocaleState(Locale(chachedLangugeCode)));
  }

  Future<void> changeLanguage(String languageCode) async {
    await LanguageCacheHelper().cachelanguageCode(languageCode);
    emit(ChangeLocaleState(Locale(languageCode)));
  }
}
