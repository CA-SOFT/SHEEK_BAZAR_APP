// ignore_for_file: must_be_immutable, non_constant_identifier_names

part of 'categories_cubit.dart';

class CategoriesState extends Equatable {
  CategoriesState({this.Categories, this.loadingCat = false});
  CategoriesModel? Categories;
  bool loadingCat;
  @override
  List<Object?> get props => [Categories, loadingCat];
  CategoriesState copyWith({CategoriesModel? Categories, bool? loadingCat}) =>
      CategoriesState(
          Categories: Categories ?? this.Categories,
          loadingCat: loadingCat ?? this.loadingCat);
}

class CategoriesInitial extends CategoriesState {}
