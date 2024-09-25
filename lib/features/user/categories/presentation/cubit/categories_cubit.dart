// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sheek_bazar/features/user/categories/data/repositories/categories_repo.dart';

import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/utils/app_logger.dart';
import '../../data/models/categories_model.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final CategoriesRepo categoriesRepo;
  CategoriesCubit({required this.categoriesRepo}) : super(CategoriesInitial());
  Future<void> getCategories(BuildContext context) async {
    emit(state.copyWith(loadingCat: true));
    try {
      Map<String, String> body = {};
      body['fetch_categories'] = "1";

      CategoriesModel data = await categoriesRepo.getCategories(body);
      emit(state.copyWith(
          Categories: CategoriesModel(categories: [], subcategories: [])));
      emit(state.copyWith(Categories: data));
    } catch (e) {
      logger.e(e);

      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
    emit(state.copyWith(loadingCat: false));
  }
}
