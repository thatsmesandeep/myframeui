import 'package:projectnext_ui/models/product.dart';

import 'item.dart';
import 'package:uuid/uuid.dart';

class ShoppingCart {
  final orderId = Uuid().v4();

  List<Product> items = [];

  bool get isEmpty => items.isEmpty;
  int get numOfItems => items.length;

  double get totalPrice {
    double totalPrice = 0;
    items.forEach((i) {
      totalPrice += i.price;
    });
    return totalPrice;
  }

  String get formattedTotalPrice {
    if (isEmpty) {
      return Item.formatter.format(0);
    }

    return Item.formatter.format(this.totalPrice);
  }

  bool exists(item) {
    if (items.isEmpty) {
      return false;
    }
    final indexOfItem = items.indexWhere((i) => item.id == i.id);
    return indexOfItem >= 0;
  }

  void add(Product item) {
    if (items.isEmpty) {
      items.add(item);
      return;
    }

    if (!this.exists(item)) {
      items.add(item);
    }
  }

  void remove(Product item) {
    if (items.isEmpty) return;

    final indexOfItem = items.indexWhere((i) => item.id == i.id);
    if (indexOfItem >= 0) {
      items.removeAt(indexOfItem);
    }
  }

  Map<String, dynamic> get toMap {
    final List<Map<String, dynamic>> items = this
        .items
        .map((i) => {
              'id': i.id,
              'name': i.name,
              'description': i.desc,
              'price': i.price,
              'inStock': true,
              'imageUrl': i.imageUrl
            })
        .toList();

    return {"orderId": this.orderId, "items": items, "total": this.totalPrice};
  }
}