import 'package:flutter/material.dart';
import 'package:jsshop/login.dart';
import 'package:jsshop/loginprovider.dart';
import 'package:jsshop/themeprovider.dart';
import 'package:jsshop/utils/colors.dart';
import 'package:jsshop/yourorders.dart';
import 'package:provider/provider.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

late LoginProvider logpro1;

class _ProfilescreenState extends State<Profilescreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logpro1 = Provider.of<LoginProvider>(context, listen: false);
    logpro1.getDetails();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Consumer2<LoginProvider, ThemeProvider>(
        builder: (context, logpro1, themepro, child) {
      return logpro1.isLoading
          ? CircularProgressIndicator()
          : Scaffold(
              appBar: AppBar(
                title: Text("Profile"),
                actions: [
                  IconButton(
                      onPressed: () {
                        Logout(context);
                      },
                      icon: Icon(Icons.logout_rounded))
                ],
              ),
              body: Stack(
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height * 1,
                      color: themepro.isDarkMode
                          ? AppColors.darkScafffoldColor
                          : AppColors.lightScaffoldColor),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 25, 29, 54),
                      Color.fromARGB(255, 28, 33, 75),
                      Color.fromARGB(255, 27, 35, 80),
                    ])),
                  ),
                  Positioned(
                    top: 80,
                    left: 50,
                    right: 50,
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: NetworkImage(
                          "https://cdn.pixabay.com/photo/2021/03/01/09/29/woman-6059236_1280.jpg"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 250),
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Card(
                          color: themepro.isDarkMode
                              ? AppColors.darkbotmColor
                              : AppColors.lightCardColor,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Name ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  logpro1.gname ?? "",
                                  style: TextStyle(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          color: themepro.isDarkMode
                              ? AppColors.darkbotmColor
                              : AppColors.lightCardColor,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Gmail ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  logpro1.gmail,
                                  style: TextStyle(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          color: themepro.isDarkMode
                              ? AppColors.darkbotmColor
                              : AppColors.lightCardColor,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Pass ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  logpro1.gpass,
                                  style: TextStyle(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Yourorders()));
                            },
                            child: Card(
                              color: themepro.isDarkMode
                                  ? AppColors.darkbotmColor
                                  : AppColors.lightCardColor,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  "Your Orders",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                ],
              ));
    }));
  }
}

void Logout(BuildContext context) {
  var logpro1 = Provider.of<LoginProvider>(context, listen: false);
  var themepro = Provider.of<ThemeProvider>(context, listen: false);
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Are you sure want to logout ?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
                    child: Text("Cancel",
                        style: TextStyle(
                            color: themepro.isDarkMode
                                ? AppColors.darkTextColor
                                : AppColors.lightTextColor))),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              themepro.isDarkMode
                                  ? AppColors.darkBtnColor
                                  : AppColors.lightBtnColor)),
                      onPressed: () {
                        logpro1.logout();
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => Loginscreen(),
                          ),
                          (route) => false,
                        );
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
