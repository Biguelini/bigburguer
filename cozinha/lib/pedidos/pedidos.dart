import 'package:flutter/material.dart';
import 'package:cozinha/controllers/pedido_service.dart';

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
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Pedidos'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              onPressed: () {
                _carregando = true;
                _listaPedidosEsperando();
                _listaPedidosPronto();
                _listaPedidosEntregue();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Atualizado com sucesso!'),
                ));
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login', (Route<dynamic> route) => false);
              },
            )
          ],
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
                              (_pedidosEsperando[index]['prato'].toString()),
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              'Mesa: ${_pedidosEsperando[index]['idMesa']}',
                              style: const TextStyle(color: Colors.white),
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
                              (_pedidosPronto[index]['prato']),
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              'Mesa: ${_pedidosPronto[index]['idMesa']}',
                              style: const TextStyle(color: Colors.white),
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
                              (_pedidosEntregue[index]['prato']),
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle:  Text(
                              'Mesa: ${_pedidosEntregue[index]['idMesa']}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
