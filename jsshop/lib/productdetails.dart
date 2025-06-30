import 'package:five_pointed_star/five_pointed_star.dart';
import 'package:flutter/material.dart';
import 'package:jsshop/cartpage.dart';
import 'package:jsshop/cartprovider.dart';
import 'package:jsshop/productprovider.dart';
import 'package:jsshop/themeprovider.dart';
import 'package:jsshop/utils/colors.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedPrice = product.getFormattedPrice(product.price);

    return Consumer<ThemeProvider>(builder: (context, themepro, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(product.title),
        ),
        body: Stack(children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CircleAvatar(
                          backgroundColor:
                              const Color.fromARGB(255, 228, 168, 168),
                          radius: 22,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${product.discountPercentage} %",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Off",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Image.network(
                      product.images[0],
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                          product.brand,
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Text(
                      product.description,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                          "Rs.$formattedPrice",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Row(children: [
                      product.stock > 10
                          ? Text(
                              product.availabilityStatus,
                              style: TextStyle(color: Colors.green),
                            )
                          : Text(
                              product.availabilityStatus,
                              style: TextStyle(color: Colors.red),
                            ),
                    ]),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Text("Ratings: "),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: product.rating > 3
                              ? Text(
                                  product.rating.toString(),
                                  style: TextStyle(color: Colors.green),
                                )
                              : Text(
                                  product.rating.toString(),
                                  style: TextStyle(color: Colors.red),
                                ),
                        ),
                        FivePointedStar(
                          defaultSelectedCount: product.rating.toInt(),
                          size: Size(15, 15),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.attach_money,
                                  size: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 2),
                                  child: Text("Cash/Pay on Delivery"),
                                ),
                              ],
                            )),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.repeat_rounded,
                                  size: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 2),
                                  child: Text(product.returnPolicy),
                                ),
                              ],
                            ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.card_travel_sharp,
                                  size: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 2),
                                  child: Text("Js Delivered"),
                                ),
                              ],
                            )),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delivery_dining,
                                  size: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 2),
                                  child: Text("Free Delivery"),
                                ),
                              ],
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Product Details",
                                  style: TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  child: Text(
                                    "Weight",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Text("${product.weight} kg")),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  child: Text(
                                    "Width",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child:
                                        Text("${product.dimensions.width} cm")),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  child: Text(
                                    "Height",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Text(
                                        "${product.dimensions.height} cm")),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  child: Text(
                                    "Depth",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child:
                                        Text("${product.dimensions.depth} cm")),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  child: Text(
                                    "Warrenty",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Text(product.warrantyInformation)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Reviews",
                                  style: TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                            Divider(),
                            SizedBox(
                              height: 300,
                              child: ListView.builder(
                                  itemCount: product.reviews.length,
                                  itemBuilder: (context, index) {
                                    final review = product.reviews[index];
                                    return Column(children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.person,
                                            size: 15,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            child: Text(review.reviewerName),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.email,
                                            size: 15,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            child: Text(review.reviewerEmail),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            size: 15,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            child:
                                                Text(review.rating.toString()),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: FivePointedStar(
                                              defaultSelectedCount:
                                                  review.rating.toInt(),
                                              size: Size(15, 15),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.rate_review,
                                            size: 15,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            child: Text(review.comment),
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                    ]);
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width * 1,
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              color: themepro.isDarkMode
                  ? AppColors.darkbotm1Color
                  : AppColors.lightbotm1Color,
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width * 1,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              themepro.isDarkMode
                                  ? AppColors.darklightBtnColor
                                  : AppColors.lightliBtnColor)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            color: themepro.isDarkMode
                                ? AppColors.darkTextColor
                                : AppColors.lightTextColor),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              themepro.isDarkMode
                                  ? AppColors.darkBtnColor
                                  : AppColors.lightBtnColor)),
                      onPressed: () {
                        Provider.of<CartProvider>(context, listen: false)
                            .addToCart(product);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CartScreen(),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Center(child: Text("Successfully Added to Cart")),
                          backgroundColor: Colors.green,
                        ));
                      },
                      child: Text('Add to Cart',
                          style: TextStyle(
                              color: themepro.isDarkMode
                                  ? AppColors.darkTextColor
                                  : AppColors.lightTextColor)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      );
    });
  }
}
