import 'package:flutter/material.dart';
import 'package:garcom/controllers/pedido_service.dart';
import 'package:garcom/controllers/prato_service.dart';
import 'package:garcom/login/login.dart';
import 'package:garcom/models/pedido_model.dart';

class TablePedidos extends StatefulWidget {
  const TablePedidos({Key? key}) : super(key: key);

  @override
  State<TablePedidos> createState() => _TablePedidosState();
}

class _TablePedidosState extends State<TablePedidos> {
  List<Map<String, dynamic>> _pedidosEsperando = [];
  List<Map<String, dynamic>> _pedidosPronto = [];
  List<Map<String, dynamic>> _pedidosEntregue = [];
  List<Map<String, dynamic>> _pratos = [];
  static List<String> list = ["Selecione o prato"];
  bool _carregando = true;
  Pedido pedido = Pedido(0, 0, "", "esperando");
  final TextEditingController _mesaController = TextEditingController();
  String _produto = "";
  String dropdownValue = list.first;
  void telaToPedido() {
    if (_mesaController.text == "") {
      return;
    }
    pedido = Pedido(
      0,
      int.parse(_mesaController.text),
      _produto,
      "esperando",
    );
  }

  void _listaPratos() async {
    list = ["Selecione o prato"];
    _pratos = [];
    final data = await PratoService.listaPratos();
    setState(() {
      for (var p in data) {
        _pratos.add(<String, dynamic>{
          "id": p.id,
          "nome": p.nome,
          "preco": p.preco,
        });
        list.add(p.nome.toString());
      }
    });
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

  Future<void> pedir() async {
    telaToPedido();
    if (pedido.prato == "" || pedido.prato == "Selecione o prato") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Não foi possível pedir!'),
      ));
      return;
    }
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
    _carregando = true;
    _listaPedidosEsperando();
    _listaPedidosPronto();
    _listaPedidosEntregue();
    _mesaController.text = '';
    _produto = '';
    dropdownValue = list.first;
  }

  @override
  void initState() {
    super.initState();
    _listaPedidosEsperando();
    _listaPedidosPronto();
    _listaPedidosEntregue();
    _listaPratos();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
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
                _listaPratos();
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
                              'Mesa: ' +
                                  ((_pedidosEsperando[index]['idMesa'])
                                      .toString()),
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
                              'Mesa: ' +
                                  ((_pedidosPronto[index]['idMesa'])
                                      .toString()),
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
                            subtitle: Text(
                              'Mesa: ' +
                                  ((_pedidosEntregue[index]['idMesa'])
                                      .toString()),
                              style: const TextStyle(color: Colors.white),
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
                    child: DropdownButtonFormField<String>(
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
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      isExpanded: true,
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue = value!;
                          _produto = dropdownValue;
                        });
                      },
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: (() => {pedir()}),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        'Pedir',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0XFFffffff),
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
