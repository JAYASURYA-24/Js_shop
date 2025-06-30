import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jsshop/productprovider.dart';

class ApiService {
  final String baseUrl = 'https://dummyjson.com';

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      List<dynamic> productListJson = json.decode(response.body)['products'];
      return productListJson.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
