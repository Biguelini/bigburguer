import 'package:garcom/models/pedido_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PedidoService {
  static const url = "http://169.254.68.106:8080/admin/pedidos";
  static Future<List<Pedido>> listaPedidos() async {
    try {
      List<Pedido> listaPedido = [];
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        decodeJson.forEach((item) => listaPedido.add(Pedido.fromJson(item)));
        return listaPedido;
      } else {
        throw Exception("Erro ao carregar dados 1");
      }
    } catch (e) {
      throw Exception("Erro ao carregar dados 2 " + e.toString());
    }
  }
}
