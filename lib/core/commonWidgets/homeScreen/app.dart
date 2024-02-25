import 'package:flutter/material.dart';
import 'package:torath/core/commonWidgets/homeScreen/tab_item.dart';

import '../../../screens/contactUsScreen/contact_us_screen.dart';
import '../../../screens/favouritesScreen/favourite_screen.dart';
import '../../../screens/homeScreen/home_screen.dart';
import '../../../screens/seraScreen/sera_screen.dart';
import '../../language/text.dart';
import '../../utils/assets_catalog.dart';
import 'bottom_navigation.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> {
  static int currentTab = 0;

  final List<TabItem> tabs = [
    TabItem(
      tabName: ArabicText.mainHome,
      icon: AssetsCatalog.navBarHomeIcon,
      page: const HomeScreen(),
    ),
    TabItem(
      tabName: ArabicText.favourite,
      icon: AssetsCatalog.favIcon,
      page: const FavouriteScreen(),
    ),
    TabItem(
      tabName: ArabicText.sera,
      icon: AssetsCatalog.seraIcon,
      page: const SeraScreen(),
    ),
    TabItem(
      tabName: ArabicText.contactUs,
      icon: AssetsCatalog.contactUsIcon,
      page: const ContactUsScreen(),
    ),
  ];

  AppState() {
    // indexing is necessary for proper funcationality
    // of determining which tab is active
    tabs.asMap().forEach((index, details) {
      details.setIndex(index);
    });
  }

  void _selectTab(int index) {
    if (index == currentTab) {
      // pop to first route
      // if the user taps on the active tab
      tabs[index].key.currentState?.popUntil((route) => route.isFirst);
    } else {
      // update the state
      // in order to repaint
      setState(() => currentTab = index);
    }
  }
  @override
  Widget build(BuildContext context) {
    // WillPopScope handle android back btn
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
        !await tabs[currentTab].key.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          if (currentTab != 0) {
            // select 'main' tab
            _selectTab(0);
            // back button handled by app
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      // this is the base scaffold
      // don't put appbar in here otherwise you might end up
      // with multiple appbars on one screen
      // eventually breaking the app
      child: Scaffold(
        // indexed stack shows only one child
        body: IndexedStack(
          index: currentTab,
          children: tabs.map((e) => e.page).toList(),
        ),
        // Bottom navigation
        bottomNavigationBar: BottomNavigation(
          onSelectTab: _selectTab,
          tabs: tabs,
        ),
      ),
    );
  }
}
