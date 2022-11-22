import 'package:cozinha/controllers/url.dart';
import 'package:cozinha/models/pedido_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PedidoService {
  static const url = "http://$urlip:8080/admin/pedidos";
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

  static Future<List<Pedido>> listaPedidosEmPreparo() async {
    try {
      List<Pedido> listaPedido = [];
      final response = await http.get(Uri.parse('$url/empreparo'));
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

  static Future<bool> atualizaStatus(id) async {
    try {
      final response = await http.get(Uri.parse('$url/atualizaStatus/$id'));
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("Erro ao carregar dados 1");
      }
    } catch (e) {
      throw Exception("Erro ao carregar dados 2 $e");
    }
  }
}
