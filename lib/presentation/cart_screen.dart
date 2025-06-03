import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/models/cart_item_model.dart';
import 'package:flutter_application_1/data/models/product_model.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> _cartItems = [];
  double _total = 0.0;

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  void _loadCartItems() {
    _cartItems = [
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
    ];
    _calculateTotal();
  }

  void _calculateTotal() {
    _total = _cartItems.fold(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shopping Cart')),
      body: _cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Your cart is empty',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _cartItems.length,
                    itemBuilder: (context, index) {
                      final item = _cartItems[index];
                      return Card(
                        margin: EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Container(
                            width: 60,
                            height: 60,
                            color: Colors.grey[200],
                            child: Icon(Icons.image, color: Colors.grey),
                          ),
                          title: Text(item.product.name),
                          subtitle: Text(
                            '\$${item.product.price.toStringAsFixed(2)}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () => _updateQuantity(index, -1),
                                icon: Icon(Icons.remove),
                              ),
                              Text('${item.quantity}'),
                              IconButton(
                                onPressed: () => _updateQuantity(index, 1),
                                icon: Icon(Icons.add),
                              ),
                              IconButton(
                                onPressed: () => _removeItem(index),
                                icon: Icon(Icons.delete, color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, -3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '\$${_total.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _cartItems.isNotEmpty
                              ? _createOrder
                              : null,
                          child: Text('Place Order'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  void _updateQuantity(int index, int change) {
    setState(() {
      _cartItems[index].quantity += change;
      if (_cartItems[index].quantity <= 0) {
        _cartItems.removeAt(index);
      }
    });
    _calculateTotal();
  }

  void _removeItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
    _calculateTotal();
  }

  void _createOrder() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Order placed successfully!')));

    setState(() {
      _cartItems.clear();
      _total = 0.0;
    });
  }
}
