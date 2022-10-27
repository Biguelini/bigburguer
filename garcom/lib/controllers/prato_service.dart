import 'package:garcom/models/prato_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PratoService {
  static const url = "http://192.168.198.118:8080/admin/pratos/";
  static Future<String?> localizaPrato(int id) async {
    try {
      Prato prato = Prato(0, 0, "");
      final response = await http.get(Uri.parse(url + id.toString()));
      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        prato = Prato.fromJson(decodeJson);
        return prato.nome;
      } else {
        throw Exception("Erro ao carregar dados 1");
      }
    } catch (e) {
      throw Exception("Erro ao carregar dados 2 " + e.toString());
    }
  }
}
