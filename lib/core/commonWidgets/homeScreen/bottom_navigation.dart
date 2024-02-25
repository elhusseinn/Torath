import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:torath/core/commonWidgets/homeScreen/tab_item.dart';

import 'app.dart';

class BottomNavigation extends StatelessWidget {
   BottomNavigation({super.key, required this.onSelectTab, required this.tabs});
  final ValueChanged<int> onSelectTab;
  final List<TabItem> tabs;

   @override
   Widget build(BuildContext context) {
     return BottomNavigationBar(
       type: BottomNavigationBarType.fixed,
       items: tabs
           .map(
             (e) => _buildItem(
           index: e.getIndex(),
           icon: e.icon,
           tabName: e.tabName,
         ),
       )
           .toList(),
       onTap: (index) => onSelectTab(
         index,
       ),
     );
   }

   BottomNavigationBarItem _buildItem(
       {required int index, required String icon, required String tabName}) {
     return BottomNavigationBarItem(
       icon: SvgPicture.asset(
        icon,
       ),
       label: tabName
     );
   }

   Color _tabColor({required int index}) {
     return AppState.currentTab == index ? Colors.cyan : Colors.grey;
   }
}
