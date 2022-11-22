import 'package:garcom/models/garcom_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './url.dart';

class GarcomService {
<<<<<<< HEAD
  static const url = "http://"+urlip+":8080/garcom/login";
=======
  static const url = "http://192.168.198.118:8080/garcom/login";
>>>>>>> e78e5cfe4e92a355aeb195bfc8b1e3461d109689

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
      throw Exception("Erro ao carregar inserir " + e.toString());
    }
  }
}
