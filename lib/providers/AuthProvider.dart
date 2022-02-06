import 'package:flutter/material.dart';
import 'package:moodbasemedia/services/Api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  late bool isAuthenticated = false;
  late String token;

  late ApiService apiService;

  AuthProvider() {
    init();
  }

  Future<void> init() async {
    token = await getToken();
    if (token.isNotEmpty) {
      isAuthenticated = true;
    }
    apiService = new ApiService(token);

    notifyListeners();
  }

  Future<void> setToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  Future<void> register(String name, String email, String password,
      String confirmPassword, String deviceName) async {
    token = await apiService.register(
        name, email, password, confirmPassword, deviceName);
    setToken(token);

    isAuthenticated = true;
  }

  Future<void> login(String email, String password, String deviceName) async {
    token = await apiService.login(email, password, deviceName);
    setToken(token);
    isAuthenticated = true;
    notifyListeners();
  }

  Future<void> logOut() async {
    token = '';
    setToken(token);
    isAuthenticated = false;
    notifyListeners();
  }
}
