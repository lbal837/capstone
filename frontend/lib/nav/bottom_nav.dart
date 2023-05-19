import 'package:flutter/material.dart';
import 'package:frontend/nav/tab_item.dart';

import '../auth/user_service.dart';
import '../domain/patient.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation(
      {super.key, required this.currentTab, required this.onSelectTab});
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(TabItem.home),
        _buildItem(TabItem.addPatient),
        _buildItem(TabItem.settings),
      ],
      onTap: (index) => onSelectTab(
        TabItem.values[index],
      ),
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    return BottomNavigationBarItem(
      icon: const Icon(
        Icons.layers,
        color: Colors.purple,
      ),
      label: tabName[tabItem],
    );
  }
}
