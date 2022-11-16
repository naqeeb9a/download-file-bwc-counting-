import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:downloadfile/MVVM/Models/login_model.dart';
import 'package:downloadfile/MVVM/Repo/api_status.dart';
import 'package:downloadfile/utils/utils.dart';
import 'package:http/http.dart' as http;

class LoginService {
  static Future<Object> loginUser(String username, String password) async {
    try {
      var url = Uri.parse("$domainName/api/scan/login");
      Map<String, String> body = {"username": username, "password": password};
      var response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        return Success(response.statusCode, loginModelFromJson(response.body));
      }
      return Failure(response.statusCode, jsonDecode(response.body)["message"]);
    } on TimeoutException {
      return Failure(100, "Slow Internet try again");
    } on HttpException {
      return Failure(101, "No internet");
    } on FormatException {
      return Failure(102, "Invalid format");
    } catch (e) {
      return Failure(103, "Unknown Error");
    }
  }
}
