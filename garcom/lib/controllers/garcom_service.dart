import 'package:garcom/models/garcom_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GarcomService {
  static const url = "http://localhost:8080/garcom/login";
  static Future<bool> login(Garcom garcom) async {
    try {
      // final response = await http.post(
      //   Uri.parse(url),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      //   body: jsonEncode(garcom),
      // );
      // return response.statusCode == 200 ? 0 : 1;
      return garcom.login == 'teste' && garcom.senha == 'teste' ? false : true;
    } catch (e) {
      throw Exception("Erro ao carregar inserir " + e.toString());
    }
  }
}
