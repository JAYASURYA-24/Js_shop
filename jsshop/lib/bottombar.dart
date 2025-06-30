import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:jsshop/cartpage.dart';
import 'package:jsshop/profile.dart';
import 'package:jsshop/shoppage.dart';
import 'package:jsshop/themeprovider.dart';
import 'package:jsshop/utils/colors.dart';
import 'package:provider/provider.dart';

class Bottomnavbar extends StatefulWidget {
  const Bottomnavbar({Key? key}) : super(key: key);

  @override
  State<Bottomnavbar> createState() => _BottomnavbarPageState();
}

class _BottomnavbarPageState extends State<Bottomnavbar> {
  final _pageController = PageController(initialPage: 1);

  final NotchBottomBarController _controller =
      NotchBottomBarController(index: 1);

  int maxCount = 3;

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> bottomBarPages = [
      CartScreen(),
      ShoppingTabs(),
      Profilescreen()
    ];
    return Consumer<ThemeProvider>(builder: (context, themepro, child) {
      return Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
              bottomBarPages.length, (index) => bottomBarPages[index]),
        ),
        extendBody: true,
        bottomNavigationBar: (bottomBarPages.length <= maxCount)
            ? AnimatedNotchBottomBar(
                notchBottomBarController: _controller,
                color: themepro.isDarkMode
                    ? AppColors.darkbotmColor
                    : AppColors.lightbotmColor,
                showLabel: true,
                textOverflow: TextOverflow.visible,
                maxLine: 1,
                shadowElevation: 5,
                kBottomRadius: 28.0,

                // notchShader: const SweepGradient(
                //   startAngle: 0,
                //   endAngle: pi / 2,
                //   colors: [Colors.red, Colors.green, Colors.orange],
                //   tileMode: TileMode.mirror,
                // ).createShader(Rect.fromCircle(center: Offset.zero, radius: 8.0)),
                notchColor: themepro.isDarkMode
                    ? AppColors.darkBtnColor
                    : AppColors.lightAIconColor,

                removeMargins: false,
                bottomBarWidth: 500,
                showShadow: false,
                durationInMilliSeconds: 300,

                itemLabelStyle: const TextStyle(fontSize: 12),

                elevation: 1,
                bottomBarItems: [
                  BottomBarItem(
                    inActiveItem: Icon(
                      Icons.shopping_cart_rounded,
                      color: themepro.isDarkMode
                          ? AppColors.darkIconColor
                          : AppColors.lightIIconColor,
                    ),
                    activeItem: Icon(
                      Icons.shopping_cart_rounded,
                      color: Colors.white,
                    ),
                    itemLabel: 'Cart',
                  ),
                  BottomBarItem(
                    inActiveItem: Icon(
                      Icons.home_rounded,
                      color: themepro.isDarkMode
                          ? AppColors.darkIconColor
                          : AppColors.lightIIconColor,
                    ),
                    activeItem: Icon(
                      Icons.home_rounded,
                      color: Colors.white,
                    ),
                    itemLabel: 'Home',
                  ),
                  BottomBarItem(
                    inActiveItem: Icon(
                      Icons.account_circle_rounded,
                      color: themepro.isDarkMode
                          ? AppColors.darkIconColor
                          : AppColors.lightIIconColor,
                    ),
                    activeItem: Icon(
                      Icons.account_circle_rounded,
                      color: Colors.white,
                    ),
                    itemLabel: 'Profile',
                  ),
                ],
                onTap: (index) {
                  _pageController.jumpToPage(index);
                },
                kIconSize: 24.0,
              )
            : null,
      );
    });
  }
}
