import 'package:moodbasemedia/activities/TestPage.dart';
import 'package:moodbasemedia/activities/dashboard.dart';
import 'package:moodbasemedia/models/OwnerResponse.dart';
import 'package:flutter/material.dart';
import 'package:moodbasemedia/activities/owners.dart';
import 'package:moodbasemedia/providers/AuthProvider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> widgetOptions = [Dashboard(), Owners(), TestPage()];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to DVM Dashboard',
      theme: ThemeData.from(colorScheme: ColorScheme.light()),
      home: Scaffold(
        body: widgetOptions.elementAt(selectedIndex),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 4,
          child: BottomNavigationBar(
            backgroundColor: Color(0xff3700b3),
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.black,
            elevation: 0,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list_alt),
                label: 'Playlist',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.image_sharp),
                label: 'Upload',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.logout_outlined),
                label: 'Logout',
              ),
            ],
            currentIndex: selectedIndex,
            onTap: onItemTapped,
          ),
        ),
      ),
    );
  }

  void onItemTapped(int index) {
    if (index == 3) {
      AuthProvider authProvider =
          Provider.of<AuthProvider>(context, listen: false);
      authProvider.logOut();
    } else {
      setState(() {
        selectedIndex = index;
      });
    }
  }
}
