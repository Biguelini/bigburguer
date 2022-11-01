import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:garcom/models/prato_model.dart';

class PratoService {
  static const url = "http://192.168.198.118:8080/admin/pratos";
  static Future<List<Prato>> listaPratos() async {
    try {
      List<Prato> listaPrato = [];
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        decodeJson.forEach((item) => listaPrato.add(Prato.fromJson(item)));
        return listaPrato;
      } else {
        throw Exception("Erro ao carregar dados 1");
      }
    } catch (e) {
      throw Exception("Erro ao carregar dados 2 " + e.toString());
    }
  }
}
