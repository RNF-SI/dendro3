import 'dart:convert';
import 'dart:io';

import 'package:dendro3/data/datasource/interface/api/authentication_api.dart';
import 'package:dendro3/data/entity/user_entity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

const String apiBase = "http://10.0.2.2:8000";

class AuthenticationApiImpl implements AuthenticationApi {
  @override
  Future<UserEntity> login(identifiant, password) async {
    final options = {
      'login': identifiant,
      'password': password,
      'id_application': 1
    };

    Response response = await Dio().post("$apiBase/auth/login",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(options));
    return jsonDecode(response.data)['user'];
  }
}
