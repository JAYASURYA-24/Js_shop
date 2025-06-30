import 'package:flutter/material.dart';
import 'package:jsshop/cartprovider.dart';
import 'package:jsshop/productdetails.dart';
import 'package:jsshop/productprovider.dart';
import 'package:jsshop/themeprovider.dart';
import 'package:jsshop/utils/colors.dart';

import 'package:provider/provider.dart';

class Yourorders extends StatefulWidget {
  const Yourorders({super.key});

  @override
  State<Yourorders> createState() => _YourordersState();
}

class _YourordersState extends State<Yourorders> {
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, CartProvider>(
        builder: (context, themepro, cart, child) {
      return Scaffold(
        appBar: AppBar(title: Text("Your Orders")),
        body: cart.placedOrders.isEmpty
            ? Center(child: Text("No items in cart"))
            : ListView.builder(
                itemCount: cart.placedOrders.length,
                itemBuilder: (context, index) {
                  final item = cart.placedOrders[index];
                  var rprice = item.getFormattedPrice(item.price);

                  return Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: InkWell(
                      onTap: () {
                        _showProductDetails(context, item);
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Image.network(item.images[0],
                                      height: 60, fit: BoxFit.cover),
                                ],
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.title),
                                    Row(
                                      children: [
                                        Text("Rs. $rprice".toString()),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                          themepro.isDarkMode
                                              ? AppColors.darkBtnColor
                                              : AppColors.lightBtnColor)),
                                  onPressed: () {
                                    _showProductDetails(context, item);
                                  },
                                  child: Text('Buy\nAgain',
                                      style: TextStyle(
                                          color: themepro.isDarkMode
                                              ? AppColors.darkTextColor
                                              : AppColors.lightTextColor)),
                                ),
                              ])
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      );
    });
  }

  void _showProductDetails(BuildContext context, Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(product: product),
      ),
    );
  }
}
