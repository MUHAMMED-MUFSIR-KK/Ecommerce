import 'package:flutter_application_1/data/models/cart_item_model.dart';

class Order {
  final String id;
  final List<CartItem> items;
  final double total;
  final DateTime orderDate;
  final String status;

  Order({
    required this.id,
    required this.items,
    required this.total,
    required this.orderDate,
    required this.status,
  });
}
