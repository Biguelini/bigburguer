import 'package:cozinha/models/garcom_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './url.dart';

class GarcomService {
  static const url = "http://$urlip:8080/cozinha/login";

  static Future<bool> login(Garcom garcom) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(garcom),
      );
      return response.statusCode == 200 ? false : true;
    } catch (e) {
      throw Exception("Erro ao carregar inserir $e");
    }
  }
}
