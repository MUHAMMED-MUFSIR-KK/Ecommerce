// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/admin/create_product_screen.dart';
import 'package:flutter_application_1/presentation/auth/login_screen.dart'
    show LoginScreen;
import 'package:flutter_application_1/presentation/auth/register_screen.dart';
import 'package:flutter_application_1/presentation/cart_screen.dart';
import 'package:flutter_application_1/presentation/orders_screen.dart';
import 'package:flutter_application_1/presentation/product_details_screen.dart';
import 'package:flutter_application_1/presentation/product_list_screen.dart';
import 'package:flutter_application_1/presentation/user_profile_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-commerce App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
      routes: {
        '/loginScreen': (context) => LoginScreen(),
        '/registerScreen': (context) => RegisterScreen(),
        '/productsListScreen': (context) => ProductListScreen(),
        '/productDetailsScreen': (context) => ProductDetailsScreen(),
        '/createProductScreen': (context) => CreateProductScreen(),
        '/cartScreen': (context) => CartScreen(),
        '/ordersScreen': (context) => OrdersScreen(),
        '/userProfileScreen': (context) => UserProfileScreen(),
      },
    );
  }
}
