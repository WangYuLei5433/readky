import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:readky/view/utils/app_theme.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final void Function(int) onItemTapped;

  CustomBottomNavigationBar({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  BottomNavigationBarItem buildNavItem({
    required bool isSelected,
    required String iconPath,
    required String filledIconPath,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        isSelected ? filledIconPath : iconPath,
        width: 24,
        height: 24,
      ),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false, // 只适配底部
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: AppTheme.softBorderColor, width: 1)),
          color: Colors.white,
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          backgroundColor: Colors.white,
          currentIndex: widget.selectedIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: widget.onItemTapped,
          items: [
            buildNavItem(
              isSelected: widget.selectedIndex == 0,
              iconPath: 'assets/icons/Home.svg',
              filledIconPath: 'assets/icons/Home-filled.svg',
              label: 'Home',
            ),
            buildNavItem(
              isSelected: widget.selectedIndex == 1,
              iconPath: 'assets/icons/Search.svg',
              filledIconPath: 'assets/icons/Search-filled.svg',
              label: 'Search',
            ),
            buildNavItem(
              isSelected: widget.selectedIndex == 2,
              iconPath: 'assets/icons/Bookmark.svg',
              filledIconPath: 'assets/icons/Bookmark-filled.svg',
              label: 'Bookmark',
            ),
          ],
        ),
      ),
    );
  }
}
