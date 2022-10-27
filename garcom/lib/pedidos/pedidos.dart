import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garcom/controllers/pedido_service.dart';
import 'package:garcom/models/pedido_model.dart';
import 'package:garcom/models/prato_model.dart';

class TablePedidos extends StatefulWidget {
  const TablePedidos({Key? key}) : super(key: key);

  @override
  State<TablePedidos> createState() => _TablePedidosState();
}

class _TablePedidosState extends State<TablePedidos> {
  List<Map<String, dynamic>> _pedidosEsperando = [];
  List<Map<String, dynamic>> _pedidosPronto = [];
  List<Map<String, dynamic>> _pedidosEntregue = [];
  bool _carregando = true;
  Pedido pedido = Pedido(0, 0, "", "esperando");
  final TextEditingController _mesaController = TextEditingController();
  final TextEditingController _produtoController = TextEditingController();
  Future<void> pedir() async {
    telaToPedido();
    bool inserindo = await PedidoService.insere(pedido);
    if (inserindo) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Pedido feito com sucesso!'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Não foi possível pedir!'),
      ));
    }
    _listaPedidosEsperando();
    _listaPedidosPronto();
    _listaPedidosEntregue();
  }

  void telaToPedido() {
    pedido = Pedido(
      0,
      int.parse(_mesaController.text),
      _produtoController.text,
      "esperando",
    );
  }

  void _listaPedidosEsperando() async {
    _pedidosEsperando = [];
    final data = await PedidoService.listaPedidosEsperando();
    setState(() {
      for (var p in data) {
        _pedidosEsperando.add(<String, dynamic>{
          "id": p.id,
          "idMesa": p.idMesa,
          "prato": p.prato,
          "status": p.status
        });
      }
      _carregando = false;
    });
  }

  void _listaPedidosPronto() async {
    _pedidosPronto = [];
    final data = await PedidoService.listaPedidosPronto();
    setState(() {
      for (var p in data) {
        _pedidosPronto.add(<String, dynamic>{
          "id": p.id,
          "idMesa": p.idMesa,
          "prato": p.prato,
          "status": p.status
        });
      }
      _carregando = false;
    });
  }

  void _listaPedidosEntregue() async {
    _pedidosEntregue = [];
    final data = await PedidoService.listaPedidosEntregue();
    setState(() {
      for (var p in data) {
        _pedidosEntregue.add(<String, dynamic>{
          "id": p.id,
          "idMesa": p.idMesa,
          "prato": p.prato,
          "status": p.status
        });
      }
      _carregando = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _listaPedidosEsperando();
    _listaPedidosPronto();
    _listaPedidosEntregue();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Pedidos'),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                text: 'Espera',
              ),
              Tab(
                text: 'Pronto',
              ),
              Tab(
                text: 'Entregue',
              ),
              Tab(
                text: 'Pedir',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              child: _carregando
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(16),
                      child: ListView.builder(
                        itemCount: _pedidosEsperando.length,
                        itemBuilder: (context, index) => Card(
                          margin: const EdgeInsets.all(15),
                          child: ListTile(
                            title: Text(
                              'Mesa: ' +
                                  (_pedidosEsperando[index]['prato']),
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              ((_pedidosEsperando[index]['idMesa']).toString()),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
            Container(
              child: _carregando
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(16),
                      child: ListView.builder(
                        itemCount: _pedidosPronto.length,
                        itemBuilder: (context, index) => Card(
                          margin: const EdgeInsets.all(15),
                          child: ListTile(
                            title: Text(
                              'Mesa: ' +
                                  (_pedidosPronto[index]['prato']),
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              ((_pedidosPronto[index]['idMesa']).toString()),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
            Container(
              child: _carregando
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(16),
                      child: ListView.builder(
                        itemCount: _pedidosEntregue.length,
                        itemBuilder: (context, index) => Card(
                          margin: const EdgeInsets.all(15),
                          child: ListTile(
                            title: Text(
                              'Mesa: ' +
                                  (_pedidosEntregue[index]['prato']),
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              ((_pedidosEntregue[index]['idMesa']).toString()),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 24),
                    child: Text(
                      'Fazer Pedido',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: TextField(
                      controller: _mesaController,
                      decoration: const InputDecoration(
                        hintText: 'Mesa',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(100),
                          ),
                          borderSide: BorderSide(
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: TextField(
                      controller: _produtoController,
                      decoration: const InputDecoration(
                        hintText: 'Produto',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(100),
                          ),
                          borderSide: BorderSide(
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: (() => {pedir()}),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color(0XFFffffff),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
