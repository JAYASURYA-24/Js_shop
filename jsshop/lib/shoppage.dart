import 'package:flutter/material.dart';

import 'package:jsshop/productdetails.dart';
import 'package:jsshop/productprovider.dart';
import 'package:jsshop/themeprovider.dart';
import 'package:jsshop/utils/colors.dart';
import 'package:provider/provider.dart';

class ShoppingTabs extends StatefulWidget {
  @override
  _ShoppingTabsState createState() => _ShoppingTabsState();
}

class _ShoppingTabsState extends State<ShoppingTabs> {
  @override
  void initState() {
    super.initState();

    Provider.of<ProductProvider>(context, listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("JS Shopping"),
          actions: [
            Transform.scale(
              scale: 0.75,
              child: Switch(
                splashRadius: 3,
                value: context.watch<ThemeProvider>().isDarkMode,
                onChanged: (bool value) {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme();
                },
              ),
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              SizedBox(width: 80, child: Tab(text: "All")),
              SizedBox(width: 80, child: Tab(text: "Beauty")),
              SizedBox(width: 80, child: Tab(text: "Groceries")),
              SizedBox(width: 80, child: Tab(text: "Furniture")),
              SizedBox(width: 80, child: Tab(text: "Fragrances")),
            ],
          ),
        ),
        body: Consumer<ProductProvider>(
          builder: (context, productProvider, child) {
            final products = productProvider.products;

            if (products.isEmpty) {
              return Center(child: CircularProgressIndicator());
            }

            return TabBarView(
              children: [
                ProductsGridView(category: 'All', products: products),
                ProductsGridView(category: 'Beauty', products: products),
                ProductsGridView(category: 'Groceries', products: products),
                ProductsGridView(category: 'Furniture', products: products),
                ProductsGridView(category: 'Fragrances', products: products),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ProductsGridView extends StatelessWidget {
  final String category;
  final List<Product> products;

  ProductsGridView({required this.category, required this.products});

  @override
  Widget build(BuildContext context) {
    final themepro = Provider.of<ThemeProvider>(context);
    final categoryProducts = products.where((product) {
      if (category == 'All') {
        return true;
      } else {
        return product.category.toLowerCase().contains(category.toLowerCase());
      }
    }).toList();

    return GridView.builder(
        padding: EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 3,
          childAspectRatio: 0.85,
        ),
        itemCount: categoryProducts.length,
        itemBuilder: (context, index) {
          final product = categoryProducts[index];
          String formattedPrice = product.getFormattedPrice(product.price);

          return InkWell(
            onTap: () {
              _showProductDetails(context, product);
            },
            child: Card(
              elevation: 4,
              child: Stack(children: [
                Positioned(
                  top: 10,
                  left: 10,
                  child: CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 228, 168, 168),
                    radius: 18,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${product.discountPercentage} %",
                            style: TextStyle(
                                fontSize: 8,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Off",
                            style: TextStyle(
                                fontSize: 8,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      Image.network(product.images[0],
                          height: 120, fit: BoxFit.cover),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            product.title,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Text("Rs.$formattedPrice"),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            themepro.isDarkMode
                                ? AppColors.darkBtnColor
                                : AppColors.lightBtnColor,
                          ),
                        ),
                        onPressed: () {
                          color:
                          _showProductDetails(context, product);
                        },
                        child: Text('View Details',
                            style: TextStyle(
                              color: themepro.isDarkMode
                                  ? AppColors.darkTextColor
                                  : AppColors.lightTextColor,
                            )),
                      ),
                    ],
                  ),
                )
              ]),
            ),
          );
        });
  }
}

void _showProductDetails(BuildContext context, Product product) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ProductDetailsScreen(product: product),
    ),
  );
}
