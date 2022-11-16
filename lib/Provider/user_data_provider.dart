import 'package:downloadfile/MVVM/Models/login_model.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataProvider extends ChangeNotifier {
  LoginModel? _userData;
  LoginModel? get userData => _userData;
  Future<void> saveUserData(LoginModel data) async {
    SharedPreferences loginData = await SharedPreferences.getInstance();
    loginData.setString("user", loginModelToJson(data));
    updateData(data);
  }

  void updateData(LoginModel data) {
    _userData = data;
    notifyListeners();
  }

  Future<String?> getUserData() async {
    SharedPreferences loginData = await SharedPreferences.getInstance();
    String? userSavedData = loginData.getString("user");
    return userSavedData;
  }

  void clearUserData() async {
    SharedPreferences loginData = await SharedPreferences.getInstance();
    loginData.clear();
  }
}

class SelectedSoceityProvider extends ChangeNotifier {
  String? selectedSoceity, id;

  SelectedSoceityProvider({this.selectedSoceity, this.id});
  void updateSelectedSociety(String value, String idNo) {
    selectedSoceity = value;
    id = idNo;
    notifyListeners();
  }
}
