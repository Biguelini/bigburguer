import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garcom/controllers/pedido_service.dart';
import 'package:garcom/models/pedido_model.dart';

class TablePedidos extends StatefulWidget {
  const TablePedidos({Key? key}) : super(key: key);

  @override
  State<TablePedidos> createState() => _TablePedidosState();
}

class _TablePedidosState extends State<TablePedidos> {
  List<Map<String, dynamic>> _pedidos = [];

  Pedido pedido = Pedido(0, 0, 0, "");
  bool _carregando = true;
  void _listaPedidos() async {
    _pedidos = [];
    final data = await PedidoService.listaPedidos();
    setState(() {
      for (var p in data) {
        _pedidos.add(<String, dynamic>{
          "id": p.id,
          "idMesa": p.idMesa,
          "idPrato": p.idPrato,
          "status": p.status
        });
      }
      _carregando = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _listaPedidos();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Pedidos'),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                text: 'Pedidos',
              ),
              Tab(text: 'Fazer pedido'),
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
                        itemCount: _pedidos.length,
                        itemBuilder: (context, index) => Card(
                          margin: const EdgeInsets.all(15),
                          child: ListTile(
                              title: Text((_pedidos[index]['id']).toString()),
                              subtitle:
                                  Text((_pedidos[index]['idMesa']).toString()),
                              trailing: const SizedBox(
                                width: 100,
                              )),
                        ),
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Container(
                  child: Column(
                children: const [
                  TextField(
                    decoration: InputDecoration(
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
                  TextField(
                    decoration: InputDecoration(
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
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}
