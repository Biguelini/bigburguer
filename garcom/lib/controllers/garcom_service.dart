import 'package:garcom/models/garcom_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GarcomService {
  static const url = "http://192.168.198.118:8080/garcom/login";

  static Future<bool> login(Garcom garcom) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(garcom),
      );
      print(response.statusCode);
      return response.statusCode == 200 ? false : true;
    } catch (e) {
      print('opa 123');
      throw Exception("Erro ao carregar inserir " + e.toString());
    }
  }
}
