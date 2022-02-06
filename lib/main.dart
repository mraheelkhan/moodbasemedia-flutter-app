import 'package:moodbasemedia/activities/TestPage.dart';
import 'package:moodbasemedia/activities/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:moodbasemedia/providers/AuthProvider.dart';
import 'package:moodbasemedia/providers/OwnerProvider.dart';
import 'package:moodbasemedia/activities/owners.dart';
import 'package:moodbasemedia/activities/home.dart';
import 'package:moodbasemedia/activities/login.dart';
import 'package:moodbasemedia/activities/register.dart';
import 'package:moodbasemedia/providers/PlayListProvider.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AuthProvider(),
        child: Consumer<AuthProvider>(builder: (context, authProvider, child) {
          return MultiProvider(
              providers: [
                ChangeNotifierProvider<OwnerProvider>(
                    create: (context) => OwnerProvider(authProvider)),
                ChangeNotifierProvider<PlayListProvider>(
                    create: (context) => PlayListProvider(authProvider))
              ],
              child: MaterialApp(
                  title: 'Welcome to Track',
                  initialRoute: '/',
                  routes: {
                    '/': (context) {
                      final authProvider = Provider.of<AuthProvider>(context);
                      if (authProvider.isAuthenticated) {
                        return Home();
                      } else {
                        return Login();
                      }
                    },
                    '/login': (context) => Login(),
                    '/register': (context) => Register(),
                    '/home': (context) => Home(),
                    '/owners': (context) => Owners(),
                    '/testPage': (context) => TestPage(),
                    '/dashboard': (context) => Dashboard(),
                  }));
        }));
  }
}
