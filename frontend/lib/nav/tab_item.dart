import 'package:flutter/material.dart';

enum TabItem { home, addPatient, settings }

const Map<TabItem, String> tabName = {
  TabItem.home: 'home',
  TabItem.addPatient: 'addPatient',
  TabItem.settings: 'settings',
};

const Map<TabItem, MaterialColor> activeTabColor = {
  TabItem.home: Colors.red,
  TabItem.addPatient: Colors.green,
  TabItem.settings: Colors.blue,
};
