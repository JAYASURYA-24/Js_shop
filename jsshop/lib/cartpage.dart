import 'package:flutter/material.dart';
import 'package:jsshop/cartprovider.dart';
import 'package:jsshop/productdetails.dart';
import 'package:jsshop/productprovider.dart';
import 'package:jsshop/themeprovider.dart';
import 'package:jsshop/utils/colors.dart';
import 'package:jsshop/yourorders.dart';
import 'package:provider/provider.dart';

List<Map<String, dynamic>> Item = [
  {"link": "assets/cod-removebg-preview.png", "name": "Cash on\ndeliver"},
  {"link": "assets/gpay.png", "name": "Gpay"},
  {"link": "assets/phonepay-removebg-preview.png", "name": "Phone\npay"},
  {"link": "assets/paytm-removebg-preview.png", "name": "Paytm"},
  {"link": "assets/Netbank.png", "name": "Net\nBanking"},
  {"link": "assets/credit.png", "name": "Credit\nCard"},
  {"link": "assets/debit.png", "name": "Debit\nCard"}
];

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Consumer<ThemeProvider>(builder: (context, themepro, child) {
      return Scaffold(
        appBar: AppBar(title: Text("Your Cart")),
        body: cart.cartItems.isEmpty
            ? Center(child: Text("No items in cart"))
            : ListView.builder(
                itemCount: cart.cartItems.length,
                itemBuilder: (context, index) {
                  final item = cart.cartItems[index];
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
                              Column(
                                children: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                themepro.isDarkMode
                                                    ? AppColors.darkBtnColor
                                                    : AppColors.lightBtnColor)),
                                    onPressed: () {
                                      _showBottomSheet(
                                          context, double.parse(rprice), item);
                                    },
                                    child: Text('Buy',
                                        style: TextStyle(
                                            color: themepro.isDarkMode
                                                ? AppColors.darkTextColor
                                                : AppColors.lightTextColor)),
                                  ),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(themepro
                                                    .isDarkMode
                                                ? AppColors.darklightBtnColor
                                                : AppColors.lightliBtnColor)),
                                    onPressed: () {
                                      _Cancelitem(context, item);
                                    },
                                    child: Text('Remove',
                                        style: TextStyle(
                                            color: themepro.isDarkMode
                                                ? AppColors.darkTextColor
                                                : AppColors.lightTextColor)),
                                  ),
                                ],
                              )
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

  void _showBottomSheet(BuildContext context, var price, Product product) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return _BottomSheetContent(price: price, product: product);
      },
    );
  }

  void _Cancelitem(BuildContext context, var item) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    final themepro = Provider.of<ThemeProvider>(context, listen: false);
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Are you sure want to remove this item from cart?'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              themepro.isDarkMode
                                  ? AppColors.darklightBtnColor
                                  : AppColors.lightliBtnColor)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel",
                          style: TextStyle(
                              color: themepro.isDarkMode
                                  ? AppColors.darkTextColor
                                  : AppColors.lightTextColor))),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                themepro.isDarkMode
                                    ? AppColors.darkBtnColor
                                    : AppColors.lightBtnColor)),
                        onPressed: () {
                          cart.removeFromCart(item);
                          Navigator.pop(context);
                        },
                        child: Text("Yes",
                            style: TextStyle(
                                color: themepro.isDarkMode
                                    ? AppColors.darkTextColor
                                    : AppColors.lightTextColor))),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
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

class _BottomSheetContent extends StatefulWidget {
  final double price;
  final Product product;

  _BottomSheetContent({required this.price, required this.product});

  @override
  _BottomSheetContentState createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<_BottomSheetContent> {
  int quantity = 1;
  late double totalprice;

  @override
  void initState() {
    super.initState();
    totalprice = widget.price * quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themepro, child) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Enter Quantity", style: TextStyle(fontSize: 16)),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 30,
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (quantity > 1) {
                                      quantity--;
                                      totalprice = widget.price * quantity;
                                    }
                                  });
                                },
                                icon: Icon(Icons.remove),
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller:
                                      TextEditingController(text: '$quantity'),
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  onChanged: (value) {
                                    setState(() {
                                      quantity = int.tryParse(value) ?? 1;
                                      totalprice = widget.price * quantity;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(3),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    quantity++;
                                    totalprice = widget.price * quantity;
                                  });
                                },
                                icon: Icon(Icons.add),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Total : ",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                "Rs.${totalprice.toStringAsFixed(2)}",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text("Enter Shipping Address", style: TextStyle(fontSize: 16)),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Address",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                Text("Select Payment Method", style: TextStyle(fontSize: 16)),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      height: 135,
                      width: MediaQuery.of(context).size.width * 1,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: Item.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: themepro.isDarkMode
                                  ? AppColors.darkbotmColor
                                  : AppColors.lightCardColor,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "${Item[index]["link"]}"))),
                                      height: 70,
                                      width: 70,
                                    ),
                                    Text("${Item[index]["name"]}")
                                  ],
                                ),
                              ),
                            );
                          })),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              themepro.isDarkMode
                                  ? AppColors.darklightBtnColor
                                  : AppColors.lightliBtnColor)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel",
                          style: TextStyle(
                              color: themepro.isDarkMode
                                  ? AppColors.darkTextColor
                                  : AppColors.lightTextColor)),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              themepro.isDarkMode
                                  ? AppColors.darkBtnColor
                                  : AppColors.lightBtnColor)),
                      onPressed: () {
                        _placeOrder(context, [widget.product]);
                      },
                      child: Text("Place Order",
                          style: TextStyle(
                              color: themepro.isDarkMode
                                  ? AppColors.darkTextColor
                                  : AppColors.lightTextColor)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

void _placeOrder(BuildContext context, List<Product> cartItems) {
  final cartProvider = Provider.of<CartProvider>(context, listen: false);
  cartProvider.placeOrder(cartItems);

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.green,
    content: Center(child: Text('Order Placed Successfully!')),
  ));

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Yourorders(),
    ),
  );
}
