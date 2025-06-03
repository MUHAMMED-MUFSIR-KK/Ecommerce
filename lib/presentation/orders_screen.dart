import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/models/cart_item_model.dart';
import 'package:flutter_application_1/data/models/order_model.dart';
import 'package:flutter_application_1/data/models/product_model.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order> _orders = [];

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  void _loadOrders() {
    _orders = [
      Order(
        id: 'ORD001',
        items: [
          CartItem(
            product: Product(
              id: '1',
              name: 'iPhone 13',
              description: 'Latest iPhone',
              price: 999.99,
              imageUrl: '',
              category: 'Electronics',
              stock: 10,
            ),
            quantity: 1,
          ),
        ],
        total: 999.99,
        orderDate: DateTime.now().subtract(Duration(days: 2)),
        status: 'Delivered',
      ),
      Order(
        id: 'ORD002',
        items: [
          CartItem(
            product: Product(
              id: '2',
              name: 'T-Shirt',
              description: 'Cotton T-Shirt',
              price: 29.99,
              imageUrl: '',
              category: 'Clothing',
              stock: 25,
            ),
            quantity: 2,
          ),
        ],
        total: 59.98,
        orderDate: DateTime.now().subtract(Duration(days: 5)),
        status: 'Shipped',
      ),
    ];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Orders')),
      body: _orders.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.receipt_long, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No orders yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _orders.length,
              itemBuilder: (context, index) {
                final order = _orders[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ExpansionTile(
                    title: Text('Order #${order.id}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date: ${order.orderDate.day}/${order.orderDate.month}/${order.orderDate.year}',
                        ),
                        Text('Total: \${order.total.toStringAsFixed(2)}'),
                        Text(
                          'Status: ${order.status}',
                          style: TextStyle(
                            color: _getStatusColor(order.status),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Items:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            ...order.items
                                .map(
                                  (item) => Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 4.0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            '${item.product.name} x${item.quantity}',
                                          ),
                                        ),
                                        Text(
                                          '\${(item.product.price * item.quantity).toStringAsFixed(2)}',
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '\${order.total.toStringAsFixed(2)}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return Colors.green;
      case 'shipped':
        return Colors.blue;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
