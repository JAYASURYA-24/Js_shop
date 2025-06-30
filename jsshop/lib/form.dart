import 'package:flutter/material.dart';
import 'package:jsshop/themeprovider.dart';
import 'package:jsshop/utils/colors.dart';
import 'package:provider/provider.dart';

class Formwidget extends StatelessWidget {
  Formwidget({super.key, required this.controller, required this.label});
  final TextEditingController controller;
  final label;
  @override
  Widget build(BuildContext context) {
    // final GlobalKey<FormState> formkey = GlobalKey<FormState>();
    final themepro = Provider.of<ThemeProvider>(context, listen: false);
    return Builder(builder: (context) {
      return Form(
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    style: BorderStyle.solid,
                    color: themepro.isDarkMode
                        ? AppColors.darkTextColor
                        : AppColors.lightTextColor)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    style: BorderStyle.solid,
                    color: themepro.isDarkMode
                        ? AppColors.darkTextColor
                        : AppColors.lightTextColor)),
            errorBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(style: BorderStyle.solid, color: Colors.red)),
          ),
        ),
      );
    });
  }
}
