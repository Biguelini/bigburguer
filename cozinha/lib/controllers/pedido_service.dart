import 'package:cozinha/models/pedido_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PedidoService {
  static const url = "http://192.168.1.11:8080/admin/pedidos";
  static Future<List<Pedido>> listaPedidosEsperando() async {
    try {
      List<Pedido> listaPedido = [];
      final response = await http.get(Uri.parse('$url/esperando'));
      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        decodeJson.forEach((item) => listaPedido.add(Pedido.fromJson(item)));
        return listaPedido;
      } else {
        throw Exception("Erro ao carregar dados 1");
      }
    } catch (e) {
      throw Exception("Erro ao carregar dados 2 $e");
    }
  }

  static Future<List<Pedido>> listaPedidosPronto() async {
    try {
      List<Pedido> listaPedido = [];
      final response = await http.get(Uri.parse('$url/pronto'));
      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        decodeJson.forEach((item) => listaPedido.add(Pedido.fromJson(item)));
        return listaPedido;
      } else {
        throw Exception("Erro ao carregar dados 1");
      }
    } catch (e) {
      throw Exception("Erro ao carregar dados 2 $e");
    }
  }

  static Future<List<Pedido>> listaPedidosEntregue() async {
    try {
      List<Pedido> listaPedido = [];
      final response = await http.get(Uri.parse('$url/entregue'));
      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        decodeJson.forEach((item) => listaPedido.add(Pedido.fromJson(item)));
        return listaPedido;
      } else {
        throw Exception("Erro ao carregar dados 1");
      }
    } catch (e) {
      throw Exception("Erro ao carregar dados 2 $e");
    }
  }

  static Future<bool> insere(Pedido pedido) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(pedido),
      );

      return response.statusCode == 200 ? true : false;
    } catch (e) {
      throw Exception("Erro ao carregar inserir $e");
    }
  }
}
