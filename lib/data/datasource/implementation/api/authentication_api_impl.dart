import 'dart:convert';
import 'dart:io';
import 'package:dendro3/data/datasource/interface/api/authentication_api.dart';
import 'package:dendro3/data/entity/user_entity.dart';
import 'package:dendro3/config/config.dart';
import 'package:dio/dio.dart';

class AuthenticationApiImpl implements AuthenticationApi {
  @override
  Future<UserEntity> login(String identifiant, String password) async {
    final options = {
      'login': identifiant,
      'password': password,
      'id_application': 1
    };

    var apiBase = Config.apiBase;
    try {
      Response response = await Dio().post("$apiBase/auth/login",
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }),
          data: jsonEncode(options));

      if (response.statusCode == 200) {
        final data = response.data;
        if (data != null && data['user'] != null) {
          return data['user'] as UserEntity;
        } else {
          throw Exception("Invalid response data: ${response.data}");
        }
      } else {
        throw Exception("Failed to login: ${response.statusCode}");
      }
    } catch (e) {
      // Log the error or handle it accordingly
      print("Login error: $e");
      rethrow;
    }
  }
}
