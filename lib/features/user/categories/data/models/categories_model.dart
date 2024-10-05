class CategoriesModel {
  List<Category?>? categories;
  List<SubCategory?>? subcategories;

  CategoriesModel({this.categories, this.subcategories});

  CategoriesModel.fromJson(Map<String, dynamic>? json) {
    if (json?['categories'] != null) {
      categories = <Category>[];
      json?['categories'].forEach((v) {
        categories!.add(Category.fromJson(v));
      });
    }
    if (json?['sub_categories'] != null) {
      subcategories = <SubCategory>[];
      json?['sub_categories'].forEach((v) {
        subcategories!.add(SubCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categories'] = categories?.map((v) => v?.toJson()).toList();
    data['sub_categories'] = subcategories?.map((v) => v?.toJson()).toList();
    return data;
  }
}

class Category {
  String? categoryid;
  String? categorytype;
  String? categorynamear;
  String? categorynameen;
  String? categorynameku;
  String? categoryimg;

  Category(
      {this.categoryid,
      this.categorytype,
      this.categorynamear,
      this.categorynameen,
      this.categorynameku,
      this.categoryimg});

  Category.fromJson(Map<String, dynamic>? json) {
    categoryid = json?['category_id'];
    categorytype = json?['category_type'];
    categorynamear = json?['category_name_ar'];
    categorynameen = json?['category_name_en'];
    categorynameku = json?['category_name_ku'];
    categoryimg = json?['category_img'];
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryid;
    data['category_type'] = categorytype;
    data['category_name_ar'] = categorynamear;
    data['category_name_en'] = categorynameen;
    data['category_name_ku'] = categorynameku;
    data['category_img'] = categoryimg;
    return data;
  }
}

class SubCategory {
  String? categoryid;
  String? categorytype;
  String? categorynamear;
  String? categorynameen;
  String? categorynameku;
  String? categoryimg;
  String? categoryParent;

  SubCategory(
      {this.categoryid,
      this.categorytype,
      this.categorynamear,
      this.categorynameen,
      this.categorynameku,
      this.categoryParent,
      this.categoryimg});

  SubCategory.fromJson(Map<String, dynamic>? json) {
    categoryid = json?['category_id'];
    categorytype = json?['category_type'];
    categorynamear = json?['category_name_ar'];
    categorynameen = json?['category_name_en'];
    categorynameku = json?['category_name_ku'];
    categoryimg = json?['category_img'];
    categoryParent = json?['category_parent'];
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryid;
    data['category_type'] = categorytype;
    data['category_name_ar'] = categorynamear;
    data['category_name_en'] = categorynameen;
    data['category_name_ku'] = categorynameku;
    data['category_img'] = categoryimg;
    data['category_parent'] = categoryParent;
    return data;
  }
}
