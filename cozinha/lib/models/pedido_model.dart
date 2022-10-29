class Pedido {
  int? id;
  int? idMesa;
  String? prato;
  String? status;
  Pedido(
    this.id,
    this.idMesa,
    this.prato,
    this.status,
  );
  Pedido.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idMesa = json['idMesa'];
    prato = json['prato'];
    status = json['status'];
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "id": id,
      "idMesa": idMesa,
      "prato": prato,
      "status": status,
    };
  }
}
