import 'package:flutter/material.dart';
import 'package:jsshop/bottombar.dart';

import 'package:jsshop/cartprovider.dart';
import 'package:jsshop/login.dart';
import 'package:jsshop/loginprovider.dart';
import 'package:jsshop/productprovider.dart';
import 'package:jsshop/themeprovider.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider())
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginpro1 = Provider.of<LoginProvider>(context);
    final themepro = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JS Shopping',
      theme: themepro.isDarkMode ? darkTheme : lightTheme,
      home: loginpro1.islogin ? Bottomnavbar() : Loginscreen(),
    );
  }
}
