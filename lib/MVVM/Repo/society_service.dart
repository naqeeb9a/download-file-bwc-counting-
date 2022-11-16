import 'dart:convert';
import 'dart:io';

import 'package:downloadfile/MVVM/Models/society_model.dart';
import 'package:downloadfile/MVVM/Repo/api_status.dart';
import 'package:downloadfile/utils/utils.dart';
import 'package:http/http.dart' as http;

class SocietyService {
  static Future<Object> getSocieties() async {
    try {
      var url = Uri.parse("$domainName/api/scan/get-societies");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return Success(
            response.statusCode, societyModelFromJson(response.body));
      }
      return Failure(response.statusCode, jsonDecode(response.body));
    } on HttpException {
      return Failure(101, "No internet");
    } on FormatException {
      return Failure(102, "Invalid format");
    } catch (e) {
      return Failure(103, "Unknown Error");
    }
  }
}
