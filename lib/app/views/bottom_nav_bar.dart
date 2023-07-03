import 'package:chopspick/app/controllers/basket_controller.dart';
import 'package:chopspick/app/views/home_page/home_page.dart';
import 'package:chopspick/app/views/profile_page.dart';
import 'package:chopspick/app/views/search_page.dart';
import 'package:chopspick/core/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'basket_page/basket_page.dart';
import 'package:badges/badges.dart' as badges;

PersistentTabController _controller = PersistentTabController(initialIndex: 0);

goToPage(int index) {
  _controller.jumpToTab(index);
}

BasketController basketController = Get.find();

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
      onItemSelected: (int index) {
        currentIndex.value = index;
      },
      backgroundColor: Colors.white,
      navBarStyle: NavBarStyle.style12,
    );
  }
}

Widget shoppingCartBadge() {
 RxInt itemsCount=basketController.getItemsCount();

  bool showCartBadge = basketController.basketItemList.isNotEmpty;
  return badges.Badge(
    position: badges.BadgePosition.topEnd(top: -8, end: -10),
    badgeAnimation: const badges.BadgeAnimation.slide(
        // disappearanceFadeAnimationDuration: Duration(milliseconds: 200),
        // curve: Curves.easeInCubic,
        ),
    showBadge: showCartBadge,
    badgeStyle: const badges.BadgeStyle(
      badgeColor: CustomColors.bottomNavBarActiveColor,
    ),
    badgeContent: Text(
      itemsCount().toString(),
      style: const TextStyle(color: Colors.white),
    ),
    child: const Icon(Icons.shopping_cart),
  );
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
      icon: Obx(
        () => shoppingCartBadge(),
      ),
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
