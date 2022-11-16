import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:downloadfile/MVVM/Models/details_model.dart';
import 'package:downloadfile/MVVM/Repo/api_status.dart';
import 'package:downloadfile/utils/utils.dart';
import 'package:http/http.dart' as http;

class DetailsService {
  static Future<Object> getDetails(String code, String id, String token) async {
    try {
      var url = Uri.parse("$domainName/api/scan/scancode?$code&society_id=$id");
      Map<String, String> headers = {
        "last_login_token": token,
      };
      var response = await http
          .get(url, headers: headers)
          .timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        return Success(
            response.statusCode, detailsModelFromJson(response.body));
      }
      return Failure(response.statusCode, jsonDecode(response.body)["message"]);
    } on TimeoutException {
      return Failure(
          100, "Server took too long to respond!!\n\nPlease try again");
    } on HttpException {
      return Failure(101, "No internet");
    } on FormatException {
      return Failure(102, "Invalid format");
    } catch (e) {
      return Failure(103, "Unknown Error");
    }
  }
}
