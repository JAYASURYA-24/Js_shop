import 'package:flutter/material.dart';
import 'package:jsshop/bottombar.dart';
import 'package:jsshop/form.dart';
import 'package:jsshop/loginprovider.dart';
import 'package:jsshop/themeprovider.dart';
import 'package:jsshop/utils/colors.dart';
import 'package:provider/provider.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<LoginProvider, ThemeProvider>(
        builder: (context, loginpro, themepro, child) {
      return SafeArea(
        child: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(height: 20),
                  Formwidget(
                    controller: loginpro.name,
                    label: "Name",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Formwidget(
                    controller: loginpro.mail,
                    label: "Mail",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Formwidget(
                    controller: loginpro.pass,
                    label: "Pass",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          themepro.isDarkMode
                              ? AppColors.darkBtnColor
                              : AppColors.lightBtnColor,
                        ),
                      ),
                      onPressed: () {
                        if (loginpro.name.text.isNotEmpty &&
                            loginpro.pass.text.isNotEmpty &&
                            loginpro.mail.text.isNotEmpty) {
                          loginpro.islogin = true;
                          loginpro.addDetails(
                            loginpro.name.text,
                            loginpro.pass.text,
                            loginpro.mail.text,
                          );

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Bottomnavbar()));
                          loginpro.name.clear();
                          loginpro.pass.clear();
                          loginpro.mail.clear();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.green,
                            content:
                                Center(child: Text("Please fill all fields")),
                          ));
                        }
                      },
                      // color: Colors.blue,
                      child: Text("Submit",
                          style: TextStyle(
                            color: themepro.isDarkMode
                                ? AppColors.darkTextColor
                                : AppColors.lightTextColor,
                          )))
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
