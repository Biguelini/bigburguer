import 'package:garcom/models/pedido_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './url.dart';

class PedidoService {
  static const url = "http://" + urlip + ":8080/admin/pedidos";

  static Future<List<Pedido>> listaPedidosEsperando() async {
    try {
      List<Pedido> listaPedido = [];
      final response = await http.get(Uri.parse(url + '/esperando'));
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

  static Future<List<Pedido>> listaPedidosPronto() async {
    try {
      List<Pedido> listaPedido = [];
      final response = await http.get(Uri.parse(url + '/pronto'));
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

  static Future<List<Pedido>> listaPedidosEntregue() async {
    try {
      List<Pedido> listaPedido = [];
      final response = await http.get(Uri.parse(url + '/entregue'));
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

  static Future<List<Pedido>> listaPedidosCancelados() async {
    try {
      List<Pedido> listaPedido = [];
      final response = await http.get(Uri.parse(url + '/cancelados'));
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
      throw Exception("Erro ao carregar inserir " + e.toString());
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

  static Future<bool> cancelar(id) async {
    try {
      final response = await http.get(Uri.parse('$url/cancelar/$id'));
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
