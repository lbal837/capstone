import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomBottomNavigationBar(
      {Key? key, required this.selectedIndex, required this.onItemSelected})
      : super(key: key);

  @override
  CustomBottomNavigationBarState createState() =>
      CustomBottomNavigationBarState();
}

class CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.group),
          label: 'Patients Portal',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Add Patient',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
      ],
      currentIndex: widget.selectedIndex,
      selectedItemColor: Colors.deepPurple,
      unselectedItemColor: Colors.grey,
      onTap: widget.onItemSelected,
    );
  }
}
