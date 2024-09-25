class ShopModel {
  List<Suppliers>? suppliers;

  ShopModel({this.suppliers});

  ShopModel.fromJson(Map<String, dynamic>? json) {
    if (json?['suppliers'] != null) {
      suppliers = <Suppliers>[];
      json?['suppliers'].forEach((v) {
        suppliers!.add(Suppliers.fromJson(v));
      });
    }
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (suppliers != null) {
      data['suppliers'] = suppliers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Suppliers {
  String? supplierId;
  String? supplierName;
  String? supplierDescription;
  String? supplierLogo;

  Suppliers(
      {this.supplierId,
      this.supplierName,
      this.supplierDescription,
      this.supplierLogo});

  Suppliers.fromJson(Map<String, dynamic>? json) {
    supplierId = json?['supplier_id'];
    supplierName = json?['supplier_name'];
    supplierDescription = json?['supplier_description'];
    supplierLogo = json?['supplier_logo'];
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['supplier_id'] = supplierId;
    data['supplier_name'] = supplierName;
    data['supplier_description'] = supplierDescription;
    data['supplier_logo'] = supplierLogo;
    return data;
  }
}
