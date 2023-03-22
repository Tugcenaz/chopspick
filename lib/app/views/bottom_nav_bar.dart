import 'package:chopspick/app/views/home_page/home_page.dart';
import 'package:chopspick/app/views/profile_page.dart';
import 'package:chopspick/app/views/search_page.dart';
import 'package:chopspick/core/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import 'basket_page.dart';

PersistentTabController _controller = PersistentTabController(initialIndex: 0);

class BottomNavigationPage extends StatelessWidget {
   BottomNavigationPage({Key? key}) : super(key: key);
  RxInt currentIndex = _controller.index.obs;

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: _buildScreens(),
      controller: _controller,
      items: _navBarsItems(),
      navBarHeight: 50.h,
      confineInSafeArea: true,
      onItemSelected: (int index){
        currentIndex.value=index;
      },
      backgroundColor: Colors.white,
      navBarStyle: NavBarStyle.style12,
    );
  }
}

List<Widget> _buildScreens() {
  return [
    HomePage(),
    const SearchPage(),
    const BasketPage(),
    const ProfilePage(),
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.home),
      activeColorPrimary: CustomColors.bottomNavBarActiveColor,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.search),
      activeColorPrimary: CustomColors.bottomNavBarActiveColor,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.shopping_cart),
      activeColorPrimary: CustomColors.bottomNavBarActiveColor,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.profile_circled),
      activeColorPrimary: CustomColors.bottomNavBarActiveColor,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),

  ];
}

